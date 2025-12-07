//
//  FavoritesStorage.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation

protocol FavoritesStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
