//
//  MovieRepository.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

/// MARK: - MovieRepository
/// This is repository model that it have to implement when we want  have search object (movie , people and Tv show)

protocol MovieRepository {
    //  MARK: - search
    ///
    /// Returns search results for movies  based on a query.
    /// - Parameters:
    ///    - query: A text query to search for.
    ///    - page: The page of results to return.
    ///
    /// - Throws:  error ``DataTransferError``.
    ///
    /// - Returns: Movies matching the query.
    ///
    func search(query: String, page: Int) async throws -> PaginationDTO<MovieDTO>
    
    //  MARK: - detail
    ///
    /// Returns search results for detail movie based on a id.
    /// - Parameters:
    ///    - id: movie id
    ///
    ///
    /// - Throws:  error ``DataTransferError``.
    ///
    /// - Returns: Movie matching the id.
    ///
    func detail(id: String) async throws -> MovieDTO
}

