//
//  FilmImageView.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import SwiftUI

struct FilmImageView: View {
    let url: URL?
    
    init(urlPath: String) {
        self.url = URL(string: urlPath)
    }
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: url) {
            phase in
            switch phase {
            case .empty:
                Color(white: 0.8)
                    .overlay {
                        ProgressView()
                            .controlSize(.large)
                    }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure(_):
                Text("Could not get image")
            @unknown default:
                fatalError()
            }
        }
    }
}

#Preview("Poster image") {
    FilmImageView(url: URL.convertAssetImage(named: "posterImage")!)
        .frame(height: 150)
}

#Preview("Banner image") {
    FilmImageView(url: URL.convertAssetImage(named: "bannerImage")!)
        .frame(height: 300)
}
