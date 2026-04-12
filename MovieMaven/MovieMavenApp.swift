//
//  MovieMavenApp.swift
//  Created by Aaron VanAlstine on 1/23/26.
//

import SwiftUI

@main
struct MovieMavenApp: App {
    @State private var viewModel = MovieViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieMaven(viewModel: viewModel)
                    .navigationTitle("Aaron's Movie Maven")
            }
        }
    }
}
