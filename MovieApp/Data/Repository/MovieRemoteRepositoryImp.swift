//
//  MovieRemoteRepositoryImp.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
import Factory

class MovieRemoteRepositoryImp: MovieRepository {
    var remote: MovieService
    
    init(remote: MovieService) {
        self.remote = remote
    }
    
    func search(query: String, page: Int) async throws -> PaginationDTO<MovieDTO> {
        return try await remote.search(query: query, page: page)
    }
    
    func detail(id: String) async throws -> MovieDTO {
        return try await remote.detail(id: id)
    }
    
}
