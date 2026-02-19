//
//  OMDbClient.swift
//
//  Created by Aaron VanAlstine on 1/29/26.
//

import Foundation
import SwiftDotEnv

struct OMDbClient {
    private let apiKey: String
    private let session: URLSession
    
    // Constants to avoid magic strings
    private enum API {
        static let baseURL = "https://www.omdbapi.com"
        static let apiKeyQuery = "apikey"
        static let titleQuery = "t"
        static let plotQuery = "plot"
    }
    
    // Dependency injection
    // Accepts a URLSession object. If one isn't provided, it defaults to URLSession.shared
    init(session: URLSession = .shared) throws {
        self.session = session
        guard let envURL: URL = Bundle.main.url(forResource: ".env", withExtension: nil) else {
            throw OMDbError.envFileMissing
        }
        // uses the swift-dotenv package to parse the .env file
        guard let apiKey: String = try? DotEnv(path: envURL.path).require("API_KEY") else {
            throw OMDbError.apiKeyMissing
        }
        self.apiKey = apiKey
    }

    func performSearch(title: String, plot: Bool) async throws -> Movie {
        // safely build the URL
        guard var components = URLComponents(string: API.baseURL) else {
            throw OMDbError.invalidURL
        }
        components.queryItems = [
            URLQueryItem(name: API.apiKeyQuery, value: apiKey),
            URLQueryItem(name: API.titleQuery, value: title),
            URLQueryItem(name: API.plotQuery, value: plot ? "full" : "short")
        ]
        
        guard let url = components.url else {
            throw OMDbError.invalidURL
        }

        // fetch the data
        let (data, response) = try await session.data(from: url)
        
        // validate the response
        if let http = response as? HTTPURLResponse, !(200..<300 ~= http.statusCode) {
            throw OMDbError.badServerResponse(statusCode: http.statusCode)
        }
        
        // decode the data
        do {
            return try JSONDecoder().decode(Movie.self, from: data)
        } catch let decodingError as DecodingError {
            throw OMDbError.decodingError(decodingError)
        } catch {
            throw OMDbError.unknownError
        }
    }
}
