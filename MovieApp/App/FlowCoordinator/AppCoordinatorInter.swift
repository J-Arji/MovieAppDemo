//
//  AppCoordinatorInterface.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit

protocol AppCoordinator: Coordinator {
    var window: UIWindow! { get set }
}

enum AppChild {
    case search
}

final class AppCoordinatorImp: AppCoordinator {
    
    // MARK: - Properties
    private(set) var navigationController: UINavigationController!
    var children = [AppChild: Coordinator]()
    var window: UIWindow!


    //MARK: - iniit
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.window.rootViewController = navigationController

    }
 
    
    func start() {
     
    }

    deinit {
        #if DEBUG
        print("🔴","deallocing \(self)")
        #endif
    }
    

}
