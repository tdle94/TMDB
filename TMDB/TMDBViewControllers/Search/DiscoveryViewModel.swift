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

protocol ApplyProtocol: class {
    var query: DiscoverQuery? { get }

    func apply(query: DiscoverQuery?)
}

protocol DiscoveryViewModelProtocol {
    var movieRepository: TMDBMovieRepository { get }
    var tvShowRepository: TMDBTVShowRepository { get }
    
    var movie: BehaviorSubject<[SectionModel<String, Movie>]> { get }
    var tvShow: BehaviorSubject<[SectionModel<String, TVShow>]> { get }
    
    var isMovieLoading: BehaviorSubject<Bool> { get }
    var isTVLoading: BehaviorSubject<Bool> { get }
    
    var hideMovieErrorLabel: PublishSubject<Bool> { get }
    var movieNotificationLabel: PublishSubject<NSAttributedString> { get }
    
    var hideTVErrorLabel: PublishSubject<Bool> { get }
    var tvNotificationLabel: PublishSubject<NSAttributedString> { get }
    
    var movieQuery: DiscoverQuery { get }
    var tvShowQuery: DiscoverQuery { get }

    func getAllMovie(nextPage: Bool)
    func getAllTVShow(nextPage: Bool)
    func apply(query: DiscoverQuery?)
}

class DiscoveryViewModel: DiscoveryViewModelProtocol {
    var movieRepository: TMDBMovieRepository
    var tvShowRepository: TMDBTVShowRepository
    
    var isMovieLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var isTVLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    var hideMovieErrorLabel: PublishSubject<Bool> = PublishSubject()
    var movieNotificationLabel: PublishSubject<NSAttributedString> = PublishSubject()

    var hideTVErrorLabel: PublishSubject<Bool> = PublishSubject()
    var tvNotificationLabel: PublishSubject<NSAttributedString> = PublishSubject()
    
    var movie: BehaviorSubject<[SectionModel<String, Movie>]> = BehaviorSubject(value: [.init(model: "Movie", items: [])])
    var tvShow: BehaviorSubject<[SectionModel<String, TVShow>]> = BehaviorSubject(value: [.init(model: "TVShow", items: [])])
    
    var movieQuery: DiscoverQuery = DiscoverQuery(type: .movie)
    var tvShowQuery: DiscoverQuery = DiscoverQuery(type: .tv)

    private var movieResult: MovieResult = MovieResult()
    
    private var tvShowResult: TVShowResult = TVShowResult()

    init(movieRepository: TMDBMovieRepository, tvShowRepository: TMDBTVShowRepository) {
        self.movieRepository = movieRepository
        self.tvShowRepository = tvShowRepository
    }

    func getAllMovie(nextPage: Bool) {
        if try! isMovieLoading.value()  {
            return
        }
        
        var query = movieQuery
        
        if nextPage {
            query.page += 1
        }
        
        isMovieLoading.onNext(true)
        hideMovieErrorLabel.onNext(true)

        if query.page > movieResult.totalPages, movieResult.totalPages != 0 {
            isMovieLoading.onNext(false)
            return
        }
        
        self.movieRepository.getAllMovie(query: query) { result in
            self.isMovieLoading.onNext(false)
            switch result {
            case .success(let movieResult):
                if nextPage {
                    self.movieResult.movies.append(objectsIn: movieResult.movies)
                    self.movieResult.page += 1
                    self.movieQuery.page += 1
                } else {
                    self.movieResult = movieResult
                }
                
                if self.movieResult.movies.isEmpty {
                    self.hideMovieErrorLabel.onNext(false)
                    self.movieNotificationLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("No item found", comment: "")))
                }

                self.movie.onNext([.init(model: "Movie", items: Array(self.movieResult.movies))])
            case .failure(let error):
                let previousResult = try! self.movie.value()

                self.hideMovieErrorLabel.onNext(previousResult.first?.items.isNotEmpty ?? previousResult.isNotEmpty)
 
                if previousResult.first?.items.isEmpty ?? previousResult.isEmpty {
                    self.movieNotificationLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("Error getting search result", comment: "")))
                }

                debugPrint("Error getting discovery movies: ", error.localizedDescription)
                StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                                              bannerPosition: .top,
                                                                                                              queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
    }

    func getAllTVShow(nextPage: Bool) {
        if try! isTVLoading.value()  {
            return
        }

        var query = tvShowQuery
        
        if nextPage {
            query.page += 1
        }
        
        isTVLoading.onNext(true)
        hideTVErrorLabel.onNext(true)

        if query.page > tvShowResult.totalPages, tvShowResult.totalPages != 0 {
            isTVLoading.onNext(false)
            return
        }

        self.tvShowRepository.getAllTVShow(query: query) { result in
            self.isTVLoading.onNext(false)
            switch result {
            case .success(let tvShowResult):
                
                if nextPage {
                    self.tvShowResult.onTV.append(objectsIn: tvShowResult.onTV)
                    self.tvShowResult.page += 1
                    self.tvShowQuery.page += 1
                } else {
                    self.tvShowResult = tvShowResult
                }
                
                if self.tvShowResult.onTV.isEmpty {
                    self.hideTVErrorLabel.onNext(false)
                    self.tvNotificationLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("No item found", comment: "")))
                }

                self.tvShow.onNext([.init(model: "TVShow", items: Array(self.tvShowResult.onTV))])
            case .failure(let error):
                let previousResult = try! self.tvShow.value()

                self.hideTVErrorLabel.onNext(previousResult.first?.items.isNotEmpty ?? previousResult.isNotEmpty)

                if previousResult.first?.items.isEmpty ?? previousResult.isEmpty {
                    self.tvNotificationLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("Error getting search result", comment: "")))
                }

                debugPrint("Error getting discovery tvshow: ", error.localizedDescription)
                StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                                              bannerPosition: .top,
                                                                                                              queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            }
        }
    }
    
    func apply(query: DiscoverQuery?) {
        if query?.filterType == .movie {
            applyMovieFilter(query: query)
        } else {
            applyTVShowFilter(query: query)
        }
    }
    
    func applyMovieFilter(query: DiscoverQuery?) {
        guard let newQuery = query else {
            return
        }

        movieQuery = newQuery
        movieQuery.page = 1 // start at page 1 when apply new query
        movie.onNext([])

        getAllMovie(nextPage: false)
    }

    func applyTVShowFilter(query: DiscoverQuery?) {
        guard let newQuery = query else {
            return
        }

        tvShowQuery = newQuery
        tvShowQuery.page = 1 // start at page 1 when apply new query
        tvShow.onNext([])
        
        getAllTVShow(nextPage: false)
    }
}
