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
                    NoFavoritesView()
                } else {
                    List(viewModel.favoriteMovies, id: \.id) { movie in
                            MovieRow(movie: movie)
                            .swipeActions(edge: .trailing) {
                                Button(action: {
                                    viewModel.addToFavorites(movie)
                                }) {
                                    Label("Favorite", systemImage: movie.isFavorite ? "heart.fill" : "heart")
                                }
                                .tint(.blue)
                            }
                    }.listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct NoFavoritesView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "heart.fill")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Add a book to your favorites...")
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color(.systemIndigo))
    }
}

#Preview {
    FavoritesView()
}
