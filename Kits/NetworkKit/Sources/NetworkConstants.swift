//
//  Constants.swift
//  NetworkKit
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import Foundation
public enum NetworkConstants: String {
    case apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5M2QwODJkZTkyNjIxODQzYmY2NTAzN2U4YTNjNDY0ZiIsInN1YiI6IjY2NTc2MzFlYTUwNjc0NzdiODIxNWNhOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3GRknohxoe0T-UIg5gu_DsSneLsneBt8m2Gx6WNCFyU"
    case baseUrl = "https://api.themoviedb.org/3"

    public enum Endpoints: String {
        case popularMovies = "/movie/popular"
    }
}

public enum Method: String {
    case get = "GET"
    case post = "POST"
}
