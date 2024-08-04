//
//  PaginationDTO.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

/// Holds the paginated data as DTOs.
struct PaginationDTO<T: Decodable & AnyConverter>: Decodable {
    var page: Int
    var results: [T]
    var totalPage: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPage = "total_pages"
        case totalResults = "total_results"
    }
}


//MARK: - toDomain
extension PaginationDTO {
    /// Converts PaginationDTO to Pagination using a provided
    func toDomain() -> Pagination<T.Output> {
        return Pagination(
            results: results.map { $0.convert() },
            page: page,
            totalPage: totalPage,
            totalResults: totalResults
        )
    }
}
