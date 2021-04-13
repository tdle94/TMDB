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

protocol HomeViewModelProtocol {
    
    var collectionViewSection: BehaviorSubject<[HomeModel]> { get }
    
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
    
    func handleSegmentSelection(section: Int, segment: Int)
}

class F: NSObject, URLSessionDelegate {
    var session: URLSession?
    
    override init() {
        super.init()
        session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
    }
}

class HomeViewModel: HomeViewModelProtocol {

    var collectionViewSection: BehaviorSubject<[HomeModel]> = BehaviorSubject(value: [
        .Popular(items: []),
        .Trending(items: []),
        .Movie(items: []),
        .TVShow(items: [])
    ])

    var movieRepository: TMDBMovieRepository
    var tvShowRepository: TMDBTVShowRepository
    var trendingRepository: TMDBTrendingRepository
    var peopleRepository: TMDBPeopleRepository
    
    lazy var movieHandler: (Result<MovieResult, Error>) -> Void = { result in
        switch result {
        case .success(let movieResult):
            let items = [CustomElementType(identity: .init())] + Array(movieResult.movies).map { CustomElementType(identity: $0) }
            let firstTwo = Array((try! self.collectionViewSection.value().dropLast(2)))
            let last = try! self.collectionViewSection.value().last!

            self.collectionViewSection
                .onNext(firstTwo + [.Movie(items: items), last])
        case .failure(let error):
            debugPrint("Error getting movie: \(error.localizedDescription)")
            StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                          bannerPosition: .top,
                                                                                          queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            self.collectionViewSection.onNext(try! self.collectionViewSection.value())
        }
    }
    
    lazy var tvShowHandler: (Result<TVShowResult, Error>) -> Void = { result in
        switch result {
        case .success(let tvShowResult):
            let items = [CustomElementType(identity: .init())] + Array(tvShowResult.onTV).map { CustomElementType(identity: $0) }
            let firstThree = Array(try! self.collectionViewSection.value().dropLast())
            
            self.collectionViewSection
                .onNext(firstThree + [.TVShow(items: items)])
        case .failure(let error):
            debugPrint("Error getting tvshow: \(error.localizedDescription)")
            StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                           bannerPosition: .top,
                                                                                           queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            self.collectionViewSection.onNext(try! self.collectionViewSection.value())
        }
    }
    
    lazy var trendingHandler: (Result<TrendingResult, Error>) -> Void = { result in
        switch result {
        case .success(let trendResult):
            let items = [CustomElementType(identity: .init())] + Array(trendResult.trending).map { CustomElementType(identity: $0) }
            let first = try! self.collectionViewSection.value().first!
            let lastTwo = Array(try! self.collectionViewSection.value().dropFirst(2))
            
            self.collectionViewSection.onNext([first, .Trending(items: items)] + lastTwo)
        case .failure(let error):
            debugPrint("Error getting trending: \(error.localizedDescription)")
            StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                          bannerPosition: .top,
                                                                                          queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
            self.collectionViewSection.onNext(try! self.collectionViewSection.value())
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
        movieRepository.getPopularMovie(page: 1) { result in
            switch result {
            case .success(let movieResult):
                let items = [CustomElementType(identity: .init())] + Array(movieResult.movies).map { CustomElementType(identity: $0) }
                let lastThree = Array(try! self.collectionViewSection.value().dropFirst())
                
                self.collectionViewSection.onNext([.Popular(items: items)] + lastThree)
            case .failure(let error):
                debugPrint("Error getting populuar movie: \(error.localizedDescription)")
                StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                                      bannerPosition: .top,
                                                                                                      queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
                self.collectionViewSection.onNext(try! self.collectionViewSection.value())
            }
        }
    }
    
    func getPopularTVShow() {
        tvShowRepository.getPopularOnTV(page: 1) { result in
            switch result {
            case .success(let tvShowResult):
                let items = [CustomElementType(identity: .init())] + Array(tvShowResult.onTV).map { CustomElementType(identity: $0) }
                let lastThree = Array(try! self.collectionViewSection.value().dropFirst())
                self.collectionViewSection.onNext([.Popular(items: items)] + lastThree)
            case .failure(let error):
                debugPrint("Error getting populuar tvshow: \(error.localizedDescription)")
                StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                                        bannerPosition: .top,
                                                                                                        queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
                self.collectionViewSection.onNext(try! self.collectionViewSection.value())
            }
        }
    }
    
    func getPopularPeople() {
        peopleRepository.getPopularPeople(page: 1) { result in
            switch result {
            case .success(let peopleResult):
                let items = [CustomElementType(identity: .init())] + Array(peopleResult.peoples).map { CustomElementType(identity: $0) }
                let lastThree = Array(try! self.collectionViewSection.value().dropFirst())
                
                self.collectionViewSection.onNext([.Popular(items: items)] + lastThree)
            case .failure(let error):
                debugPrint("Error getting populuar people: \(error.localizedDescription)")
                StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                                       bannerPosition: .top,
                                                                                                       queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
                self.collectionViewSection.onNext(try! self.collectionViewSection.value())
            }
        }
    }

    func getTrendingToday() {
        trendingRepository.getTrending(page: 1, time: .today, type: .all, completion: trendingHandler)
    }
    
    func getTrendingThisWeek() {
        trendingRepository.getTrending(page: 1, time: .week, type: .all, completion: trendingHandler)
    }
    
    func getTopRatedMovie() {
        movieRepository.getTopRateMovie(page: 1, completion: movieHandler)
    }
    
    
    func getNowPlayingMovie() {
        movieRepository.getNowPlayingMovie(page: 1, completion: movieHandler)
    }
    
    func getUpcomingMovie() {
        movieRepository.getUpcomingMovie(page: 1, completion: movieHandler)
    }
    
    func getTopRatedTVShow() {
        tvShowRepository.getTopRatedTVShow(page: 1, completion: tvShowHandler)
    }
    
    func getTVShowAiringToday() {
        tvShowRepository.getTVShowAiringToday(page: 1, completion: tvShowHandler)
    }
    
    func getTVShowOnTheAir() {
        tvShowRepository.getTVShowOnTheAir(page: 1, completion: tvShowHandler)
    }
    
    func handleSegmentSelection(section: Int, segment: Int) {
        if section == 0, segment == 0 {
            getPopularMovie()
        } else if section == 0, segment == 1 {
            getPopularTVShow()
        } else if section == 0, segment == 2 {
            getPopularPeople()
        } else if section == 1, segment == 0 {
            getTrendingToday()
        } else if section == 1, segment == 1 {
            getTrendingThisWeek()
        } else if section == 2, segment == 0 {
            getTopRatedMovie()
        } else if section == 2, segment == 1 {
            getNowPlayingMovie()
        } else if section == 2, segment == 2 {
            getUpcomingMovie()
        } else if section == 3, segment == 0 {
            getTopRatedTVShow()
        } else if section == 3, segment == 1 {
            getTVShowAiringToday()
        } else {
            getTVShowOnTheAir()
        }
    }
}
