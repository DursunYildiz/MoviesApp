//
//  ImageUploadResponseDto.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import Foundation
struct ResponseDataDTO: Codable {
    let base64str: String?
    let title: String?
}

struct ImageResponseDTO: Codable {
    let result: Bool?
    let responseMessage: String?
    let data: ResponseDataDTO?
}

extension ImageResponseDTO {
    func toModel() -> ImageModel {
        ImageModel(result: self.result ?? false,
                   responseMessage: self.responseMessage ?? "",
                   base64str: self.data?.base64str ?? "",
                   title: self.data?.title ?? "")
    }
}
