//
//  MovieDetailView.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 150)
            .clipped()
            
            Text(movie.title)
                .font(.title)
            Text(movie.releaseDate)
                .font(.body)
            Text("\(movie.voteAverage)")
                .font(.body)
            Text(movie.overview)
                .font(.body)
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie.example)
}
