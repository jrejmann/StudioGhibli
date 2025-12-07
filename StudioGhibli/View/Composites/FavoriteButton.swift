//
//  FavoriteButton.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FavoriteButton: View {
    var isFavorite: Bool
    var onToggle: () -> Void
    
    var body: some View {
        Button {
            onToggle()
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? .red : .gray)
        }
        .buttonStyle(.plain)
        .controlSize(.large)
    }
}
