//
//  String + url.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

extension String {
    func resource(type: API.ImageSize) -> String? {
        switch type {
        case .original:
            return type.url + self
        case .small:
            return type.url + self
        }
    }
}
