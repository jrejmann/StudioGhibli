//
//  FilmDetailView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmDetailView: View {
    var film: Film

    @State private var viewModel = FilmDetailViewModel()

    var body: some View {
        VStack {
            Text(film.title)
            
            Divider()
            
            Text("Characters")
                .font(.title3)

            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded(let people):
                ForEach(people) { person in
                    Text(person.name)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.red)
            }
        }
        .task {
            await viewModel.fetch(for: film)
        }
    }
}

#Preview {
    FilmDetailView(film: .preview)
}
