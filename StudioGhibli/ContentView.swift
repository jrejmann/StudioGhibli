//
//  ContentView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var filmsViewModel: FilmsViewModel
    @State private var favoritesViewModel: FavoritesViewModel

    init(
        filmsViewModel: FilmsViewModel = FilmsViewModel(),
        favoritesViewModel: FavoritesViewModel = FavoritesViewModel()
    ) {
        _filmsViewModel = State(initialValue: filmsViewModel)
        _favoritesViewModel = State(initialValue: favoritesViewModel)
    }
    
    var body: some View {
        TabView {
            Tab("Films", systemImage: "movieclapper") {
                FilmsView(filmsViewModel: filmsViewModel, favoritesViewModel: favoritesViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesView(filmsViewModel: filmsViewModel, favoritesViewModel: favoritesViewModel)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
            
            Tab(role: .search) {
                SearchView()
            }
        }
        .task {
            favoritesViewModel.load()
        }
    }
}

#Preview {
    ContentView(filmsViewModel: FilmsViewModel.example, favoritesViewModel: FavoritesViewModel.example)
}

