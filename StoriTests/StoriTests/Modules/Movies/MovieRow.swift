//
//  MovieRow.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

struct MovieRow: View {
    let movie: MovieModel
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            HStack {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.backdropPath)")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 100, height: 50)
                
                .clipped()
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.body2)
                    Text(DateHelper.Formatter.longGMTDate.string(from: movie.releaseDate))
                        .font(.body1)
                }
            }
        }
        
    }
}

#Preview {
    MovieRow(movie: MovieModel.example)
}
