//
//  MoviesView.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

enum Tab {
    case search, favorite, saved
}
struct MoviesView: View {
    @StateObject var viewModel = MoviesViewModel()
    @AppStorage("favoriteMovies") var favoriteMoviesData = Data()
    @AppStorage("wishlistMovies") var wishlistMoviesData = Data()
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            TopRatedView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(Tab.favorite)
            WishlistView()
                .tabItem {
                    Label("Saved", systemImage: "star.fill")
                }
                .tag(Tab.saved)
        }
        .environmentObject(viewModel)
        .onAppear { loadData() }
    }
    
    private func loadData() {
        guard let favoriteMovies = try? JSONDecoder().decode([Movie].self, from: favoriteMoviesData) else {
            print("Couldn't decode the data")
            return
            
        }
        viewModel.favoriteMovies = favoriteMovies
        
        guard let wishlistMovies = try? JSONDecoder().decode([Movie].self, from: wishlistMoviesData) else {
            print("Couldn't decode the data")
            return
            
        }
        viewModel.wishlistMovies = wishlistMovies
    }
}

#Preview {
    MoviesView()
}
