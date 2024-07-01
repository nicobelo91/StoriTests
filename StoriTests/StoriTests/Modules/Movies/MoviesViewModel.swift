//
//  MoviesViewModel.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var selectedTab: Tab = .search
    @Published var isLoading = false
    @Published var error = ""
    @Published var topRatedMovies: [MovieModel] = []
    @Published var favoriteMovies: [MovieModel] = []
    @Published var listedMovies: [MovieModel] = []
    @Published var isMoreDataAvailable = true
    @Published var currentPage = 0
    
    let dataService: DataService
    
    init(dataService: DataService = MovieDataService()) {
        self.dataService = dataService
        getMovies()
    }
    
    /// Fetches a list of top rated movies from MoviesDB
    func getMovies() {
        isLoading = true
        Task {
            do {
                let result = try await dataService.fetchMovies(page: currentPage + 1)
                
                await MainActor.run {
                    isLoading = false
                    self.topRatedMovies.append(contentsOf: result.data)
                    self.findMovie(in: topRatedMovies)
                    currentPage = result.page
                    isMoreDataAvailable = result.page < result.totalPages
                }
            } catch {
                isLoading = false
                self.error = error.localizedDescription
            }
        }
    }
    
    /// Adds or removes a movie from favoriteMovies
    func addToFavorites(_ movie: MovieModel) {
        objectWillChange.send()
        movie.isFavorite.toggle()
        if movie.isFavorite {
            if !favoriteMovies.contains(where: { $0.id == movie.id }) {
                favoriteMovies.append(movie)
            }
        } else {
            guard let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) else { return }
            favoriteMovies.remove(at: index)
        }
    }
    
    /// Adds or removes a movie from listedMovies
    func addToMyList(_ movie: MovieModel) {
        objectWillChange.send()
        movie.isInMyList.toggle()
        if movie.isInMyList {
            if !listedMovies.contains(where: { $0.id == movie.id }) {
                listedMovies.append(movie)
            }
        } else {
            guard let index = listedMovies.firstIndex(where: { $0.id == movie.id }) else { return }
            listedMovies.remove(at: index)
        }
    }
    
    /// When loading the data, looks for the movies that are already Favorites or in My List
    func findMovie(in movies: [MovieModel]) {
        for movie in movies {
            if favoriteMovies.contains(where: { $0.id == movie.id }) {
                movie.isFavorite = true
                
            }
            if listedMovies.contains(where: { $0.id == movie.id }) {
                movie.isInMyList = true
            }
        }
    }
}
