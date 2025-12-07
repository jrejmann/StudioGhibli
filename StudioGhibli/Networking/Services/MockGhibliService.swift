//
//  MockGhibliService.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation

struct MockGhibliService: GhibliService {

    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }

    private func loadSampleData() throws -> SampleData {
        guard
            let url = Bundle.main.url(
                forResource: "SampleData",
                withExtension: "json"
            )
        else {
            throw APIError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.networkError(error)
        }
    }

    // MARK: - Protocol conformance

    func fetchFilms() async throws -> [Film] {
        let data = try loadSampleData()
        return data.films
    }

    func fetchPerson(from URLString: String) async throws -> Person {
        let data = try loadSampleData()
        return data.people.first!
    }

    func searchFilm(for searchTerm: String) async throws -> [Film] {
        let allFilms = try await fetchFilms()

        return allFilms.filter { film in
            film.title.localizedStandardContains(searchTerm)
        }
    }
    // MARK: - Preview / Testing only

    func fetchFilm() async throws -> Film {
        let data = try! loadSampleData()
        return data.films.first!
    }

}
