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
    @Published var topRatedMovies: [Movie] = []
    @Published var favoriteMovies: [Movie] = []
    @Published var wishlistMovies: [Movie] = []
    @Published var isMoreDataAvailable = true
    @Published var currentPage = 0
    
    let dataService: DataService
    
    init(dataService: DataService = MovieDataService()) {
        self.dataService = dataService
        getMovies()
    }
    /// Fetches the content from Compass's about page
    func getMovies() {
        isLoading = true
        Task {
            do {
                let result = try await dataService.fetchMovies(page: currentPage + 1)
                
                await MainActor.run {
                    isLoading = false
                    self.topRatedMovies.append(contentsOf: result.results)
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
    
    func index(of movie: Movie) -> Int? {
        for index in 0..<topRatedMovies.count {
            if topRatedMovies[index].id == movie.id {
                return index
            }
        }
        return nil
    }
    
    func addToFavorites(_ movie: Movie) {
        guard let chosenIndex = index(of: movie) else { return }
        var indexedMovie = topRatedMovies[chosenIndex]
        objectWillChange.send()
        indexedMovie.isFavorite.toggle()
        
        if indexedMovie.isFavorite {
            if !favoriteMovies.contains(where: { $0.id == movie.id }) {
                favoriteMovies.append(indexedMovie)
            }
        } else {
            guard let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) else { return }
            favoriteMovies.remove(at: index)
        }
        
    }
    
    func save(_ movie: Movie) {
        guard let chosenIndex = index(of: movie) else { return }
        var indexedMovie = topRatedMovies[chosenIndex]
        objectWillChange.send()
        indexedMovie.isSaved.toggle()
        
        if indexedMovie.isSaved {
            if !wishlistMovies.contains(where: { $0.id == movie.id }) {
                wishlistMovies.append(indexedMovie)
            }
        } else {
            guard let index = wishlistMovies.firstIndex(where: { $0.id == movie.id }) else { return }
            wishlistMovies.remove(at: index)
        }
    }
    
    func findMovie(in movies: [Movie]) {
        for movie in movies {
            if let chosenIndex = index(of: movie) {
                if favoriteMovies.contains(where: { $0.id == movie.id }) {
                    topRatedMovies[chosenIndex].isFavorite = true
                    
                }
                if wishlistMovies.contains(where: { $0.id == movie.id }) {
                    topRatedMovies[chosenIndex].isSaved = true
                }
            }
        }
    }
}
