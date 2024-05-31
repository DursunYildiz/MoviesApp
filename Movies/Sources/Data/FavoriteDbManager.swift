//
//  FavoriteDbManager.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import Foundation
import SwiftData
import UtilsKit

@MainActor
protocol FavoriteDbManagerInterface {
    func save(data: FavoriteMovieDataModel)
    func delete(movie: Movie)
    func getAllObjects() -> [FavoriteMovieDataModel]
}

@MainActor
final class FavoriteDbManager: FavoriteDbManagerInterface {
    static let identifier: String = "FavoriteDbManager"
    static let shared: FavoriteDbManagerInterface = FavoriteDbManager()
    private init() {}

    let persistantContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: FavoriteMovieDataModel.self,
                configurations: ModelConfiguration()
            )
            return container
        } catch {
            fatalError("Failed to create a container")
        }
    }()

    func save(data: FavoriteMovieDataModel) {
        let favorites = getAllObjects()
        if let _ = favorites.firstIndex(where: { $0.movieId == data.movieId }) {
            return
        }

        persistantContainer.mainContext.insert(data)
        do {
            try persistantContainer.mainContext.save()
            Log.info("Save Success \(data.movieId)")
        } catch {
            Log.error("Failed to save \(data): \(error)")
        }
    }

    func delete(movie: Movie) {
        guard let data = getAllObjects().first(where: { $0.movieId == movie.id }) else { return }
        persistantContainer.mainContext.delete(data)
        do {
            try persistantContainer.mainContext.save()
            Log.info("Delete Success \(data)")
        } catch {
            Log.error("Failed to delete \(data): \(error)")
        }
    }

    func getAllObjects() -> [FavoriteMovieDataModel] {
        do {
            let data = try persistantContainer.mainContext.fetch(FetchDescriptor<FavoriteMovieDataModel>())
            Log.info("\(FavoriteDbManager.identifier) getAllObjects: \(data)")
            return data
        } catch {
            Log.error("\(FavoriteDbManager.identifier) getAllObjects: data is nil")
            return []
        }
    }
}
