//
//  MainCoordinator.swift
//  TMDB
//
//  Created by Tuyen Le on 6/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

struct MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    func navigateToMovieDetail(id: Int) {
        let movieDetailVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbMovieDetail) as! TMDBMovieDetailViewController
        movieDetailVC.movieId = id
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
}
