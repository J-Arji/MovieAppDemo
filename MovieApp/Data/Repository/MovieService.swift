//
//  MovieService.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
import Factory

protocol MovieService {

    func search(query: String, page: Int) async throws -> PaginationDTO<MovieDTO>
    
    func detail(id: String) async throws -> MovieDTO
}


class MovieServiceImp: MovieService, APIClient {
    var storage: StorageServicable
    
    private var defualtInput: GlobalInput {
        return GlobalInput(apiKey: storage.apiKey, language: storage.language.rawValue)
    }
    
   init(storage: StorageServicable) {
       self.storage = storage
   }
   
   func search(query: String, page: Int) async throws -> PaginationDTO<MovieDTO> {
       let input = SearchInput(query: query, page: page, item: defualtInput)
       return try await request(endpoint: Router.search(input: input))
   }
   
   func detail(id: String) async throws -> MovieDTO {
       return try await request(endpoint: Router.detail(id: id, query: defualtInput))
   }
}

extension MovieServiceImp {
    enum Router {
        case search(input: SearchInput)
        case detail(id: String, query: GlobalInput)
    }
}


//MARK: - Endpoint
extension MovieServiceImp.Router: Endpoint {
    var path: String {
        switch self {
        case .search:
            return API.search(.movie).url
        case let .detail(id, _):
            return  API.detail(.movie, id: id).url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search, .detail:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return  [
            "Content-Type"  : "application/json; charset=utf-8",
            "accept"        : "application/json"
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .search(input):
            return input.queryItems
            
        case let .detail(_, query):
            return query.queryItems
        }
    }
}
