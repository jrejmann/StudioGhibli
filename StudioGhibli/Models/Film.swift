//
//  Film.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation
import Playgrounds

struct Film: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String

    let releaseYear: String
    let duration: String
    let score: String
    let image: String
    let bannerImage: String

    let people: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people

        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
        case bannerImage = "movie_banner"
    }
}

// MARK: - Preview sample
extension Film {
    static let preview = Film(
        id: "2baf70d1-42bb-4437-b551-e5fed5a87abe",
        title: "Castle in the Sky",
        description:
            "The orphan Sheeta inherited a mysterious crystal... (preview sample)",
        director: "Hayao Miyazaki",
        producer: "Isao Takahata",
        releaseYear: "1986",
        duration: "124",
        score: "95",
        image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg",
        bannerImage: "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg",
        people: [
            "https://ghibliapi.vercel.app/people/267649ac-fb1b-11eb-9a03-0242ac130003",
            "https://ghibliapi.vercel.app/people/fe93adf2-2f3a-4ec4-9f68-5422f1b87c01",
            "https://ghibliapi.vercel.app/people/598f7048-74ff-41e0-92ef-87dc1ad980a9",
        ]
    )
}

#Playground {
    let url = URL(string: "https://ghibliapi.vercel.app/films")!

    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        try JSONDecoder().decode([Film].self, from: data)
    } catch {
        print(error)
    }
}
