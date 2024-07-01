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
    @AppStorage("listedMovies") var listedMoviesData = Data()
    
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
                                    MyListButton(for: movie)
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
            Image(systemName: "movieclapper")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Start searching for movies...")
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color.themePrimary)
    }
}


// MARK: - Buttons

extension TopRatedView {
    
    var lastRowView: some View {
        Rectangle()
            .fill(Color.clear)
        .frame(height: 50)
        .onAppear {
            viewModel.getMovies()
        }
    }
    
    private func FavoriteButton(for movie: MovieModel) -> some View {
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
        .tint(viewModel.favoriteMovies.contains(where: { $0.id == movie.id }) ? .themeGreen2 : .themeDark)
    }
    
    private func MyListButton(for movie: MovieModel) -> some View {
        Button(action: {
            viewModel.addToMyList(movie)
            guard let movieData = try? JSONEncoder().encode(viewModel.listedMovies) else {
                print("Coudln't encode the data")
                return
            }
            self.listedMoviesData = movieData
        }) {
            Label("Add to My List", systemImage: viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? "xmark" : "star")
        }
        .tint(viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? .themeSecondary : .themePrimary)
    }
}


#Preview {
    TopRatedView()
}
