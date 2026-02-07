//  MovieViewModel.swift
//  Created by Aaron VanAlstine on 1/23/26.
//
//  The ViewModel
//

import Foundation
import Observation

@MainActor
@Observable
final class MovieViewModel {
    // UI state
    var movie: Movie?
    var errorMessage: String?
    var movieTitle: String = ""
    var fullPlot: Bool = false
    var isLoading: Bool = false

    // Dependencies
    private let client: OMDbClient?

    init(client: OMDbClient? = nil) {
        let resolvedClient = client ?? (try? OMDbClient())
        self.client = resolvedClient
    }

    func fetchMovie() async {
        let title = movieTitle.trimmingCharacters(in: .whitespacesAndNewlines)

        // Validate title first so tests expecting title errors pass even without a client
        guard !title.isEmpty else {
            errorMessage = "Please enter a movie title."
            movie = nil
            return
        }

        // Then validate client availability
        guard let client else {
            errorMessage = "OMDb client not available."
            movie = nil
            isLoading = false
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            movie = try await client.performSearch(title: title, plot: fullPlot)
            errorMessage = nil
        } catch {
            movie = nil
            errorMessage = error.localizedDescription
        }
    }

    func reset() {
        movie = nil
        errorMessage = nil
        movieTitle = ""
        fullPlot = false
        isLoading = false
    }
}

