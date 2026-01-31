//  MovieViewModel.swift
//
//  Pure Observation MVVM (no Combine / @Published)
//  ViewModel = MovieViewModel (owns state, behavior, async calls)

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
        if resolvedClient == nil {
            self.errorMessage = "Failed to initialize client."
        }
    }

    func fetchMovie() async {
        let title = movieTitle.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let client else {
            errorMessage = "Failed to initialize client. Please try again."
            movie = nil
            return
        }

        guard !title.isEmpty else {
            errorMessage = "Please enter a movie title."
            movie = nil
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
