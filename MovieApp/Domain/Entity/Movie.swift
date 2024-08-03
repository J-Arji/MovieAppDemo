//
//  Movie.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation


struct Movie: Hashable  {
    var id: Int
    var title: String
    var poster: String?
    var overview: String?
    var cover: String?
    var releaseDate: String?
}



//MARK: - Movie
/// Creates an instance of Movie struct with given MovieDTO
extension Movie {
    
    init(_ dto: MovieDTO) {
        id = dto.id
        title = dto.title
        poster = dto.poster
        cover = dto.cover
        overview = dto.overview
        releaseDate = dto.releaseDate
    }
}

extension Movie {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

