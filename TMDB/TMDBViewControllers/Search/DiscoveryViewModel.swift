//
//  DiscoveryViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/4/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RxSwift
import NotificationBannerSwift
import RxDataSources

protocol DiscoveryViewModelProtocol {
    var movieRepository: TMDBMovieRepository { get }
    var tvShowRepository: TMDBTVShowRepository { get }
    
    var movie: BehaviorSubject<[SectionModel<String, Movie>]?> { get }
    var tvShow: BehaviorSubject<[SectionModel<String, TVShow>]?> { get }
    
    var movieQuery: DiscoverQuery { get }
    var tvShowQuery: DiscoverQuery { get }

    func getAllMovie(nextPage: Bool)
    func getAllTVShow(nextPage: Bool)
    
    func applyMovieFilter(query: DiscoverQuery)
    func applyTVShowFilter(query: DiscoverQuery)
}

protocol ApplyFilterDelegate: class {
    var visibleRow: Int? { get }
    var query: DiscoverQuery { get }

    func applyFilter(query: DiscoverQuery)
}

class DiscoveryViewModel: DiscoveryViewModelProtocol {
    var movieRepository: TMDBMovieRepository
    var tvShowRepository: TMDBTVShowRepository
    
    var movie: BehaviorSubject<[SectionModel<String, Movie>]?> = BehaviorSubject(value: [])
    var tvShow: BehaviorSubject<[SectionModel<String, TVShow>]?> = BehaviorSubject(value: [])
    
    var movieQuery: DiscoverQuery = DiscoverQuery()
    var tvShowQuery: DiscoverQuery = DiscoverQuery()

    private var movieResult: MovieResult = MovieResult()
    
    private var tvShowResult: TVShowResult = TVShowResult()

    init(movieRepository: TMDBMovieRepository, tvShowRepository: TMDBTVShowRepository) {
        self.movieRepository = movieRepository
        self.tvShowRepository = tvShowRepository
    }

    func getAllMovie(nextPage: Bool) {
        
        var query = movieQuery
        
        if nextPage {
            query.page += 1
        }

        self.movieRepository.getAllMovie(query: query) { result in
            switch result {
            case .success(let movieResult):
                if nextPage {
                    self.movieResult.movies.append(objectsIn: movieResult.movies)
                    self.movieResult.page += 1
                    self.movieQuery.page += 1
                } else {
                    self.movieResult = movieResult
                }
                
                self.movie.onNext([.init(model: "Movie", items: Array(self.movieResult.movies))])
            case .failure(let error):
                debugPrint("Error getting discovery movies: ", error.localizedDescription)
                self.movie.onNext(nil)
                StatusBarNotificationBanner(title: "Fail getting movies", style: .danger).show(queuePosition: .back,
                                                                                                              bannerPosition: .top,
                                                                                                              queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
    }

    func getAllTVShow(nextPage: Bool) {
        
        var query = tvShowQuery
        
        if nextPage {
            query.page += 1
        }
        
        self.tvShowRepository.getAllTVShow(query: query) { result in
            switch result {
            case .success(let tvShowResult):
                
                if nextPage {
                    self.tvShowResult.onTV.append(objectsIn: tvShowResult.onTV)
                    self.tvShowResult.page += 1
                    self.tvShowQuery.page += 1
                } else {
                    self.tvShowResult = tvShowResult
                }

                self.tvShow.onNext([.init(model: "TVShow", items: Array(self.tvShowResult.onTV))])
            case .failure(let error):
                debugPrint("Error getting discovery tvshow: ", error.localizedDescription)
                self.movie.onNext(nil)
                StatusBarNotificationBanner(title: "Fail getting tv show", style: .danger).show(queuePosition: .back,
                                                                                                              bannerPosition: .top,
                                                                                                              queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
    }
    
    func applyMovieFilter(query: DiscoverQuery) {
        movieQuery = query
        movie.onNext([])

        getAllMovie(nextPage: false)
    }

    func applyTVShowFilter(query: DiscoverQuery) {
        tvShowQuery = query
        tvShow.onNext([])
        
        getAllTVShow(nextPage: false)
    }
}
