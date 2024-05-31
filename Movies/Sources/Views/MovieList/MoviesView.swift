//
//  MovieListView.swift
//  Movies
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import Combine
import SwiftData
import SwiftUI
struct MoviesView: View {
    @State private var viewModel: MoviesViewModel

    init(viewModel: MoviesViewModel = MoviesViewModel()) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.loadingStatus {
                case .fail:
                    Text("Some times wrong try again")
                case .succes, .fetching:
                    if viewModel.movies.isEmpty {
                        Text("No filter results")
                    }
                    else {
                        switch viewModel.style {
                        case .list:
                            MoviesListView(movies: $viewModel.movies) {
                                viewModel.loadMoreMovies()
                            }
                        case .grid:
                            MoviesGridView(movies: $viewModel.movies) {
                                viewModel.loadMoreMovies()
                            }
                        }
                    }
                case .loading:
                    ProgressView()
                }
            }
            .navigationTitle("Contents")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            viewModel.changeStlye()
                        }
                    }, label: {
                        Image(systemName: viewModel.style == .list ? "square.grid.2x2" : "list.bullet")
                            .tint(.black)
                    })
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Filter")
            .onChange(of: viewModel.searchText) { _, newValue in
                viewModel.searchMovies(with: newValue)
            }
            .overlay(alignment: .bottom) {
                if viewModel.loadingStatus == .fetching {
                    ProgressView()
                }
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

#Preview {
    MoviesView()
}
