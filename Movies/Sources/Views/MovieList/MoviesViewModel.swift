//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import Combine
import Foundation
import SwiftData
import UtilsKit
@Observable
final class MoviesViewModel: BaseViewModel {
    var style: MovieListStyle = .list
    var movies: [Movie] = []
    var loadingStatus: LoadingStatus = .loading
    var errorMessage: String?
    var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    private let networkService: MoviesNetworkService
    private var allMovies: [Movie] = []
    private var currentPage = 1
    private var totalPage: Int = 0
    @MainActor
    private var favoriteMovies: [FavoriteMovieDataModel] = FavoriteDbManager.shared.getAllObjects()
    init(networkService: MoviesNetworkService = MoviesNetworkServiceImp()) {
        self.networkService = networkService
    }
    
    func changeStlye() {
        style = style == .list ? .grid : .list
    }
    
    private func fetchMovies(page: Int) {
        loadingStatus = .loading
      
        networkService.fetchPopularMovies(page: page)
            .sink { [weak self] completion in
                guard let self = self else { return }
               
                if case let .failure(error) = completion {
                    self.loadingStatus = .fail
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] movieListModel in
                guard let self = self else { return }
                self.loadingStatus = .succes
                findAndReplaceFavorite(movies: movieListModel.results) { movies in
                    self.movies = movies
                }
                self.totalPage = movieListModel.totalPages
                self.allMovies = movies
            }
            .store(in: &cancellables)
    }

    func onAppear() {
        fetchMovies(page: currentPage)
    }
    
    func searchMovies(with searchText: String) {
        self.searchText = searchText
        guard !searchText.isEmpty else {
            movies = allMovies
            return
        }
        
        // Arama metnine göre filmleri filtrele
        movies = allMovies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    func loadMoreMovies() {
        guard loadingStatus != .fetching, currentPage < totalPage else { return }
        loadingStatus = .fetching
        currentPage += 1
        networkService.fetchPopularMovies(page: currentPage)
            .sink { [weak self] completion in
                guard let self = self else { return }
               
                if case let .failure(error) = completion {
                    self.loadingStatus = .fail
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] movieListModel in
                guard let self = self else { return }
                self.loadingStatus = .succes
                findAndReplaceFavorite(movies: movieListModel.results, closure: { movies in
                    self.movies.append(contentsOf: movies)
                })
                self.allMovies = movies
            }
            .store(in: &cancellables)
    }

    private func findAndReplaceFavorite(movies: [Movie],
                                        closure: @escaping (([Movie]) -> Void))
    {
        DispatchQueue.main.async {
            var movies = movies
            movies.indices.forEach { index in
                guard let _ = self.favoriteMovies.firstIndex(where: { $0.movieId == movies[index].id })
                else { return }
                movies[index].favorite = true
            }
            closure(movies)
        }
    }
}

enum MovieListStyle {
    case list
    case grid
}
