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

    func navigateToReview(reivew: [Review]) {
        let reviewTableViewVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbReviewVC) as! TMDBReivewTableViewController
        reviewTableViewVC.review = reivew
        navigationController.pushViewController(reviewTableViewVC, animated: true)
    }
    
    func navigateToPersonDetail(id: Int) {
        let personDetailVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbPersonDetailVC) as! TMDBPersonDetailViewController
        personDetailVC.personId = id
        personDetailVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(personDetailVC, animated: true)
    }
    
    func navigateToCompleteReleaseDates(movieId: Int) {
        let releaseDateTableVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbCompleteReleaseDateTableVC) as! TMDBCompleteReleaseDateTableViewController
        releaseDateTableVC.movieId = movieId
        navigationController.pushViewController(releaseDateTableVC, animated: true)
    }
    
    func navigateToTVShowDetail(tvId: Int) {
        let tvShowDetailVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbTVDetailVC) as! TMDBTVDetailViewController
        tvShowDetailVC.tvId = tvId
        tvShowDetailVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(tvShowDetailVC, animated: true)
    }
    
    func navigateToTVShowSeasonDetail(tvId: Int, seasonNumber: Int) {
        let tvShowSeasonVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbTVShowSeasonVC) as! TMDBTVShowSeasonViewController
        tvShowSeasonVC.tvId = tvId
        tvShowSeasonVC.seasonNumber = seasonNumber
        tvShowSeasonVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(tvShowSeasonVC, animated: true)
    }
}
