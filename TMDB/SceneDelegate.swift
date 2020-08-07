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

        // set view controller
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbHome) as! TMDBHomeViewController
        let movieVC = TMDBMovieViewController()
        let tvVC = TMDBTelevisionViewController()
        let searchVC = TMDBSearchViewController()
        
        let tmdbLogo = UIImage(named: Constant.imageLogo)?.withRenderingMode(.alwaysOriginal)
        let imageBarButtonItem = UIBarButtonItem(image: tmdbLogo, landscapeImagePhone: tmdbLogo, style: .plain, target: nil, action: nil)

        homeVC.navigationItem.setLeftBarButton(imageBarButtonItem, animated: true)
        movieVC.navigationItem.setLeftBarButton(imageBarButtonItem, animated: true)
        tvVC.navigationItem.setLeftBarButton(imageBarButtonItem, animated: true)

        // set navigation controller
        let homeNavController = UINavigationController(rootViewController: homeVC)
        homeNavController.navigationBar.barTintColor = Constant.Color.primaryColor
        homeNavController.tabBarItem.title = NSLocalizedString("Home", comment: "")
        homeNavController.tabBarItem.image = UIImage(systemName: "house.fill")
        
        homeVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        homeVC.navigationItem.backBarButtonItem?.tintColor = Constant.Color.backgroundColor
        
        let movieNavController = UINavigationController(rootViewController: movieVC)
        movieNavController.navigationBar.barTintColor = Constant.Color.primaryColor
        movieNavController.tabBarItem.title = NSLocalizedString("Movies", comment: "")
        movieNavController.tabBarItem.image = UIImage(systemName: "film.fill")

        let tvNavController = UINavigationController(rootViewController: tvVC)
        tvNavController.navigationBar.barTintColor = Constant.Color.primaryColor
        tvNavController.tabBarItem.title = NSLocalizedString("TV Shows", comment: "")
        tvNavController.tabBarItem.image = UIImage(systemName: "tv.fill")


        let searchNavController = UINavigationController(rootViewController: searchVC)
        searchNavController.navigationBar.barTintColor = Constant.Color.primaryColor
        searchNavController.navigationBar.tintColor = Constant.Color.backgroundColor
        searchNavController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchNavController.tabBarItem.title = NSLocalizedString("Search", comment: "")
        
        // set coordinators
        searchVC.coordinate = MainCoordinator(navigationController: searchNavController)
        homeVC.coordinator = MainCoordinator(navigationController: homeNavController)
        
        // set tabbar controller
        tabBarController.tabBar.barTintColor = Constant.Color.primaryColor
        tabBarController.tabBar.unselectedItemTintColor = Constant.Color.secondaryColor
        tabBarController.tabBar.tintColor = Constant.Color.tabBarSelectedTextColor
        tabBarController.setViewControllers([homeNavController, movieNavController, tvNavController, searchNavController], animated: true)

        win.makeKeyAndVisible()
        win.rootViewController = tabBarController
        window = win
    }
}

