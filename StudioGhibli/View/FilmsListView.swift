//
//  FilmsListView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmsListView: View {
    var filmsViewModel = FilmsViewModel()

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
                    Text(film.title)
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
