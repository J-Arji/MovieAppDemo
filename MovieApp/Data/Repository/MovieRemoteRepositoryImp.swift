//
//  MovieRemoteRepositoryImp.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

class MovieRemoteRepositoryImp: MovieRepository {
    var storage: StorageServicable
    
    init(storage: StorageServicable) {
        self.storage = storage
    }
    
    func search(query: String, page: Int) async throws -> PaginationDTO<MovieDTO> {

    }
    
    func detail(id: String) async throws -> MovieDTO {
    }
    
}
