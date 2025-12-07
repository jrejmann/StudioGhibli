//
//  SearchScreen.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    @State private var searchViewModel: SearchViewModel
    let favoritesViewModel: FavoritesViewModel

    init(
        favoritesViewModel: FavoritesViewModel,
        service: GhibliService = DefaultGhibliService()
    ) {
        self.favoritesViewModel = favoritesViewModel
        self.searchViewModel = SearchViewModel(service: service)
    }
    var body: some View {
        NavigationStack {
            VStack {
                switch searchViewModel.state {
                case .idle:
                    VStack(alignment: .center) {
                        Image(systemName: "magnifyingglass")
                            .font(.largeTitle)
                            .padding(.bottom)
                        Text("Search for your favourite films by typing into the search bar.")
                            .multilineTextAlignment(.center)
                    }
                    .foregroundStyle(.secondary)
                    .frame(width: 300)
                case .loading:
                    ProgressView()
                case .error(let error):
                    Text(error)
                case .loaded(let films):
                    FilmListView(
                        films: films,
                        favoritesViewModel: favoritesViewModel
                    )
                }
            }
            .navigationTitle("Search")
            .searchable(text: $text)
            .task(id: text) {
                await searchViewModel.fetch(for: text)
            }
        }
    }
}

#Preview {
    SearchView(
        favoritesViewModel: FavoritesViewModel(storage: MockFavoritesStorage())
    )
}
