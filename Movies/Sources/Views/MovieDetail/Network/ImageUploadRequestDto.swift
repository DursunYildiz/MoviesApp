//
//  ImageUploadRequestDto.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import Foundation
struct ImageUploadRequestDto: Encodable {
    let prompt: String
    let base64str: String
    let inputImage: Bool
}
