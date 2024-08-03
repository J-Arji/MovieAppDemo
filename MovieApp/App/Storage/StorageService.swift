//
//  StorageService.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
protocol StorageServicable {
    var apiKey: String? { get set }
    func setup()
}


class StorageService: StorageServicable {
    // MARK: - UserInfo
    @Stored(key: "jarji.MovieApp.token", in: .keychain) var apiKey: String? = nil

    
    
    @MainActor public func setup() {
    }
}

