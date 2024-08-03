//
//  Bundle + info.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

public extension Bundle {
    func info(for key: String) -> String? {
        guard let value = infoDictionary?[key] else { return nil }
        return (value as! String).replacingOccurrences(of: "\\", with: "")
    }
}
