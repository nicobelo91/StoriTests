//
//  DataService.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import Foundation

enum CustomError: Error, Identifiable {
    case failedToFetch
    
    var id: Int {
        switch self {
        case .failedToFetch: return 1
        }
    }
}
protocol DataService {
    func fetchMovies(page: Int) async throws -> PaginatedMovieModel
}

class MovieDataService: DataService {
    
    let url = "https://api.themoviedb.org/3"
    func fetchMovies(page: Int) async throws -> PaginatedMovieModel {
        let safeUrl = URL(string: "\(url)/movie/top_rated?page=\(page)")!
        var request = URLRequest(url: safeUrl)
        request.setValue("Bearer \(Keys.bearerToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(MovieList.self, from: data)
        return MovieMappers.apiListToDomain(result)
    }
    
}

