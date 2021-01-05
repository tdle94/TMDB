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

    func getAllMovie(query: DiscoverQuery, nextPage: Bool)
    func getAllTVShow(query: DiscoverQuery, nextPage: Bool)
}

class DiscoveryViewModel: DiscoveryViewModelProtocol {
    var movieRepository: TMDBMovieRepository
    var tvShowRepository: TMDBTVShowRepository
    
    var movie: BehaviorSubject<[SectionModel<String, Movie>]?> = BehaviorSubject(value: [])
    var tvShow: BehaviorSubject<[SectionModel<String, TVShow>]?> = BehaviorSubject(value: [])
    
    private var movieResult: MovieResult = MovieResult()
    
    private var tvShowResult: TVShowResult = TVShowResult()

    init(movieRepository: TMDBMovieRepository, tvShowRepository: TMDBTVShowRepository) {
        self.movieRepository = movieRepository
        self.tvShowRepository = tvShowRepository
    }

    func getAllMovie(query: DiscoverQuery, nextPage: Bool) {
        var modifyQuery = query
        
        if nextPage {
            self.movieResult.page += 1
            modifyQuery.page = self.movieResult.page
        }

        self.movieRepository.getAllMovie(query: modifyQuery) { result in
            switch result {
            case .success(let movieResult):
                if nextPage {
                    self.movieResult.movies.append(objectsIn: movieResult.movies)
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

    func getAllTVShow(query: DiscoverQuery, nextPage: Bool) {
        var modifyQuery = query
        
        if nextPage {
            self.tvShowResult.page += 1
            modifyQuery.page = self.tvShowResult.page
        }
        
        self.tvShowRepository.getAllTVShow(query: modifyQuery) { result in
            switch result {
            case .success(let tvShowResult):
                
                if nextPage {
                    self.tvShowResult.onTV.append(objectsIn: tvShowResult.onTV)
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
}
