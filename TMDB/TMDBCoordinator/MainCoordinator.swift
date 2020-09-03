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

    func navigateToTVShowEpisodeDetail(tvId: Int, seasonNumber: Int, episodeNumber: Int) {
        let tvShowEpisodeVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbTVShowEpisodeVC) as! TMDBTVShowEpisodeViewController
        tvShowEpisodeVC.tvId = tvId
        tvShowEpisodeVC.seasonNumber = seasonNumber
        tvShowEpisodeVC.episodeNumber = episodeNumber
        tvShowEpisodeVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(tvShowEpisodeVC, animated: true)
    }

    func navigateToAllMovie(query: DiscoverQuery) {
        let allMovieVC = TMDBAllMovieViewController()
        allMovieVC.movieQuery = query
        allMovieVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(allMovieVC, animated: true)
    }

    func navigateToAllTVShow(query: DiscoverQuery) {
        let allTVShowVC = TMDBAllTVShowViewController()
        allTVShowVC.tvQuery = query
        allTVShowVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(allTVShowVC, animated: true)
    }
    
    func navigateToAllRecommendMovie(id: Int) {
        let recommendMovieVC = TMDBAllRecommendMovieViewController()
        recommendMovieVC.coordinate = MainCoordinator(navigationController: navigationController)
        recommendMovieVC.presenter.id = id
        navigationController.pushViewController(recommendMovieVC, animated: true)
    }
    
    func navigateToAllSimilarMovie(id: Int) {
        let similarMovieVC = TMDBAllSimilarMovieViewController()
        similarMovieVC.coordinate = MainCoordinator(navigationController: navigationController)
        similarMovieVC.presenter.id = id
        navigationController.pushViewController(similarMovieVC, animated: true)
    }

    func navigateToAllPopularMovie() {
        let popularMovieVC = TMDBAllPopularMovieViewController()
        popularMovieVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(popularMovieVC, animated: true)
    }
    
    func navigateToAllTopRatedMovie() {
        let topRatedMovieVC = TMDBAllTopRatedMovieViewController()
        topRatedMovieVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(topRatedMovieVC, animated: true)
    }

    func navigateToAllUpcomingMovie() {
        let upcomingMovieVC = TMDBAllUpcomingMovieViewController()
        upcomingMovieVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(upcomingMovieVC, animated: true)
    }

    func navigateToAllNowPlayingMovie() {
        let nowPlayingMovieVC = TMDBAllNowPlayingMovieViewController()
        nowPlayingMovieVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(nowPlayingMovieVC, animated: true)
    }
    
    func navigateToSimilarTVShow(id: Int) {
        let similarTVShow = TMDBAllSimilarTVShowViewController()
        similarTVShow.coordinate = MainCoordinator(navigationController: navigationController)
        similarTVShow.presenter.id = id
        navigationController.pushViewController(similarTVShow, animated: true)
    }
    
    func navigateToRecommendTVShow(id: Int) {
        let recommendTVShow = TMDBAllRecommendTVShowViewController()
        recommendTVShow.coordinate = MainCoordinator(navigationController: navigationController)
        recommendTVShow.presenter.id = id
        navigationController.pushViewController(recommendTVShow, animated: true)
    }

    func navigateToAllPopularTVShow() {
        let popularTVShow = TMDBAllPopularTVShowController()
        popularTVShow.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(popularTVShow, animated: true)
    }
    
    func navigateToAllTopRatedTVShow() {
        let topRatedTVShow = TMDBAllTopRatedTVShowViewController()
        topRatedTVShow.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(topRatedTVShow, animated: true)
    }
    
    func navigateToAllTVShowAiringToday() {
        let tvShowAiringTodayVC = TMDBAllTVShowAirTodayViewController()
        tvShowAiringTodayVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(tvShowAiringTodayVC, animated: true)
    }
    
    func navigateToAllTVShowOnTheAir() {
        let tvShowOnTheAirVC = TMDBAllTVShowOnTheAirViewController()
        tvShowOnTheAirVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(tvShowOnTheAirVC, animated: true)
    }
    
    func navigateToAllPopularPeople() {
        let popularPeople = TMDBAllPopularPeopleController()
        popularPeople.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(popularPeople, animated: true)
    }

    func navigateToAllTrend(time: TrendingTime) {
        let trendingVC = TMDBAllTrendingViewController(time: time)
        trendingVC.coordinate = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(trendingVC, animated: true)
    }

    func presentFilter(delegate: TMDBFilterDelegate, query: DiscoverQuery, choice: TMDBFilterViewController.FilterChoice) {
        let filterNav = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbFilterNav) as! UINavigationController
        let filterVC = filterNav.viewControllers.first as? TMDBFilterViewController
        filterVC?.delegate = delegate
        filterVC?.query = query
        filterVC?.filterChoice = choice
        navigationController.present(filterNav, animated: true)
    }
}
