//
//  MovieListDto.swift
//  Movies
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import Foundation

struct MovieDto: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct MoviesResponseDto: Codable {
    let page: Int?
    let results: [MovieDto]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension MovieDto {
    func toMovie() -> Movie {
        return Movie(
            adult: self.adult ?? false,
            backdropPath: self.backdropPath ?? "",
            genreIds: self.genreIds ?? [],
            id: self.id ?? 0,
            originalLanguage: self.originalLanguage ?? "",
            originalTitle: self.originalTitle ?? "",
            overview: self.overview ?? "",
            popularity: self.popularity ?? 0.0,
            posterPath: self.posterPath ?? "",
            releaseDate: self.releaseDate ?? "",
            title: self.title ?? "",
            video: self.video ?? false,
            voteAverage: self.voteAverage ?? 0.0,
            voteCount: self.voteCount ?? 0,
            favorite: false
        )
    }
}

extension MoviesResponseDto {
    func toMoviesResponse() -> MovieListModel {
        return MovieListModel(
            page: self.page ?? 0,
            results: self.results?.map { $0.toMovie() } ?? [],
            totalPages: self.totalPages ?? 0,
            totalResults: self.totalResults ?? 0
        )
    }
}
