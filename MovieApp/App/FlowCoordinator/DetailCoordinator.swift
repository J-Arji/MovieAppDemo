//
//  DetailCoordinator.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit

protocol DetailCoordinatorInterface: Coordinator {
    var navigationController: UINavigationController? { get set }
    var movie: Movie { get }
}


final class DetailCoordinator: DetailCoordinatorInterface {
    var navigationController: UINavigationController?
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    
    @MainActor
    func start() {
       
    }
}
