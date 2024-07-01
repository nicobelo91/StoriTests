//
//  MovieImage.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 01/07/2024.
//

import SwiftUI

/// Used to show the movie's poster
struct MovieImage: View {
    var path: String
    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(path)")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .scaledToFill()
        .clipped()
    }
}

#Preview {
    MovieImage(path: MovieModel.example.backdropPath)
}
