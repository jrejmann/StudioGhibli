//
//  FilmsListView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmListView: View {
    let films: [Film]

    var body: some View {
        List(films) { film in
            NavigationLink(value: film) {
                FilmListCellView(film: film)
            }
        }
        .navigationDestination(for: Film.self) { film in
            FilmDetailView(film: film)
        }

    }
}

#Preview {
    NavigationStack{
        FilmListView(films: [Film.example])
    }
}
