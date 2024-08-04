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
    
    var movieService: Factory<MovieService> {
        Factory(self) { MovieServiceImp(storage: self.storage())}
    }

}


// MARK: - Repositories
extension Container {
    var movieRepository: Factory<MovieRepository> {
        Factory(self) { MovieRemoteRepositoryImp(remote: self.movieService() ) }
    }
}


// MARK: - Coordinator
extension Container {
    var searchCoordinator: Factory<SearchCoordinatorInterface> {
        Factory(self) { SearchCoordinator(service: self.movieRepository() ) }
    }
    
    func detailCoordinator(movie: Movie) -> Factory<DetailCoordinatorInterface> {
        Factory(self) { DetailCoordinator(movie: movie) }
    }
}
