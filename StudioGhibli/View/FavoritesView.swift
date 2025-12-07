//
//  FavoritesView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FavoritesView: View {
    let viewModel: FilmsViewModel
    
    let favoriteFilms: [Film] = []
    
    var body: some View {
        NavigationStack {
            FilmListView(films: favoriteFilms)
                .navigationTitle("Favorites")
                .overlay {
                    if (favoriteFilms.isEmpty) {
                        ContentUnavailableView("No favorites yet", systemImage: "heart.fill", description: Text("Tap the heart on a film to save it here."))
                    }
                }
        }
    }
}

#Preview {
    @State @Previewable var vm = FilmsViewModel(service: MockGhibliService())
    FavoritesView(viewModel: vm)
}
