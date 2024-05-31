//
//  MoviesListView.swift
//  Movies
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import MockKit
import SwiftUI
struct MoviesListView: View {
    @Binding var movies: [Movie]
    let fetchMore: () -> Void
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($movies, id: \.id) { $movie in
                    MovieRow(movie: $movie)
                        .onAppear(perform: {
                            if movie == movies.last {
                                fetchMore()
                            }
                        })
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MoviesListView(movies: .constant(movies.results)) {}
    }
}

private let moviesDto: MoviesResponseDto? = MockReader.loadObject(name: "movies")
private let movies: MovieListModel = moviesDto?.toMoviesResponse() ?? .init(page: 0, results: [], totalPages: 0, totalResults: 0)

