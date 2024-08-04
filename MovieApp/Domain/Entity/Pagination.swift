//
//  Pagination.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation


// MARK: - ModelPage
struct Pagination<T> {
    let results: [T]
    let page: Int
    let totalPage: Int
    let totalResults: Int

}


//MARK: - loadMore
extension Pagination {
    var hasMorePages: Bool {
        page * totalPage < totalResults
    }
}
