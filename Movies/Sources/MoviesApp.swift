//
//  MoviesApp.swift
//  Movies
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import SwiftData
import SwiftUI
@main
struct MoviesApp: App {
    let container: ModelContainer
    init() {
        do {
            container = try ModelContainer(for: FavoriteMovieDataModel.self)
        } catch {
            fatalError("Failed to create ModelContainer for MeterDataModel.")
        }
    }

    var body: some Scene {
        WindowGroup {
            MoviesView( )
                .preferredColorScheme(.light)
        }
     
    }
}

