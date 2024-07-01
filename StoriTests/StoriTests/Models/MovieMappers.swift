//
//  MovieMappers.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 30/06/2024.
//

import Foundation

enum MovieMappers {
    static func apiListToDomain(_ list: MovieList) -> PaginatedMovieModel {
        .init(data: list.results.compactMap(apiToDomain),
              page: list.page,
              totalPages: list.totalPages,
              totalResults: list.totalResults)
    }

    static func apiToDomain(_ model: Movie) -> MovieModel? {
        guard let releaseDate = DateHelper.Formatter.dayComponents.date(from: model.releaseDate) else { return nil }
        
        return .init(
            adult: model.adult,
            backdropPath: model.backdropPath,
            genreIds: model.genreIds.map({$0}),
            id: model.id,
            originalLanguage: model.originalLanguage,
            originalTitle: model.originalTitle,
            overview: model.overview,
            popularity: model.popularity,
            posterPath: model.posterPath,
            releaseDate: releaseDate,
            title: model.title,
            video: model.video,
            voteAverage: model.voteAverage,
            voteCount: model.voteCount
        )
    }
}
