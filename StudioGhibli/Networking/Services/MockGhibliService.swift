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

    func fetchFilms() async throws -> [Film] {
        let data = try loadSampleData()
        return data.films
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        // Extract ID from the URL's last path component
        guard let url = URL(string: URLString) else {
            throw APIError.invalidURL
        }
        let id = url.lastPathComponent

        let data = try loadSampleData()
        if let person = data.people.first(where: { $0.id == id }) {
            return person
        } else {
            // If the specific person isn't present in the sample data
            throw APIError.invalidResponse
        }
    }
}
