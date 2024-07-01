//
//  MyListView.swift
//  StoriTests
//
//  Created by Nicolas Cobelo on 29/06/2024.
//

import SwiftUI

struct MyListView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    var body: some View {
        NavigationView {
            LoadingView(viewModel.isLoading) {
                if viewModel.listedMovies.isEmpty {
                    emptyListView
                } else {
                    List {
                        ForEach(viewModel.listedMovies, id: \.id) { movie in
                            MovieRow(movie: movie)
                                .swipeActions(edge: .trailing) {
                                    Button(action: {
                                        viewModel.addToMyList(movie)
                                    }) {
                                        Label(K.addToMyList, systemImage: viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? "xmark" : "star")
                                    }
                                    .tint(viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? .themeSecondary : .themePrimary)
                                }
                        }
                    }.listStyle(.plain)
                }
            }
            .navigationTitle(K.myList)
        }
    }
}

extension MyListView {
    private var emptyListView: some View {
            VStack {
                Spacer()
                Image(systemName: "star.fill")
                    .font(.system(size: 85))
                    .padding(.bottom)
                Text(K.addMovie)
                    .font(.title)
                Spacer()
            }
            .padding()
            .foregroundColor(.themePrimary)
        }
}

extension MyListView {
    //Constants
    enum K {
        static let addMovie = "Add a movie to My List..."
        static let addToMyList = "Add to My List"
        static let myList = "My List"
    }
}

#Preview {
    MyListView()
}
