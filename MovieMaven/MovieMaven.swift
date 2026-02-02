//  MovieMaven.swift
//  MovieMaven
//  Created by Aaron VanAlstine on 1/23/26.
//
//  The View (pure Observation MVVM. Represents UI and display data to the user.)

import SwiftUI
import Observation

@MainActor
struct MovieMaven: View {
    @State private var viewModel: MovieViewModel

    init(viewModel: MovieViewModel? = nil) {
        if let viewModel {
            _viewModel = State(initialValue: viewModel)
        } else {
            _viewModel = State(initialValue: MovieViewModel())
        }
    }

    var body: some View {
        // Create bindings to observable properties.
        @Bindable var vm = viewModel

        VStack(alignment: .leading, spacing: 10) {
            TextField("Enter the movie title...", text: $vm.movieTitle)
                .padding()

            HStack {
                Button {
                    Task { await vm.fetchMovie() }
                } label: {
                    Label(vm.isLoading ? "Loading..." : "Get Movie", systemImage: "movieclapper")
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .disabled(vm.isLoading)

                Button("New Search") {
                    vm.reset()
                }
                .buttonStyle(.borderedProminent)
                .disabled(vm.isLoading)
            }

            if vm.isLoading {
                ProgressView()
            }

            if let movie = vm.movie {
                Text("Title: \(movie.title)")
                Text("Year: \(movie.year)")
                Text("Genre: \(movie.genre)")
                Text("Actors: \(movie.actors)")
                Text("Director: \(movie.director)")
                Text("Plot: \(movie.plot)")
                Text("Awards: \(movie.awards)")
            } else if let errorMessage = vm.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }

            Toggle(isOn: $vm.fullPlot) {
                Text("Full Description")
            }
        }
        .padding()
        .frame(width: 400)
    }
}

#Preview {
    MovieMaven()
}
