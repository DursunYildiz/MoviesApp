//
//  ImageExtension.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import SwiftUI
extension Image {
    /// Usually you would pass  `@Environment(\.displayScale) var displayScale`
    @MainActor func render(scale displayScale: CGFloat = 1.0) -> UIImage? {
        let renderer = ImageRenderer(content: self)

        renderer.scale = displayScale

        return renderer.uiImage
    }

    @MainActor
    func convertToBase64() -> String {
        guard let uiImage = render(), let imageData = uiImage.jpegData(compressionQuality: 1) else {
            print("Failed to convert UIImage to Data")
            return ""
        }

        // Data'yı Base64'e dönüştürme
        let base64String = imageData.base64EncodedString()
        return base64String
    }
}
