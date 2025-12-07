//
//  FilmsView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmsView: View {
    let viewModel: FilmsViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle:
                    Text("No Films yet")
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let films):
                    FilmListView(films: films)
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
            .navigationTitle("Films")
        }
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    @State @Previewable var vm = FilmsViewModel(service: MockGhibliService())
    FilmsView(viewModel: vm)
}
