//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 11/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift
import RealmSwift
import NotificationBannerSwift
import RxDataSources

protocol HomeViewModelProtocol {
    
    var movieCollectionView: BehaviorSubject<[SectionModel<String, Object>]> { get }
    var popularCollectionView: BehaviorSubject<[SectionModel<String, Object>]> { get }
    var trendingCollectionView: BehaviorSubject<[SectionModel<String, Object>]> { get }
    var tvshowCollectionView: BehaviorSubject<[SectionModel<String, Object>]> { get }
    
    var popularLoadIndicator: PublishSubject<Bool> { get }
    var trendingLoadIndicator: PublishSubject<Bool> { get }
    var movieLoadIndicator: PublishSubject<Bool> { get }
    var tvshowLoadIndicator: PublishSubject<Bool> { get }
    
    var popularErrorMessage: PublishSubject<String> { get }
    var trendingErrorMessage: PublishSubject<String> { get }
    var movieErrorMessage: PublishSubject<String> { get }
    var tvshowErrorMessage: PublishSubject<String> { get }
    
    var movieRepository: TMDBMovieRepository { get }
    var tvShowRepository: TMDBTVShowRepository { get }
    var trendingRepository: TMDBTrendingRepository { get }
    var peopleRepository: TMDBPeopleRepository { get }

    func getPopularMovie()
    func getPopularTVShow()
    func getPopularPeople()
    func getTrendingToday()
    func getTrendingThisWeek()
    func getTopRatedMovie()
    func getNowPlayingMovie()
    func getUpcomingMovie()
    func getTopRatedTVShow()
    func getTVShowAiringToday()
    func getTVShowOnTheAir()
    
    func handlePopularSelection(at: Int)
    func handleTrendingSelection(at: Int)
    func handleMovieCategorySelection(at: Int)
    func handleTVShowCategorySelection(at: Int)
}

class HomeViewModel: HomeViewModelProtocol {
    
    var movieCollectionView: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    var popularCollectionView: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    var trendingCollectionView: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    var tvshowCollectionView: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [])
    
    var popularLoadIndicator: PublishSubject<Bool> = PublishSubject()
    var trendingLoadIndicator: PublishSubject<Bool> = PublishSubject()
    var movieLoadIndicator: PublishSubject<Bool> = PublishSubject()
    var tvshowLoadIndicator: PublishSubject<Bool> = PublishSubject()
    
    var popularErrorMessage: PublishSubject<String> = PublishSubject()
    var trendingErrorMessage: PublishSubject<String> = PublishSubject()
    var movieErrorMessage: PublishSubject<String> = PublishSubject()
    var tvshowErrorMessage: PublishSubject<String> = PublishSubject()

    var movieRepository: TMDBMovieRepository
    var tvShowRepository: TMDBTVShowRepository
    var trendingRepository: TMDBTrendingRepository
    var peopleRepository: TMDBPeopleRepository
    
    lazy var movieHandler: (Result<MovieResult, Error>) -> Void = { [unowned self] result in
        self.movieLoadIndicator.onNext(false)
        
        switch result {
        case .success(let movieResult):
            self.movieCollectionView.onNext([SectionModel(model: "movie", items: [Movie()] + Array(movieResult.movies))])
        case .failure(let error):
            debugPrint("Error getting movie: \(error.localizedDescription)")
            StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                          bannerPosition: .top,
                                                                                          queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            self.movieCollectionView.onNext([SectionModel(model: "movie", items: [])])
            self.movieErrorMessage.onNext(error.localizedDescription)
        }
    }
    
    lazy var tvShowHandler: (Result<TVShowResult, Error>) -> Void = { [unowned self] result in
        self.tvshowLoadIndicator.onNext(false)
        
        switch result {
        case .success(let tvShowResult):
            self.tvshowCollectionView.onNext([SectionModel(model: "tv show", items: [TVShow()] + Array(tvShowResult.onTV))])
        case .failure(let error):
            debugPrint("Error getting tvshow: \(error.localizedDescription)")
            StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                           bannerPosition: .top,
                                                                                           queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            self.tvshowCollectionView.onNext([SectionModel(model: "tv show", items: [])])
            self.tvshowErrorMessage.onNext(error.localizedDescription)
        }
    }
    
    lazy var trendingHandler: (Result<TrendingResult, Error>) -> Void = { [unowned self] result in
        self.trendingLoadIndicator.onNext(false)
        
        switch result {
        case .success(let trendResult):
            self.trendingCollectionView.onNext([SectionModel(model: "trending", items: [Trending()] + Array(trendResult.trending))])
        case .failure(let error):
            debugPrint("Error getting trending: \(error.localizedDescription)")
            StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                          bannerPosition: .top,
                                                                                          queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            self.trendingCollectionView.onNext([SectionModel(model: "trending", items: [])])
            self.trendingErrorMessage.onNext(error.localizedDescription)
        }
    }
    
    init(movieRepository: TMDBMovieRepository,
         tvShowRepository: TMDBTVShowRepository,
         trendingRepository: TMDBTrendingRepository,
         peopleRepository: TMDBPeopleRepository) {
        
        self.movieRepository = movieRepository
        self.tvShowRepository = tvShowRepository
        self.trendingRepository = trendingRepository
        self.peopleRepository = peopleRepository
    }
    
    func getPopularMovie() {
        popularLoadIndicator.onNext(true)
        popularErrorMessage.onNext("")
        
        movieRepository.getPopularMovie(page: 1) { result in
            self.popularLoadIndicator.onNext(false)
            
            switch result {
            case .success(let movieResult):
                self.popularCollectionView.onNext([SectionModel(model: "movie", items: [Movie()] + Array(movieResult.movies))])
            case .failure(let error):
                debugPrint("Error getting populuar movie: \(error.localizedDescription)")
                StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                                      bannerPosition: .top,
                                                                                                      queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
                self.popularCollectionView.onNext([SectionModel(model: "movie", items: [])])
                self.popularErrorMessage.onNext(error.localizedDescription)
            }
        }
    }
    
    func getPopularTVShow() {
        popularLoadIndicator.onNext(true)
        popularErrorMessage.onNext("")
        
        tvShowRepository.getPopularOnTV(page: 1) { result in
            self.popularLoadIndicator.onNext(false)
            
            switch result {
            case .success(let tvShowResult):
                self.popularCollectionView.onNext([SectionModel(model: "tv show", items: [TVShow()] + Array(tvShowResult.onTV))])
            case .failure(let error):
                debugPrint("Error getting populuar tvshow: \(error.localizedDescription)")
                StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                                        bannerPosition: .top,
                                                                                                        queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
                self.popularCollectionView.onNext([SectionModel(model: "tv show", items: [])])
                self.popularErrorMessage.onNext(error.localizedDescription)
            }
        }
    }
    
    func getPopularPeople() {
        popularLoadIndicator.onNext(true)
        popularErrorMessage.onNext("")
        
        peopleRepository.getPopularPeople(page: 1) { result in
            self.popularLoadIndicator.onNext(false)
            
            switch result {
            case .success(let peopleResult):
                self.popularCollectionView.onNext([SectionModel(model: "people", items: [People()] + Array(peopleResult.peoples))])
            case .failure(let error):
                debugPrint("Error getting populuar people: \(error.localizedDescription)")
                StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                                       bannerPosition: .top,
                                                                                                       queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
                self.popularCollectionView.onNext([SectionModel(model: "people", items: [])])
                self.popularErrorMessage.onNext(error.localizedDescription)
            }
        }
    }

    func getTrendingToday() {
        trendingLoadIndicator.onNext(true)
        trendingErrorMessage.onNext("")
        trendingRepository.getTrending(page: 1, time: .today, type: .all, completion: trendingHandler)
    }
    
    func getTrendingThisWeek() {
        trendingLoadIndicator.onNext(true)
        trendingErrorMessage.onNext("")
        trendingRepository.getTrending(page: 1, time: .week, type: .all, completion: trendingHandler)
    }
    
    func getTopRatedMovie() {
        movieLoadIndicator.onNext(true)
        movieErrorMessage.onNext("")
        movieRepository.getTopRateMovie(page: 1, completion: movieHandler)
    }
    
    
    func getNowPlayingMovie() {
        movieLoadIndicator.onNext(true)
        movieErrorMessage.onNext("")
        movieRepository.getNowPlayingMovie(page: 1, completion: movieHandler)
    }
    
    func getUpcomingMovie() {
        movieLoadIndicator.onNext(true)
        movieErrorMessage.onNext("")
        movieRepository.getUpcomingMovie(page: 1, completion: movieHandler)
    }
    
    func getTopRatedTVShow() {
        tvshowLoadIndicator.onNext(true)
        tvshowErrorMessage.onNext("")
        tvShowRepository.getTopRatedTVShow(page: 1, completion: tvShowHandler)
    }
    
    func getTVShowAiringToday() {
        tvshowLoadIndicator.onNext(true)
        tvshowErrorMessage.onNext("")
        tvShowRepository.getTVShowAiringToday(page: 1, completion: tvShowHandler)
    }
    
    func getTVShowOnTheAir() {
        tvshowLoadIndicator.onNext(true)
        tvshowErrorMessage.onNext("")
        tvShowRepository.getTVShowOnTheAir(page: 1, completion: tvShowHandler)
    }
    
    func handlePopularSelection(at: Int) {
        if at == 0 {
            getPopularMovie()
        } else if at == 1 {
            getPopularTVShow()
        } else {
            getPopularPeople()
        }
    }
    
    func handleTrendingSelection(at: Int) {
        if at == 0 {
            getTrendingToday()
        } else {
            getTrendingThisWeek()
        }
    }
    
    func handleMovieCategorySelection(at: Int) {
        if at == 0 {
            getTopRatedMovie()
        } else if at == 1 {
            getNowPlayingMovie()
        } else {
            getUpcomingMovie()
        }
    }
    
    func handleTVShowCategorySelection(at: Int) {
        if at == 0 {
            getTopRatedTVShow()
        } else if at == 1 {
            getTVShowAiringToday()
        } else {
            getTVShowOnTheAir()
        }
    }
}
