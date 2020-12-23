//
//  SceneDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 04.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var authentication: TMDBAuthenticationRepository!
    var homeCoordinator: Coordinator?
    var movieCoordinator: Coordinator?
    var tvCoordinator: Coordinator?
    var peopleCoordinator: Coordinator?
    var defaultContainer: DefaultContainer = DefaultContainer()
    var appCoordinator: AppCoordinator!

    let tabBarController = UITabBarController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let win = UIWindow(windowScene: windowScene)
        
        let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                
            }
        })
        
        appCoordinator = AppCoordinator(window: win, container: defaultContainer.container)
        authentication = defaultContainer.container.resolve(TMDBAuthenticationRepository.self)
        
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
        let homeView = appCoordinator.homeView
        homeView.delegate = appCoordinator
        appCoordinator.currentView = homeView

        // set navigation controller
        let homeNavController = UINavigationController(rootViewController: homeView)
        homeNavController.navigationBar.barTintColor = Constant.Color.primaryColor
        homeNavController.tabBarItem.title = NSLocalizedString("Home", comment: "")
        homeNavController.tabBarItem.image = UIImage(systemName: "house.fill")
        
        homeView.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        homeView.navigationItem.backBarButtonItem?.tintColor = Constant.Color.backgroundColor
        
        // set tabbar controller
        tabBarController.tabBar.barTintColor = Constant.Color.primaryColor
        tabBarController.tabBar.unselectedItemTintColor = Constant.Color.secondaryColor
        tabBarController.tabBar.tintColor = Constant.Color.tabBarSelectedTextColor
        tabBarController.setViewControllers([homeNavController], animated: true)
        
        tabBarController
            .rx
            .didSelect
            .subscribe { event in
                guard let navController = event.element as? UINavigationController else {
                    return
                }
                
                if let homeview = navController.viewControllers.first as? HomeView {
                    self.appCoordinator.currentView = homeview
                }
            }
            .disposed(by: rx.disposeBag)
        win.makeKeyAndVisible()
        win.rootViewController = tabBarController
        window = win

        // get guest session for rating
        authentication.getGuestSession()
    }
}

