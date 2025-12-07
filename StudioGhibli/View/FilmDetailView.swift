//
//  FilmDetailView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmDetailView: View {
    var film: Film
    var viewModel: FilmDetailViewModel
    
    var body: some View {
        VStack {
            Text(film.title)
         
            if (viewModel.people.isEmpty) {
                ProgressView {
                    Text("Loading...")
                }
            } else {
                List(viewModel.people) {
                    Text($0.name)
                }
            }
        }
        .task(id: film.id) {
            await viewModel.fetch(for: film)
        }
    }
}

#Preview {
    @State @Previewable var vm = FilmDetailViewModel(service: MockGhibliService())
    FilmDetailView(film: .preview, viewModel: vm)
}
