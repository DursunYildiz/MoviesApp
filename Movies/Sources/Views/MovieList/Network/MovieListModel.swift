//
//  MovieListModel.swift
//  Movies
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import Foundation
struct Movie: Equatable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    var favorite: Bool
}

struct MovieListModel {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}
