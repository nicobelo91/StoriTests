//
//  MovieRow.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            HStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 150)
                .clipped()
                VStack(alignment: .leading) {
                    Text(movie.title)
                    Text(movie.releaseDate)
                }
            }
        }
        
    }
}

#Preview {
    MovieRow(movie: Movie.example)
}
