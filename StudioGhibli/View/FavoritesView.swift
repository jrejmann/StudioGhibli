//
//  FavoritesView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FavoritesView: View {
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel

    var films: [Film] {
        let favorites = favoritesViewModel.favoriteIDs
        switch filmsViewModel.state {
        case .loaded(let films):
            return films.filter { favorites.contains($0.id) }
        default: return []
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView(
                        "No Favorites yet",
                        systemImage: "heart"
                    )
                } else {
                    FilmListView(
                        films: films,
                        favoritesViewModel: favoritesViewModel
                    )
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView(filmsViewModel: FilmsViewModel.example, favoritesViewModel: FavoritesViewModel.example)
}
