//
//   Dictionary+Extension.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

extension Dictionary {

    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }

    func toJSONString() -> String? {
        if let jsonData = jsonData {
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        }
        return nil
    }
}
