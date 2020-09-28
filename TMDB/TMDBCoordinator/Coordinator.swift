//
//  Coordinator.swift
//  TMDB
//
//  Created by Tuyen Le on 6/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func navigateToMovieDetail(id: Int)
    func navigateToVideoPlayer(with videoURL: URL)
    func navigateToReview(reivew: [Review])
    func navigateToPersonDetail(id: Int)
    func navigateToCompleteReleaseDates(movieId: Int)
    func navigateToTVShowDetail(tvId: Int)
    func navigateToTVShowSeasonDetail(tvId: Int, seasonNumber: Int)
    func navigateToTVShowEpisodeDetail(tvId: Int, seasonNumber: Int, episodeNumber: Int)
    func navigateToAllMovie(query: DiscoverQuery)
    func navigateToAllTVShow(query: DiscoverQuery)
    func navigateToAllRecommendMovie(id: Int)
    func navigateToAllSimilarMovie(id: Int)
    func navigateToAllPopularMovie()
    func navigateToAllTopRatedMovie()
    func navigateToAllUpcomingMovie()
    func navigateToAllNowPlayingMovie()
    func navigateToSimilarTVShow(id: Int)
    func navigateToRecommendTVShow(id: Int)
    func navigateToAllPopularTVShow()
    func navigateToAllTopRatedTVShow()
    func navigateToAllTVShowAiringToday()
    func navigateToAllTVShowOnTheAir()
    func navigateToAllPopularPeople()
    func navigateToAllTrend(time: TrendingTime)
    func presentFilter(delegate: TMDBFilterDelegate, query: DiscoverQuery, choice: TMDBFilterViewController.FilterChoice)
    func presentRating(id: Int, ratingType: TMDBRatingViewController.RatingType, notifyRating: TMDBNotifyRating)
}
