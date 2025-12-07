//
//  FilmsListView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmsListView: View {
    let viewModel: FilmsViewModel

    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .idle:
                Text("No Films yet")
            case .loading:
                ProgressView {
                    Text("Loading...")
                }
            case .loaded(let films):
                List(films) { film in
                    NavigationLink(value: film) {
                        FilmListCellView(film: film)
                    }
                }
                .navigationTitle("Ghibli Films")
                .navigationDestination(for: Film.self) { film in
                    FilmDetailView(film: film)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.red)
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    @State @Previewable var vm = FilmsViewModel(service: MockGhibliService())
    FilmsListView(viewModel: vm)
}
