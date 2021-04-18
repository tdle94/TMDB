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

protocol DiscoveryViewModelProtocol: ApplyProtocol {
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
    var hideEndOfResultMovieLabel: PublishSubject<Bool> { get }
    var hideEndOfReusultTVShowLabel: PublishSubject<Bool> { get }
    
    var movieQuery: DiscoverQuery { get }
    var tvShowQuery: DiscoverQuery { get }
    
    var visibleDiscoveryViewRow: Int { get set }
    
    var movieFilterCountString: PublishSubject<String> { get }
    var tvshowFilterCountString: PublishSubject<String> { get }
    
    func getAllMovie(nextPage: Bool)
    func getAllTVShow(nextPage: Bool)
    func handleCollectionViewSwipe(at row: Int)
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
    var hideEndOfResultMovieLabel: PublishSubject<Bool> = PublishSubject()
    var hideEndOfReusultTVShowLabel: PublishSubject<Bool> = PublishSubject()
    
    var movie: BehaviorSubject<[SectionModel<String, Movie>]> = BehaviorSubject(value: [.init(model: "Movie", items: [])])
    var tvShow: BehaviorSubject<[SectionModel<String, TVShow>]> = BehaviorSubject(value: [.init(model: "TVShow", items: [])])
    
    var movieFilterCountString: PublishSubject<String> = PublishSubject()
    var tvshowFilterCountString: PublishSubject<String> = PublishSubject()
    
    var movieQuery: DiscoverQuery = DiscoverQuery(type: .movie) {
        didSet {
            if movieQuery.page == 1 {
                movieTotalPages = 1
                movie.onNext([.init(model: "Movie", items: [])])
            }
        }
    }
    var tvShowQuery: DiscoverQuery = DiscoverQuery(type: .tv) {
        didSet {
            if tvShowQuery.page == 1 {
                tvShowTotalPages = 1
                tvShow.onNext([.init(model: "TVShow", items: [])])
            }
        }
    }
    
    var visibleDiscoveryViewRow: Int = 1
    var query: DiscoverQuery? {
        return visibleDiscoveryViewRow == 1 ? movieQuery : tvShowQuery
    }
    
    var movieTotalPages: Int = 1
    var tvShowTotalPages: Int = 1

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
        hideEndOfResultMovieLabel.onNext(true)

        if query.page > movieTotalPages {
            isMovieLoading.onNext(false)
            hideEndOfResultMovieLabel.onNext(false)
            return
        }
        
        self.movieRepository.getAllMovie(query: query) { result in
            self.isMovieLoading.onNext(false)
            switch result {
            case .success(let movieResult):
                var previousMovies = try! self.movie.value().first!.items
                self.movieTotalPages = movieResult.totalPages
                
                if nextPage {
                    previousMovies.append(contentsOf: movieResult.movies)

                    self.movieQuery.page += 1
                } else {
                    previousMovies = Array(movieResult.movies)
                }
                
                if previousMovies.isEmpty {
                    self.hideMovieErrorLabel.onNext(false)
                    self.movieNotificationLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("No item found", comment: "")))
                }

                self.movie.onNext([.init(model: "Movie", items: previousMovies)])
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
        hideEndOfReusultTVShowLabel.onNext(true)

        if query.page > tvShowTotalPages {
            hideEndOfReusultTVShowLabel.onNext(false)
            isTVLoading.onNext(false)
            return
        }

        self.tvShowRepository.getAllTVShow(query: query) { result in
            self.isTVLoading.onNext(false)
            switch result {
            case .success(let tvShowResult):
                var previousMovies = try! self.tvShow.value().first!.items
                self.tvShowTotalPages = tvShowResult.totalPages
                
                if nextPage {
                    previousMovies.append(contentsOf: Array(tvShowResult.onTV))

                    self.tvShowQuery.page += 1
                } else {
                    previousMovies = Array(tvShowResult.onTV)
                }
                
                if previousMovies.isEmpty {
                    self.hideTVErrorLabel.onNext(false)
                    self.tvNotificationLabel.onNext(TMDBLabel.setHeader(title: NSLocalizedString("No item found", comment: "")))
                }

                self.tvShow.onNext([.init(model: "TVShow", items: previousMovies)])
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
    
    func handleCollectionViewSwipe(at row: Int) {
        visibleDiscoveryViewRow = row
        
        let filterCount: String
        
        if row == 1 {
            filterCount = movieQuery.numberOfFilterCount == 0 ? "" : " (\(movieQuery.numberOfFilterCount))"
            movieFilterCountString.onNext(NSLocalizedString("Filter", comment: "") + filterCount)
        } else {
            filterCount = tvShowQuery.numberOfFilterCount == 0 ? "" : "(\(tvShowQuery.numberOfFilterCount))"
            tvshowFilterCountString.onNext(NSLocalizedString("Filter", comment: "") + filterCount)
        }
    }
    
    private func applyMovieFilter(query: DiscoverQuery?) {
        guard let newQuery = query else {
            return
        }

        movieQuery = newQuery
        movieQuery.page = 1 // start at page 1 when apply new query

        let filterCount = movieQuery.numberOfFilterCount == 0 ? "" : " (\(movieQuery.numberOfFilterCount))"

        movieFilterCountString.onNext(NSLocalizedString("Filter", comment: "") + filterCount)
        getAllMovie(nextPage: false)
    }

    private func applyTVShowFilter(query: DiscoverQuery?) {
        guard let newQuery = query else {
            return
        }

        tvShowQuery = newQuery
        tvShowQuery.page = 1 // start at page 1 when apply new query
        
        let filterCount = tvShowQuery.numberOfFilterCount == 0 ? "" : "(\(tvShowQuery.numberOfFilterCount))"
        
        tvshowFilterCountString.onNext(NSLocalizedString("Filter", comment: "") + filterCount)
        getAllTVShow(nextPage: false)
    }
}
