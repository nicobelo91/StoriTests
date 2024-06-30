//
//  TopRatedView.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

struct TopRatedView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    
    @AppStorage("favoriteMovies") var favoriteMoviesData = Data()
    @AppStorage("wishlistMovies") var wishlistMoviesData = Data()
    
    var body: some View {
        NavigationView {
            LoadingView(viewModel.isLoading) {
                if viewModel.topRatedMovies.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(viewModel.topRatedMovies, id: \.id) { movie in
                            MovieRow(movie: movie)
                                .swipeActions(edge: .trailing) {
                                    FavoriteButton(for: movie)
                                    SaveButton(for: movie)
                                }
                        }
                        if viewModel.isMoreDataAvailable {
                                lastRowView
                            }
                    }.listStyle(.plain)
                        
                }
            }
            .navigationTitle("Top Rated Movies")
        }
        .alert(isPresented: Binding.constant(!viewModel.error.isEmpty)) {
            Alert(title: Text(viewModel.error),
                  dismissButton: .default(Text("Ok"), action: {}))
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "book.fill")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Start searching for books...")
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color(.systemIndigo))
    }
}


// MARK: - Buttons

extension TopRatedView {
    
    var lastRowView: some View {
        EmptyView()
        .frame(height: 50)
        .onAppear {
            viewModel.getMovies()
        }
    }
    
    private func FavoriteButton(for movie: Movie) -> some View {
        Button(action: {
            viewModel.addToFavorites(movie)
            guard let movieData = try? JSONEncoder().encode(viewModel.favoriteMovies) else {
                print("Coudln't encode the data")
                return
            }
            self.favoriteMoviesData = movieData
        }) {
            Label("Favorite", systemImage: viewModel.favoriteMovies.contains(where: { $0.id == movie.id }) ? "xmark" : "heart")
        }
        .tint(movie.isFavorite ? .red : .blue)
    }
    
    private func SaveButton(for movie: Movie) -> some View {
        Button(action: {
            viewModel.save(movie)
            guard let movieData = try? JSONEncoder().encode(viewModel.wishlistMovies) else {
                print("Coudln't encode the data")
                return
            }
            self.wishlistMoviesData = movieData
        }) {
            Label("Save", systemImage: viewModel.wishlistMovies.contains(where: { $0.id == movie.id }) ? "xmark" : "star")
        }
        .tint(movie.isSaved ? .red : .yellow)
    }
}


#Preview {
    TopRatedView()
}
