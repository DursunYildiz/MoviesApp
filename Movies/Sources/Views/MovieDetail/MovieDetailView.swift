//
//  MovieDetailView.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import MockKit
import SwiftUI

struct MovieDetailView: View {
    @Binding var movie: Movie

    @State private var viewModel: MovieDetailViewModel

    init(movie: Binding<Movie>,
         viewModel: MovieDetailViewModel)
    {
        _viewModel = State(initialValue: viewModel)
        self._movie = movie
    }

    var body: some View {
        ScrollView {
            VStack {
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") {
                    AsyncImage(url: url) { image in

                        image.resizable().onAppear(perform: {
                            self.viewModel.base64Image = image.convertToBase64()
                        })
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                }
                VStack(alignment: .leading, content: {
                    Text(movie.title)
                        .font(.largeTitle)
                        .bold()
                        .padding([.top, .bottom], 10)

                    HStack {
                        Text("Release Date: \(movie.releaseDate)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Vote Count: " + movie.voteCount.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text(movie.overview)
                        .padding(.top, 10)

                })
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation {
                        self.viewModel.favotireButtonTapped()
                    }
                }, label: {
                    Image(systemName: viewModel.favorite ? "star.fill" : "star")
                        .tint(Color.yellow)
                })
            }
        })

        .isLoading(isShow: $viewModel.isLoading)
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: .constant(movies.results.first!),
                        viewModel: .init(movie: movies.results.first!))
    }
}

private let moviesDto: MoviesResponseDto? = MockReader.loadObject(name: "movies")
private let movies: MovieListModel = moviesDto?.toMoviesResponse() ?? .init(page: 0, results: [], totalPages: 0, totalResults: 0)
