//
//  Movie.swift
//  Created by Aaron VanAlstine on 1/23/26.
//

import Foundation

// Model matching OMDb fields for a single title lookup (t=)
struct Movie: Codable, Identifiable {
    var id: String { imdbID }
    let title: String
    let year: String
    let genre: String
    let director: String
    let actors: String
    let plot: String
    let awards: String
    let imdbID: String

    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case awards = "Awards"
        case plot = "Plot"
        case imdbID
    }
}
