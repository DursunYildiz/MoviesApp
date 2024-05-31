//
//  MoviesGridView.swift
//  Movies
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import MockKit
import SwiftUI
struct MoviesGridView: View {
    @Binding var movies: [Movie]
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let fetchMore: () -> Void
    init(movies: Binding<[Movie]>, fetchMore: @escaping () -> Void) {
        self._movies = movies
        self.fetchMore = fetchMore
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: self.columns) {
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
    MoviesGridView(movies: .constant(movies.results)) {}
}

private let moviesDto: MoviesResponseDto? = MockReader.loadObject(name: "movies")
private let movies: MovieListModel = moviesDto?.toMoviesResponse() ?? .init(page: 0, results: [], totalPages: 0, totalResults: 0)
