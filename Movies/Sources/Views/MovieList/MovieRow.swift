//
//  MovieRowView.swift
//  Movies
//
//  Created by Dursun YILDIZ on 30.05.2024.
//

import SwiftUI
struct MovieRow: View {
    @Binding var movie: Movie

    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: $movie, viewModel: .init(movie: movie))) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)

                VStack(spacing: 12) {
                    if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .frame(height: 150) // Oranlarını ayarlayabilirsiniz
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } placeholder: {
                            ProgressView()
                                .frame(height: 150) // Oranlarını ayarlayabilirsiniz
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .overlay(alignment: .topTrailing) {
                            ZStack {
                                if movie.favorite {
                                    Image(systemName: "star.fill")
                                        .tint(Color.yellow)
                                        .padding()
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.headline)
                            .tint(Color.black)

                        // Ek diğer bilgiler buraya eklenebilir
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}
