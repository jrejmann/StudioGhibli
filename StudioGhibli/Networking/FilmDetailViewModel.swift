//
//  FilmDetailViewModel.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation
import Observation

@Observable
class FilmDetailViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }

    var state: State = .idle
    var people: [Person] = []
    
    let service: GhibliService
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch(for film: Film) async {
        self.state = .loading
        self.people = []
        var data: [Person] = []
        
        do {
            for personInfoURL in film.people {
                let person = try await service.fetchPerson(from: personInfoURL)
                data.append(person)
            }
            self.people = data
            self.state = .loaded(data)
        } catch let error as APIError {
            self.state = .error(error.localizedDescription)
        } catch {
            self.state = .error("unknown error")
        }
    }
}
