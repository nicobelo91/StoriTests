//
//  WishlistView.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    var body: some View {
        NavigationView {
            LoadingView(viewModel.isLoading) {
                if viewModel.wishlistMovies.isEmpty {
                    NoSavedView()
                } else {
                    //Text("Saved Items")
                    List {
                        ForEach(viewModel.wishlistMovies, id: \.id) { movie in
                            MovieRow(movie: movie)
                                .swipeActions(edge: .trailing) {
                                    Button(action: {
                                        viewModel.save(movie)
                                    }) {
                                        Label("Saved", systemImage: movie.isFavorite ? "heart.fill" : "heart")
                                    }
                                    .tint(.blue)
                                }
                        }
                    }.listStyle(.plain)
                }
            }
            .navigationTitle("Saved")
        }
    }
}

struct NoSavedView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "star.fill")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Save a book...")
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color(.systemIndigo))
    }
}

#Preview {
    WishlistView()
}
