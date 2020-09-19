//
//  TMDBAllPresenter.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

class TMDBAllPresenter {
    let repository: TMDBRepository = TMDBRepository.share

    var page: Int = 1

    var id: Int?

    private lazy var movieHandler: (Result<MovieResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
            self.showAllDelegate?.displayAll(objects: [])
        case .success(let movieResult):
            self.showAllDelegate?.displayAll(objects: Array(movieResult.movies))
        }
    }
    
    private lazy var tvShowHandler: (Result<TVShowResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
            self.showAllDelegate?.displayAll(objects: [])
        case .success(let tvShowResult):
            self.showAllDelegate?.displayAll(objects: Array(tvShowResult.onTV))
        }
    }

    weak var showAllDelegate: TMDBShowAllDelegate?

    init(delegate: TMDBShowAllDelegate) {
        showAllDelegate = delegate
    }

    // MARK: - movie service

    func getAllMovie(query: DiscoverQuery) {
        repository.getAllMovie(query: query, completion: movieHandler)
    }

    func getUpcomingMovie(page: Int) {
        repository.getUpcomingMovie(page: page, completion: movieHandler)
    }

    func getNowPlayingMovie(page: Int) {
        repository.getNowPlayingMovie(page: page, completion: movieHandler)
    }

    func getTopRatedMovie(page: Int) {
        repository.getTopRateMovie(page: page, completion: movieHandler)
    }

    func getPopularMovie(page: Int) {
        repository.getPopularMovie(page: page, completion: movieHandler)
    }
    
    func getSimilarMovie(id: Int, page: Int) {
        repository.getSimilarMovies(from: id, page: page, completion: movieHandler)
    }
    
    func getRecommendMovie(id: Int, page: Int) {
        repository.getRecommendMovies(from: id, page: page, completion: movieHandler)
    }
    
    // MARK: - tvshow service

    func getAllTVShow(tvShowQuery: DiscoverQuery) {
        repository.getAllTVShow(query: tvShowQuery, completion: tvShowHandler)
    }

    func getPopularTVShow(page: Int) {
        repository.getPopularOnTV(page: page, completion: tvShowHandler)
    }

    func getTopRatedTVShow(page: Int) {
        repository.getTopRatedTVShow(page: page, completion: tvShowHandler)
    }

    func getTVShowAirToday(page: Int) {
        repository.getTVShowAiringToday(page: page, completion: tvShowHandler)
    }

    func getTVShowOnTheAir(page: Int) {
        repository.getTVShowOnTheAir(page: page, completion: tvShowHandler)
    }

    func getSimilarTVShow(id: Int, page: Int) {
        repository.getSimilarTVShows(from: id, page: page, completion: tvShowHandler)
    }

    func getRecommendTVShow(id: Int, page: Int) {
        repository.getRecommendTVShows(from: id, page: page, completion: tvShowHandler)
    }

    // MARK: - people service
    func getPopularPeople(page: Int) {
        repository.getPopularPeople(page: page) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                self.showAllDelegate?.displayAll(objects: [])
            case .success(let popularPeople):
                self.showAllDelegate?.displayAll(objects: Array(popularPeople.peoples))
            }
        }
    }
    
    // MARK: - trending service
    func getTrending(page: Int, time: TrendingTime) {
        repository.getTrending(page: page, time: time, type: .all) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                self.showAllDelegate?.displayAll(objects: [])
            case .success(let trendingResult):
                self.showAllDelegate?.displayAll(objects: Array(trendingResult.trending))
            }
        }
    }
}
