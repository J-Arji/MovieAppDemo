//
//  SearchCoordinator.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit


protocol SearchCoordinatorInterface: Coordinator {
    var navigationController: UINavigationController? { get set }
}


enum SearchChild {
    case detail
}

final class SearchCoordinator: SearchCoordinatorInterface {
    //MARK: - Properties
    var children = [SearchChild: Coordinator]()
    var navigationController: UINavigationController?
    
    
    
    func start() {
  
    }
}
