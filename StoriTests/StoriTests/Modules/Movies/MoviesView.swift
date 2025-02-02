//
//  MoviesView.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

enum Tab {
    case search, favorite, myList
}
struct MoviesView: View {
    @StateObject var viewModel = MoviesViewModel()
    @AppStorage("favoriteMovies") var favoriteMoviesData = Data()
    @AppStorage("listedMovies") var listedMoviesData = Data()
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            TopRatedView()
                .tabItem {
                    Label(K.search, systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
            FavoritesView()
                .tabItem {
                    Label(K.favorites, systemImage: "heart.fill")
                }
                .tag(Tab.favorite)
            MyListView()
                .tabItem {
                    Label(K.mysList, systemImage: "star.fill")
                }
                .tag(Tab.myList)
        }
        .accentColor(.themePrimary)
        .environmentObject(viewModel)
        .onAppear { loadData() }
    }
    
    private func loadData() {
        guard let favoriteMovies = try? JSONDecoder().decode([MovieModel].self, from: favoriteMoviesData) else {
            print("Couldn't decode the data")
            return
            
        }
        viewModel.favoriteMovies = favoriteMovies
        
        guard let listedMovies = try? JSONDecoder().decode([MovieModel].self, from: listedMoviesData) else {
            print("Couldn't decode the data")
            return
            
        }
        viewModel.listedMovies = listedMovies
    }
}

extension MoviesView {
    //Constants
    enum K {
        static let search = "Search"
        static let favorites = "Favorites"
        static let mysList = "My List"
    }
}

#Preview {
    MoviesView()
}
