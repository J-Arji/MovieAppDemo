//
//  AppService.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Factory

extension Container {
    //MARK: - Service
    var storage: Factory<StorageServicable> {
        Factory(self) { StorageService() }
    }
}
