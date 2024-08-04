//
//  AppCoordinatorInterface.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//


import UIKit
import Factory

protocol AppCoordinatorInterface: Coordinator {
    var window: UIWindow! { get set }
    
    func pushDetailViewController()
}

enum AppChild {
    case search
}

final class AppCoordinator: AppCoordinatorInterface {
    
    // MARK: - Properties
    private(set) var navigationController: UINavigationController!
    var children = [AppChild: Coordinator]()
    var window: UIWindow!
    @Injected(\.storage) var storage: StorageServicable


    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.window.rootViewController = navigationController
        storage.setup()

    }
    
    
    func start() {
        let searchCoordinator = Container.shared.searchCoordinator()
        children[.search] = searchCoordinator
        searchCoordinator.navigationController = navigationController
        searchCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    deinit {
        #if DEBUG
        print("🔴","deallocing \(self)")
        #endif
    }

   
}

extension AppCoordinator {
    func pushDetailViewController() {
        
    }
}

