//
//  Codable+Dic.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

// MARK: - Encodable
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    var queryItems: [URLQueryItem]? {
        dictionary?.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
    }
}
