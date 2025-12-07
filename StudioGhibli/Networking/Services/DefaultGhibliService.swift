//
//  DefaultGhibliService.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation

struct DefaultGhibliService: GhibliService {

    private func fetch<T: Decodable>(from URLString: String, type: T.Type)
        async throws -> T
    {
        guard let url = URL(string: URLString) else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                throw APIError.invalidResponse
            }

            return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }

    func fetchFilms() async throws -> [Film] {
        let url = "https://ghibliapi.vercel.app/films"
        return try await fetch(from: url, type: [Film].self)
    }

    func fetchPerson(from URLString: String) async throws -> Person {
        return try await fetch(from: URLString, type: Person.self)
    }

    func searchFilm(for searchTerm: String) async throws -> [Film] {
        // API does not have endpoint for search parameter, otherwise it should be used
        let allFilms = try await fetchFilms()

        return allFilms.filter { film in
            film.title.localizedStandardContains(searchTerm)
        }
    }
}
