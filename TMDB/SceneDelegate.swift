//
//  SceneDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 04.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var locationManager: TMDBLocationManager = TMDBLocationManager(setting: TMDBUserSetting(userDefault: UserDefaults.standard), locationService: TMDBGeocoder())

    var homeCoordinator: MainCoordinator?
    var movieCoordinator: MainCoordinator?
    var tvCoordinator: MainCoordinator?
    var peopleCoordinator: MainCoordinator?

    let tabBarController = UITabBarController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let win = UIWindow(windowScene: windowScene)

        // request user current location
        locationManager.manager.requestWhenInUseAuthorization()

        // set view controller
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbHome)
        let movieVC = TMDBMovieViewController()
        let tvVC = TMDBTelevisionViewController()
        let peopleVC = TMDBPeopleViewController()
        
        let tmdbLogo = UIImage(named: Constant.imageLogo)?.withRenderingMode(.alwaysOriginal)
        let imageBarButtonItem = UIBarButtonItem(image: tmdbLogo, landscapeImagePhone: tmdbLogo, style: .plain, target: nil, action: nil)

        (homeVC as? TMDBHomeViewController)?.repository.updateImageConfig()

        homeVC.navigationItem.setLeftBarButton(imageBarButtonItem, animated: true)
        movieVC.navigationItem.setLeftBarButton(imageBarButtonItem, animated: true)
        tvVC.navigationItem.setLeftBarButton(imageBarButtonItem, animated: true)
        peopleVC.navigationItem.setLeftBarButton(imageBarButtonItem, animated: true)

        // set navigation controller
        let homeNavController = UINavigationController(rootViewController: homeVC)
        homeNavController.navigationBar.barTintColor = Constant.Color.primaryColor
        homeNavController.tabBarItem.title = NSLocalizedString("Home", comment: "")
        homeNavController.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let movieNavController = UINavigationController(rootViewController: movieVC)
        movieNavController.navigationBar.barTintColor = Constant.Color.primaryColor
        movieNavController.tabBarItem.title = NSLocalizedString("Movies", comment: "")
        movieNavController.tabBarItem.image = UIImage(systemName: "film.fill")

        let tvNavController = UINavigationController(rootViewController: tvVC)
        tvNavController.navigationBar.barTintColor = Constant.Color.primaryColor
        tvNavController.tabBarItem.title = NSLocalizedString("TV Shows", comment: "")
        tvNavController.tabBarItem.image = UIImage(systemName: "tv.fill")
        
        let peopleNavController = UINavigationController(rootViewController: peopleVC)
        peopleNavController.navigationBar.barTintColor = Constant.Color.primaryColor
        peopleNavController.tabBarItem.title = NSLocalizedString("People", comment: "")
        peopleNavController.tabBarItem.image = UIImage(systemName: "person.2.fill")

        // set coordinators
        homeCoordinator = MainCoordinator(navigationController: homeNavController)
        movieCoordinator = MainCoordinator(navigationController: movieNavController)
        tvCoordinator = MainCoordinator(navigationController: tvNavController)
        peopleCoordinator = MainCoordinator(navigationController: peopleNavController)
        
        // set tabbar controller
        tabBarController.tabBar.barTintColor = Constant.Color.primaryColor
        tabBarController.tabBar.unselectedItemTintColor = Constant.Color.secondaryColor
        tabBarController.tabBar.tintColor = Constant.Color.tabBarSelectedTextColor
        tabBarController.setViewControllers([homeNavController, movieNavController, tvNavController, peopleNavController], animated: true)

        win.makeKeyAndVisible()
        win.rootViewController = tabBarController
        window = win
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

