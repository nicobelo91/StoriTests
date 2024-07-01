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
    
    func index(of movie: MovieModel) -> Int? {
        for index in 0..<topRatedMovies.count {
            if topRatedMovies[index].id == movie.id {
                return index
            }
        }
        return nil
    }
    
    func addToFavorites(_ movie: MovieModel) {
//        guard let chosenIndex = index(of: movie) else { return }
//        var indexedMovie = topRatedMovies[chosenIndex]
//        objectWillChange.send()
//        indexedMovie.isFavorite.toggle()
//        
//        if indexedMovie.isFavorite {
//            if !favoriteMovies.contains(where: { $0.id == movie.id }) {
//                favoriteMovies.append(indexedMovie)
//            }
//        } else {
//            guard let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) else { return }
//            favoriteMovies.remove(at: index)
//        }
        
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
//        guard let chosenIndex = index(of: movie) else { return }
//        var indexedMovie = topRatedMovies[chosenIndex]
////        print(indexedMovie.isInMyList)
////        indexedMovie.isInMyList.toggle()
////        print(indexedMovie.isInMyList)
//        if indexedMovie.isInMyList {
//            indexedMovie.isInMyList = false
////            if !listedMovies.contains(where: { $0.id == movie.id }) {
////                listedMovies.append(indexedMovie)
////            }
//            guard let index = listedMovies.firstIndex(where: { $0.id == movie.id }) else { return }
//            listedMovies.remove(at: index)
//        } else {
//            indexedMovie.isInMyList = true
//            if !listedMovies.contains(where: { $0.id == movie.id }) {
//                listedMovies.append(indexedMovie)
//            }
////            guard let index = listedMovies.firstIndex(where: { $0.id == movie.id }) else { return }
////            listedMovies.remove(at: index)
//        }
    }
    
    func findMovie(in movies: [MovieModel]) {
        for movie in movies {
            if let chosenIndex = index(of: movie) {
                if favoriteMovies.contains(where: { $0.id == movie.id }) {
                    topRatedMovies[chosenIndex].isFavorite = true
                    
                }
                if listedMovies.contains(where: { $0.id == movie.id }) {
                    topRatedMovies[chosenIndex].isInMyList = true
                }
            }
        }
    }
}
