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
                    emptyStateView
                } else {
                    List {
                        ForEach(viewModel.topRatedMovies, id: \.id) { movie in
                            MovieRow(movie: movie)
                                .swipeActions(edge: .trailing) {
                                    favoriteButton(for: movie)
                                    myListButton(for: movie)
                                }
                        }
                        if viewModel.isMoreDataAvailable {
                                lastRowView
                            }
                    }.listStyle(.plain)
                        
                }
            }
            .navigationTitle(K.topRatedMovies)
        }
        .alert(isPresented: Binding.constant(!viewModel.error.isEmpty)) {
            Alert(title: Text(viewModel.error),
                  dismissButton: .default(Text("Ok"), action: {}))
        }
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
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Image(systemName: "movieclapper")
                .font(.system(size: 85))
                .padding(.bottom)
            Text(K.search)
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(Color.themePrimary)
    }
    
    private func favoriteButton(for movie: MovieModel) -> some View {
        Button(action: {
            viewModel.addToFavorites(movie)
            guard let movieData = try? JSONEncoder().encode(viewModel.favoriteMovies) else {
                print("Coudln't encode the data")
                return
            }
            self.favoriteMoviesData = movieData
        }) {
            Label(K.favorite, systemImage: viewModel.favoriteMovies.contains(where: { $0.id == movie.id }) ? "xmark" : "heart")
        }
        .tint(viewModel.favoriteMovies.contains(where: { $0.id == movie.id }) ? .themeGreen2 : .themeDark)
    }
    
    private func myListButton(for movie: MovieModel) -> some View {
        Button(action: {
            viewModel.addToMyList(movie)
            guard let movieData = try? JSONEncoder().encode(viewModel.listedMovies) else {
                print("Coudln't encode the data")
                return
            }
            self.listedMoviesData = movieData
        }) {
            Label(K.myList, systemImage: viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? "xmark" : "star")
        }
        .tint(viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? .themeSecondary : .themePrimary)
    }
}

extension TopRatedView {
    //Constants
    enum K {
        static let topRatedMovies = "Top Rated Movies"
        static let search = "Start searching for movies..."
        static let favorite = "Favorite"
        static let myList = "My List"
    }
}

#Preview {
    TopRatedView()
}
