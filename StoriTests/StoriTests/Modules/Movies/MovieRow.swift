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
                MovieImage(path: movie.backdropPath)
                .frame(width: 100, height: 50)
                
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
