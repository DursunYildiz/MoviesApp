//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import Combine
import SwiftUI
@Observable
final class MovieDetailViewModel {
    private var movie: Movie
    var isLoading: Bool = false
    var base64Image: String = ""
    var networkService: ImageUploadNetworkInterface
    private var cancellables = Set<AnyCancellable>()
    var errorMessage: String?
    var favorite: Bool = false
    init(movie: Movie, networkService: ImageUploadNetworkInterface = ImageUploadNetworkMock()) {
        self.movie = movie
        self.networkService = networkService
        self.favorite = movie.favorite
    }

    @MainActor
    private func saveFavorite() {
        FavoriteDbManager.shared.save(data: .init(movieId: movie.id))
    }

    @MainActor
    private func delete() {
        FavoriteDbManager.shared.delete(movie: movie)
    }

    @MainActor
    func favotireButtonTapped() {
        if !favorite {
            sendImageToServer()
            return
        }
        delete()
        favorite = false
    }

    func sendImageToServer() {
        isLoading = true

        networkService.uploadImage(base64: base64Image)
            .sink { [weak self] completion in
                guard let self = self else { return }
                isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                self.isLoading = false

                guard response.result else {
                    self.errorMessage = "Some times wrong"
                    return
                }
                DispatchQueue.main.async {
                    self.saveFavorite()
                    self.favorite = true
                }
            }
            .store(in: &cancellables)
    }
}
