//
//  MovieMaven.swift
//  Created by Aaron VanAlstine on 1/23/26.
//
//  The main View
//

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
                MovieDetailsView(movie: movie)
            } else if let errorMessage = vm.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            
            Toggle(isOn: $vm.fullPlot) {
                Text("Full Description")
            }
            
        }
        .padding()
        .background(Color.secondary.opacity(0.15))
        .cornerRadius(10)
        .frame(width: 400)
    }
}
        
#Preview {
    MovieMaven()
}
