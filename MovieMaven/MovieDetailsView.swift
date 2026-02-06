//
//  MovieDetailsView.swift
//  MovieMaven
//
//  Created by Aaron VanAlstine on 2/6/26.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title: \(movie.title)")
                .font(.title)
                .fontWeight(.bold)
            Text("Year: \(movie.year)")
                .font(.subheadline)
            Text("Genre: \(movie.genre)")
                .font(.subheadline)

            Divider().padding(.vertical, 5)

            Text("Actors: \(movie.actors)")
            Text("Director: \(movie.director)")

            Divider().padding(.vertical, 5)

            Text("Plot: \(movie.plot)")
                .font(.body)

            if !movie.awards.isEmpty && movie.awards != "N/A" {
                Divider().padding(.vertical, 5)
                HStack {
                    Image(systemName: "trophy.fill")
                        .foregroundColor(.yellow)
                    Text(movie.awards)
                }
            }
        }
    }
}
