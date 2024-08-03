//
//  ErrorModel.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

struct ErrorModel: Decodable {
    var success: Bool
    var code: Int
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case code = "status_code"
        case message = "status_message"
    }
    
}

