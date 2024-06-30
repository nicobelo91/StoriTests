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
    //func fetchMovies(by searchTerm: String, completion: @escaping (Result<[Book], BookClubError>) -> Void)
    func fetchMovies(page: Int) async throws -> MovieList
}

class MovieDataService: DataService {
    
    let url = "https://api.themoviedb.org/3"
    let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYzMyMTQ4ZGU0ZWVkNTMzMjJhYWQzMWZjODRjZjkyNCIsIm5iZiI6MTcxOTY3OTM2OS43MjY0ODUsInN1YiI6IjYxNTEwNTdhZjA0ZDAxMDA5MWM3ZGFhZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0CMSoyvJhyO8dP2Kwc9j0lkCrrgOr_H0jcMuv-Fs81w"
    func fetchMovies(page: Int) async throws -> MovieList {
        let safeUrl = URL(string: "\(url)/movie/top_rated?page=\(page)")!
        var request = URLRequest(url: safeUrl)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(MovieList.self, from: data)
    }
    
}

