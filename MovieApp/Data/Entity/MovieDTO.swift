//
//  MovieDTO.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

// MARK: - MovieDTO
/// Holds the Movie data as DTOs.
struct MovieDTO: Decodable {
    var id: Int
    var title: String
    var voteAverage: Double?
    var voteCount: Int?
    var poster: String?
    var originalTitle: String?
    var overview: String?
    var cover: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case poster = "poster_path"
        case originalTitle = "original_title"
        case cover = "backdrop_path"
        case releaseDate = "release_date"
    }
}


//MARK: -
extension MovieDTO: AnyConverter {
    func convert() -> Movie {
        return Movie(self)
    }
}

