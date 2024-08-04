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
   
   init(storage: StorageServicable) {
       self.storage = storage
   }
   
   func search(query: String, page: Int) async throws -> PaginationDTO<MovieDTO> {
       let input = SearchInput(query: query, page: page)
       return try await request(endpoint: Router.search(input: input))
   }
   
   func detail(id: String) async throws -> MovieDTO {
       return try await request(endpoint: Router.detail(id: id))
   }
}

extension MovieServiceImp {
    enum Router {
        case search(input: SearchInput)
        case detail(id: String)
    }
}


//MARK: - Endpoint
extension MovieServiceImp.Router: Endpoint {
    var path: String {
        switch self {
        case .search:
            return API.search(.movie).url
        case let .detail(id):
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
        var query: [URLQueryItem] = [URLQueryItem(name: "api_key", value: Container.shared.storage().apiKey)]
        switch self {
        case let .search(input):
            let items = input.queryItems ?? []
            query.append(contentsOf: items)
            return query
            
        default:
            return query
        }
    }
}
