//
//  MockFavoritesStorage.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation

struct MockFavoritesStorage: FavoritesStorage {
    
    func load() -> Set<String> {
        return ["58611129-2dbc-4a81-a72f-77ddfc1b1b49"]
    }
    
    func save(favoriteIDs: Set<String>) {}
}
