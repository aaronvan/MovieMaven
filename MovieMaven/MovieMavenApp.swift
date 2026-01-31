//  MovieMavenApp.swift
//  MovieMaven
//

import SwiftUI

@main
struct MovieMavenApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieMaven(viewModel: MovieViewModel())
                    .navigationTitle("Aaron's Movie Maven")
            }
        }
    }
}
