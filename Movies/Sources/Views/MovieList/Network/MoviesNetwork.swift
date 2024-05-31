//
//  MovieListNetwork.swift
//  Movies
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import Combine
import Foundation
import NetworkKit
protocol MoviesNetworkService {
    func fetchPopularMovies(page: Int) -> AnyPublisher<MovieListModel, Error>
}

final class MoviesNetworkServiceImp: MoviesNetworkService {
    func fetchPopularMovies(page: Int) -> AnyPublisher<MovieListModel, Error> {
        guard let request = NetworkService.shared.makeRequest(endpoint: NetworkConstants.Endpoints.popularMovies, parameters: ["page": String(page)]) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: MoviesResponseDto.self, decoder: JSONDecoder())
            .map { $0.toMoviesResponse() }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
