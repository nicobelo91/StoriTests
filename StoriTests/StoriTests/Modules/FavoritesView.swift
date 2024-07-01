//
//  FavoritesView.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    var body: some View {
        NavigationView {
            LoadingView(viewModel.isLoading) {
                if viewModel.favoriteMovies.isEmpty {
                    noFavoritesView
                } else {
                    List(viewModel.favoriteMovies, id: \.id) { movie in
                            MovieRow(movie: movie)
                            .swipeActions(edge: .trailing) {
                                Button(action: {
                                    viewModel.addToFavorites(movie)
                                }) {
                                    Label(K.favorite, systemImage: viewModel.favoriteMovies.contains(where: { $0.id == movie.id }) ? "xmark" : "heart")
                                }
                                .tint(viewModel.favoriteMovies.contains(where: { $0.id == movie.id }) ? .themeGreen2 : .themeDark)
                            }
                    }.listStyle(.plain)
                }
            }
            .navigationTitle(K.favorites)
        }
    }
}

extension FavoritesView {
    
    private var noFavoritesView: some View {
        VStack {
            Spacer()
            Image(systemName: "heart.fill")
                .font(.system(size: 85))
                .padding(.bottom)
            Text(K.addMovie)
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(.themePrimary)
    }
}

extension FavoritesView {
    //Constants
    enum K {
        static let addMovie = "Add a movie to your favorites..."
        static let favorite = "Favorite"
        static let favorites = "Favorites"
    }
}

#Preview {
    FavoritesView()
}
