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
                    EmptyListView()
                } else {
                    List {
                        ForEach(viewModel.listedMovies, id: \.id) { movie in
                            MovieRow(movie: movie)
                                .swipeActions(edge: .trailing) {
                                    Button(action: {
                                        viewModel.addToMyList(movie)
                                    }) {
                                        Label("Add to My List", systemImage: viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? "xmark" : "star")
                                    }
                                    .tint(viewModel.listedMovies.contains(where: { $0.id == movie.id }) ? .themeSecondary : .themePrimary)
                                }
                        }
                    }.listStyle(.plain)
                }
            }
            .navigationTitle("My List")
        }
    }
}

struct EmptyListView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "star.fill")
                .font(.system(size: 85))
                .padding(.bottom)
            Text("Add a movie to My List...")
                .font(.title)
            Spacer()
        }
        .padding()
        .foregroundColor(.themePrimary)
    }
}

#Preview {
    MyListView()
}
