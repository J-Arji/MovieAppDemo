//
//  SearchCoordinator.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit
import Factory

protocol SearchCoordinatorInterface: Coordinator {
    var navigationController: UINavigationController? { get set }
}
protocol ShowDetailsDelegate: AnyObject {
    func push(movie: Movie)
}

enum SearchChild {
    case detail
}

final class SearchCoordinator: SearchCoordinatorInterface {
    var children = [SearchChild: Coordinator]()
    var navigationController: UINavigationController?
    private var service: MovieRepository
    
    init(service: MovieRepository) {
        self.service = service
    }
    
    func start() {
        let isNavigationStackEmpty = navigationController?.viewControllers.isEmpty ?? false
        let viewModel = SearchViewModel(service: service, detailBuilder: self)
        let SearchVC = SearchVC(viewModel: viewModel)
        navigationController?.pushViewController(SearchVC, animated: true)
        
        // SearchView should be always the top most VC
        if !isNavigationStackEmpty {
            navigationController?.viewControllers.remove(at: 0)
        }
    }

}

extension SearchCoordinator: ShowDetailsDelegate {
    
    func push(movie: Movie) {
        let coordinatorFactory = Container.shared.detailCoordinator(movie: movie)
        let coordinator = coordinatorFactory()
        coordinator.navigationController = self.navigationController
        self.children[.detail] = coordinator
        coordinator.start()
    }
}
