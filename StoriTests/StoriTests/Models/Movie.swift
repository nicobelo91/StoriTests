//
//  Movie.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import Foundation

struct Movie: APIModel {
    var adult: Bool
    var backdropPath: String
    var genreIDS: [Int]
    var id: Int
    var originalLanguage, originalTitle, overview: String
    var popularity: Double
    var posterPath, releaseDate, title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int

    var isFavorite = false
    var isSaved = false
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

typealias MovieList = DataList<Movie>

extension Movie {
    static let example: Movie = .init(
        adult: false,
        backdropPath: "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg",
        genreIDS: [18, 80],
        id: 278,
        originalLanguage: "en",
        originalTitle: "The Shawshank Redemption",
        overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
        popularity: 163689,
        posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
        releaseDate: "1994-09-23",
        title: "The Shawshank Redemption",
        video: false,
        voteAverage: 8.7,
        voteCount: 26378
    )
}
