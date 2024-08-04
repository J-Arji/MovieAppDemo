//
//  StorageService.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

protocol StorageServicable {
    var language: Language { get set }
    var apiKey: String? { get set }
    func setup()
}


class StorageService: StorageServicable {
    // MARK: - UserInfo
    @Stored(key: "jarji.MovieApp.token", in: .keychain) var apiKey: String? = nil
    
    // MARK: - Language
    @Stored(key: "jarji.MovieApp.Language") var language: Language = .english
    
    
    
    @MainActor public func setup() {
        guard let key =  Bundle.main.info(for: "API_KEY")  else { fatalError("Please Set API Key") }
        //Note: please first set Key
        apiKey = key
    }
}

