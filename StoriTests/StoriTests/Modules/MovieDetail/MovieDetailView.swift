//
//  MovieDetailView.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    let movie: MovieModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFill()
                .clipped()
                
                HStack {
                    Spacer()
                    Text(movie.title)
                        .font(.headline)
                    Spacer()
                }
                
                LineRatingView( value: movie.voteAverage)
                Text(DateHelper.Formatter.longGMTDate.string(from: movie.releaseDate))
                    .font(.subheader)
                
                Text(movie.overview)
                    .font(.body1)
                    .padding(.bottom, 15)
                
                PrimaryButton(favoriteButtonText) {
                    viewModel.addToFavorites(movie)
                }
                PrimaryButton(myListButtonText, color: .themeGreen) {
                    viewModel.addToMyList(movie)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
       
    }
    
    private var favoriteButtonText: String {
        viewModel.favoriteMovies.contains(where: { $0.id == movie.id }) ? "Remove from favorites" : "Add to Favorites"
    }
    
    private var myListButtonText: String {
        viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? "Remove from My List" : "Add to My List"
    }
}

#Preview {
    MovieDetailView(movie: MovieModel.example)
}
