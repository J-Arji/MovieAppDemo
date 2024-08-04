//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit
import Factory

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    @Injected(\.storage) var storage

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = scene as? UIWindowScene  else { return }
        self.window = UIWindow(windowScene: windowScene)
        setupLanguage()
        appCoordinator = AppCoordinator(window: window!, navigationController: UINavigationController())
        appCoordinator.start()
    }
    
    private func setupLanguage() {
        print(Locale.current.language.languageCode?.identifier)
        guard let language = Locale.current.language.languageCode?.identifier else { return }
        storage.language = Language.init(rawValue: language) ?? .english

    }
}

