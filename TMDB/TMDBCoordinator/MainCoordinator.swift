//
//  MainCoordinator.swift
//  TMDB
//
//  Created by Tuyen Le on 6/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import AVKit

struct MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    func navigateToMovieDetail(id: Int) {
        let movieDetailVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbMovieDetail) as! TMDBMovieDetailViewController
        movieDetailVC.movieId = id
        movieDetailVC.coordinator = MainCoordinator(navigationController: navigationController)
        movieDetailVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        movieDetailVC.navigationItem.backBarButtonItem?.tintColor = Constant.Color.backgroundColor
        navigationController.pushViewController(movieDetailVC, animated: true)
    }

    func navigateToVideoPlayer(with videoURL: URL) {
        let videoPlayerVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbVideoPlayer) as! TMDBVideoPlayerViewController
        videoPlayerVC.url = videoURL
        navigationController.present(videoPlayerVC, animated: true, completion: nil)
    }
}
