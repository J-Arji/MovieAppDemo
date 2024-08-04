//
//  Coordinator.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit

protocol Coordinator: AnyObject {
    /**
     Entry point starting the coordinator
     */
    func start()
}

protocol NavigationCoordinator: Coordinator {
    /**
     Navigation controller
     */
    var navigationController: UINavigationController { get }
}
