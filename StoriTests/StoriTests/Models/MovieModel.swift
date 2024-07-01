//
//  MovieModel.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 30/06/2024.
//

import Foundation

class MovieModel: Codable, Identifiable {
    var adult: Bool
    var backdropPath: String
    var genreIds: [Int]
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var popularity: Double
    var posterPath: String
    var releaseDate: Date
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int

    var isFavorite = false
    var isInMyList = false
    
    init(adult: Bool, backdropPath: String, genreIds: [Int], id: Int, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String, releaseDate: Date, title: String, video: Bool, voteAverage: Double, voteCount: Int, isFavorite: Bool = false, isInMyList: Bool = false) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.isFavorite = isFavorite
        self.isInMyList = isInMyList
    }
}

typealias PaginatedMovieModel = PaginatedData<MovieModel>


extension MovieModel {
    static let example: MovieModel = .init(
        adult: false,
        backdropPath: "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg",
        genreIds: [18, 80],
        id: 278,
        originalLanguage: "en",
        originalTitle: "The Shawshank Redemption",
        overview: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
        popularity: 163689,
        posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
        releaseDate: .now,
        title: "The Shawshank Redemption",
        video: false,
        voteAverage: 8.7,
        voteCount: 26378
    )
}
