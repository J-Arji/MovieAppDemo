//
//  SearchInput.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

struct SearchInput: Encodable {
    var query: String
    var isIncludeAdult: Bool
    var language: String
    var page: Int
    
    enum CodingKeys: String, CodingKey {
        case query
        case isIncludeAdult = "include_adult"
        case language
        case page
    }
    
    init(query: String, isIncludeAdult: Bool, language: String, page: Int) {
        self.query = query
        self.isIncludeAdult = isIncludeAdult
        self.language = language
        self.page = page
    }
    
    init (query: String, page: Int) {
        self.init(query: query, isIncludeAdult: false, language: "en-US", page: page)
    }
}
