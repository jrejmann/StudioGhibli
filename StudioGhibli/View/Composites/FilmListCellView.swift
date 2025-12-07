//
//  FilmListCellView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmListCellView: View {
    var film: Film
    var isFavorite: Bool
    var onToggleFavorite: () -> Void

    var body: some View {
        HStack {
            FilmImageView(urlPath: film.image)
                .frame(width: 100, height: 150)
                .cornerRadius(16)
                .padding(.trailing)

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(film.title)
                        .font(Font.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()

                    FavoriteButton(isFavorite: isFavorite, onToggle: onToggleFavorite)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Directed by \(film.director)")
                        .font(Font.subheadline.italic())
                        .foregroundStyle(.secondary)

                    Text("Released in \(film.releaseYear)")
                        .font(Font.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

        }
    }
}

#Preview("Favorite") {
    FilmListCellView(film: Film.example, isFavorite: true, onToggleFavorite: {})
}

#Preview("Not favorite") {
    FilmListCellView(
        film: Film.example,
        isFavorite: false,
        onToggleFavorite: {}
    )
}
