//
//  FilmsListView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmsListView: View {
    var filmsViewModel = FilmsViewModel()
    var filmDetailViewModel = FilmDetailViewModel()

    var body: some View {
        NavigationStack {
            switch filmsViewModel.state {
            case .idle:
                Text("No Films yet")
            case .loading:
                ProgressView {
                    Text("Loading...")
                }
            case .loaded(let films):
                List(films) { film in
                    NavigationLink(film.title, value: film)
                }
                .navigationDestination(for: Film.self) { film in
                    FilmDetailView(film: film, viewModel: filmDetailViewModel)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.red)
            }
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    @State @Previewable var vm =
        FilmsViewModel(service: MockGhibliService())

    FilmsListView(filmsViewModel: vm)
}
