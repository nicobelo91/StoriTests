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
                
                // Movie's poster
                MovieImage(path: movie.posterPath)
                
                Header {
                    Text(movie.title)
                        .font(.headline)
                }
                
                // Shows the rating of the movie in a scale out of 10
                LineRatingView( value: movie.voteAverage)
                
                // Movie's release date
                Text(DateHelper.Formatter.longGMTDate.string(from: movie.releaseDate))
                    .font(.subheader)
                
                // Description of the movie
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
        viewModel.favoriteMovies.contains(where: { $0.id == movie.id }) ? K.removeFromFavorites : K.addToFavorites
    }
    
    private var myListButtonText: String {
        viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? K.removeFromMyList : K.addToMyList
    }
}

extension MovieDetailView {
    //Constants
    enum K {
        static let removeFromFavorites = "Remove from favorites"
        static let addToFavorites = "Add to Favorites"
        static let removeFromMyList = "Remove from My List"
        static let addToMyList = "Add to My List"
    }
}

#Preview {
    MovieDetailView(movie: MovieModel.example)
}
