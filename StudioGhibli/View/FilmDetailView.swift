//
//  FilmDetailView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmDetailView: View {
    var film: Film

    @State private var filmDetailViewModel = FilmDetailViewModel()
    var favoritesViewModel: FavoritesViewModel

    init(film: Film, favoritesViewModel: FavoritesViewModel) {
        self.film = film
        self.favoritesViewModel = favoritesViewModel
    }

    private var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: film.id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 7) {

                FilmImageView(urlPath: film.bannerImage)
                    .frame(height: 300)
                    .containerRelativeFrame(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text(film.title)
                        .font(.title)
                        .fontWeight(.bold)

                    Grid(alignment: .leading) {
                        InfoRow(label: "Director", value: film.director)
                        InfoRow(label: "Producer", value: film.producer)
                        InfoRow(label: "Release Date", value: film.releaseYear)
                        InfoRow(
                            label: "Running Time",
                            value: "\(film.duration) minutes"
                        )
                        InfoRow(label: "Score", value: "\(film.score)/100")
                    }
                    .padding(.vertical, 8)

                    Divider()

                    Text("Description")
                        .font(.headline)

                    Text(film.description)

                    Divider()

                    CharacterSectionView(viewModel: filmDetailViewModel)
                }
                .padding()
            }
        }
        .toolbar {
            FavoriteButton(
                isFavorite: isFavorite,
                onToggle: {
                    favoritesViewModel.toggleFavorite(filmID: film.id)
                }
            )
        }
        .task(id: film) {
            await filmDetailViewModel.fetch(for: film)
        }
    }

}

// MARK: - InfoRow

private struct InfoRow: View {

    let label: String
    let value: String

    var body: some View {
        GridRow {
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(width: 100, alignment: .leading)

            Text(value)
                .font(.subheadline)

        }
    }
}

// MARK: - Character Section

private struct CharacterSectionView: View {

    let viewModel: FilmDetailViewModel

    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 12) {
                Text("Characters")
                    .font(.headline)

                switch viewModel.state {
                case .idle: EmptyView()
                case .loading: ProgressView()

                case .loaded(let people):
                    ForEach(people) { person in
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.tint)

                            Text(person.name)
                                .font(.subheadline.weight(.medium))

                            Spacer()
                        }
                    }

                case .error(let error):
                    Text(error)
                        .foregroundStyle(.pink)
                }
            }
        }
    }
}

#Preview {
    FilmDetailView(
        film: Film.example,
        favoritesViewModel: FavoritesViewModel.example
    )
}
