//
//  FavoritesViewModel.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    private(set) var favoriteIDs: Set<String> = []

    private let storage: FavoritesStorage

    init(storage: FavoritesStorage = DefaultFavoritesStorage()) {
        self.storage = storage
    }

    func load() {
        favoriteIDs = storage.load()
    }

    private func save() {
        storage.save(favoriteIDs: favoriteIDs)
    }

    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }

        save()
    }

    func isFavorite(filmID: String) -> Bool {
        return favoriteIDs.contains(filmID)
    }

    //MARK: - preview

    static var example: FavoritesViewModel {
        let vm = FavoritesViewModel(storage: MockFavoritesStorage())
        vm.favoriteIDs = ["2baf70d1-42bb-4437-b551-e5fed5a87abe"]
        return vm
    }
}
