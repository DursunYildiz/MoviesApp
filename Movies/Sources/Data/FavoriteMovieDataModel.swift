//
//  FavoriteMovieDataModel.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import Foundation
import SwiftData

@Model
final class FavoriteMovieDataModel {
    let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
}
