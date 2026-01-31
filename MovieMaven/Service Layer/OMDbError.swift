//
//  OMDbClientError.swift
//  MovieMaven
//
//  Created by Aaron VanAlstine on 1/30/26.
//

import Foundation

enum OMDbError: Error, LocalizedError {
    case envFileMissing
    case apiKeyMissing
    case invalidURL
    case badServerResponse(statusCode: Int)
    case decodingError(Error)
    case unknownError
 
    var errorDescription: String? {
        switch self {
        case .envFileMissing:
            return "Environment file (.env) not found in the bundle."
        case .apiKeyMissing:
            return "API_KEY not found in the .env file."
        case .invalidURL:
            return "The URL for the request was invalid."
        case .badServerResponse(let statusCode):
            return "The server returned a bad response with status code: \(statusCode)."
        case .decodingError:
            return "Failed to decode the response from the server."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
