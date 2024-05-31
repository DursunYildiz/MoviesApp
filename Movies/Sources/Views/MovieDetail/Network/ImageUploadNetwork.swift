//
//  ImageUploadNetwork.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import Combine
import Foundation
import NetworkKit
protocol ImageUploadNetworkInterface {
    func uploadImage(base64: String) -> AnyPublisher<ImageModel, Error>
}

final class ImageUploadNetwork: ImageUploadNetworkInterface {
    func uploadImage(base64: String) -> AnyPublisher<ImageModel, Error> {
        let requestModel: ImageUploadRequestDto = .init(prompt: "", base64str: base64, inputImage: false)
        guard let request = NetworkService.shared.makePostRequest(url: "asd", body: requestModel)
        else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: ImageResponseDTO.self, decoder: JSONDecoder())
            .map { $0.toModel() }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

final class ImageUploadNetworkMock: ImageUploadNetworkInterface {
    func uploadImage(base64: String) -> AnyPublisher<ImageModel, Error> {
        let mockResponse = ImageModel(result: true, responseMessage: "", base64str: "", title: "")

        return Just(mockResponse)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
