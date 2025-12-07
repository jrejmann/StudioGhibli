//
//  Untitled.swift
//  StudioGhibli
//
//  Created by Kuba Rejmann on 07/12/2025.
//

import Foundation

protocol GhibliService {
    func fetchFilms() async throws -> [Film]
}
