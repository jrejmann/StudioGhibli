//
//  DefaultFavoritesStorage.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation

struct DefaultFavoritesStorage: FavoritesStorage {
    private let favoritesKey = "GhibliStudio.FavoriteFilms"

    func load() -> Set<String> {
        let data = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        return Set(data)
    }

    func save(favoriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesKey)
    }
}
