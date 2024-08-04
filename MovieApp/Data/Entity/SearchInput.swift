//
//  SearchInput.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

struct SearchInput: Encodable {
    
    var apiKey: String?
    var query: String
    var isIncludeAdult: Bool
    var language: String
    var page: Int
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case query
        case isIncludeAdult = "include_adult"
        case language
        case page
    }
    
    init(apiKey: String?, query: String, isIncludeAdult: Bool, language: String, page: Int) {
        self.apiKey = apiKey
        self.query = query
        self.isIncludeAdult = isIncludeAdult
        self.language = language
        self.page = page
    }
   
    
    init (query: String, page: Int, item: GlobalInput) {
        self.init(apiKey: item.apiKey, query: query, isIncludeAdult: false, language: item.language, page: page)
    }
}

struct GlobalInput: Encodable {
    var apiKey: String?
    var language: String
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case language
    }
}
