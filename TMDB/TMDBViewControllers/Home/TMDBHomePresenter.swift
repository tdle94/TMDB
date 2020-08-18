//
//  TMDBHomePresenter.swift
//  TMDB
//
//  Created by Tuyen Le on 8/17/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

class TMDBHomePresenter {
    private let repository: TMDBRepository = TMDBRepository.share

    weak private var homeViewDelegate: TMDBHomeViewDelegate?
    
    enum `Type` {
        case popularMovie
        case popularTVShow
        case none
    }

    private lazy var movieHandler: (TMDBHomePresenter.`Type`) -> ((Result<MovieResult, Error>) -> Void) = { type in
        return { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let movieResult):
                self.homeViewDelegate?.displayMovies(Array(movieResult.movies), type: type)
            }
        }
    }

    private lazy var tvShowHandler: (TMDBHomePresenter.`Type`) -> ((Result<TVShowResult, Error>) -> Void) = { type in
        return { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let tvShowResult):
                self.homeViewDelegate?.displayTVShows(Array(tvShowResult.onTV), type: type)
            }
        }
    }

    private lazy var peopleHandle: (Result<PeopleResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let peopleResult):
            self.homeViewDelegate?.displayPeople(Array(peopleResult.peoples))
        }
    }

    private lazy var trendingHandler: (Result<TrendingResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let trendingResult):
            self.homeViewDelegate?.displayTrends(Array(trendingResult.trending))
        }
    }

    init(delegate: TMDBHomeViewDelegate) {
        homeViewDelegate = delegate
    }

    // MARK: - popular
    func getPopularMovie(page: Int) {
        repository.getPopularMovie(page: page, completion: movieHandler(.popularMovie))
    }

    func getPopularTVShow(page: Int) {
        repository.getPopularOnTV(page: page, completion: tvShowHandler(.popularTVShow))
    }

    func getPopularPeople(page: Int) {
        repository.getPopularPeople(page: page, completion: peopleHandle)
    }
    
    // MARK: - trend
    func getTrend(page: Int, time: TrendingTime) {
        repository.getTrending(time: time, type: .all, completion: trendingHandler)
    }
    
    // MARK: - movie
    func getTopRatedMovie(page: Int) {
        repository.getTopRateMovie(page: page, completion: movieHandler(.none))
    }
    
    func getNowPlayingMovie(page: Int) {
        repository.getNowPlayingMovie(page: page, completion: movieHandler(.none))
    }
    
    func getUpcomingMovie(page: Int) {
        repository.getUpcomingMovie(page: page, completion: movieHandler(.none))
    }
    
    // MARK: - tv show
    func getTopRatedTVShow(page: Int) {
        repository.getTopRatedTVShow(page: page, completion: tvShowHandler(.none))
    }
    
    func getTVShowAirToday(page: Int) {
        repository.getTVShowAiringToday(page: page, completion: tvShowHandler(.none))
    }
    
    func getTVShowOnTheAir(page: Int) {
        repository.getTVShowOnTheAir(page: page, completion: tvShowHandler(.none))
    }
}
