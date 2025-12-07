//
//  FilmDetailViewModel.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation
import Observation
import Playgrounds

@Observable
class FilmDetailViewModel {
    var state: LoadingState<[Person]> = .idle

    private let service: GhibliService

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    func fetch(for film: Film) async {
        guard !state.isLoading else { return }

        state = .loading

        var loadedPeople: [Person] = []

        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personURL in film.people {
                    group.addTask {
                        return try await self.service.fetchPerson(
                            from: personURL
                        )
                    }
                }

                for try await person in group {
                    loadedPeople.append(person)
                }
            }

            state = .loaded(loadedPeople)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}

#Playground {
    let service = MockGhibliService()
    let vm = FilmDetailViewModel(service: service)

    do {
        let film = try await service.fetchFilm()
        await vm.fetch(for: film)

        switch vm.state {
        case .loading: print("loading")
        case .idle: print("idle")
        case .loaded(let people):
            for person in people {
                print(person)
            }
            print("loaded for preview")
        case .error(let error): print(error)
        }
    } catch {
        print("Failed to load film: \(error)")
    }

}
