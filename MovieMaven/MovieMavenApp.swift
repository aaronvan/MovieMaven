//
//  MovieMavenApp.swift
//  Created by Aaron VanAlstine on 1/23/26.
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
