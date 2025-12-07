//
//  ContentView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct ContentView: View {
    private let service: GhibliService
    @State private var filmsViewModel: FilmsViewModel

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
        _filmsViewModel = State(initialValue: FilmsViewModel(service: service))
    }
    
    var body: some View {
        TabView {
            Tab("Films", systemImage: "movieclapper") {
                FilmsView(viewModel: filmsViewModel)
            }
            
            Tab("Favorites", systemImage: "heart") {
                FavoritesView(viewModel: filmsViewModel)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
            
            Tab(role: .search) {
                SearchView()
            }
        }
    }
}

#Preview {
    ContentView(service: MockGhibliService())
}
