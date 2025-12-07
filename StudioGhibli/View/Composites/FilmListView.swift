//
//  FilmsListView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmListView: View {
    let films: [Film]
    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                FilmListCellView(
                    film: film,
                    isFavorite: favoritesViewModel.isFavorite(filmID: film.id),
                    onToggleFavorite: {
                        favoritesViewModel.toggleFavorite(filmID: film.id)
                    }
                )
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailView(film: film, favoritesViewModel: favoritesViewModel)
        }

    }
}

#Preview {

    NavigationStack {
        FilmListView(films: [Film.example], favoritesViewModel: FavoritesViewModel.example)
    }
}
