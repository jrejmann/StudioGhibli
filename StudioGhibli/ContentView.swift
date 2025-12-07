//
//  ContentView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var filmsViewModel = FilmsViewModel()
    
    var body: some View {
        TabView {
            
            Tab("Films", systemImage: "movieclapper") {
                FilmsListView(viewModel: filmsViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesView(viewModel: filmsViewModel)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
            
            Tab(role: .search) {
                SearchScreen()
            }
        }
    }
}

#Preview {
    ContentView()
}
