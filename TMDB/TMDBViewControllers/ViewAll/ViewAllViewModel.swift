//
//  ViewAllViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 4/21/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RxSwift
import RealmSwift
import RxDataSources
import NotificationBannerSwift

protocol ViewAllViewModelProtocol {
    var repository: TMDBRepository { get }
    var items: BehaviorSubject<[SectionModel<String, Object>]> { get }
    var loadingIndicator: BehaviorSubject<Bool> { get }
    var hideEndOfResult: PublishSubject<Bool> { get }
    var errorLabel: PublishSubject<String> { get }
    var title: String? { get }
    var viewAllType: ViewAllViewModel.ViewAll? { get set }
    
    func getNextPage()
}

class ViewAllViewModel: ViewAllViewModelProtocol {
    
    enum Popular {
        case movie
        case tvshow
        case people
    }
    enum Trending {
        case today
        case thisWeek
    }
    enum Movie {
        case topRated
        case nowPlaying
        case upcoming
    }
    enum TVShow {
        case topRated
        case airToday
        case onTheAir
    }

    enum ViewAll {
        case popular(ViewAllViewModel.Popular)
        case trending(ViewAllViewModel.Trending)
        case movie(ViewAllViewModel.Movie)
        case tvshow(ViewAllViewModel.TVShow)
    }
    
    var repository: TMDBRepository
    var currentPage: Int = 0
    var totalPages: Int = 1
    var items: BehaviorSubject<[SectionModel<String, Object>]> = BehaviorSubject(value: [SectionModel(model: "view all", items: [])])
    var loadingIndicator: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var hideEndOfResult: PublishSubject<Bool> = PublishSubject()
    var errorLabel: PublishSubject<String> = PublishSubject()
    var title: String?
    var viewAllType: ViewAll? {
        didSet {
            switch viewAllType {
            case .popular(let type):
                if type == .movie {
                    self.title = NSLocalizedString("Popular", comment: "") + " " + NSLocalizedString("Movies", comment: "")
                } else if type == .tvshow {
                    self.title = NSLocalizedString("Popular", comment: "") + " " + NSLocalizedString("TV Shows", comment: "")
                } else {
                    self.title = NSLocalizedString("Popular", comment: "") + " " + NSLocalizedString("TV People", comment: "")
                }
            case .trending(let type):
                if type == .today {
                    self.title = NSLocalizedString("Trends", comment: "") + " " + NSLocalizedString("Today", comment: "")
                } else {
                    self.title = NSLocalizedString("Trends", comment: "") + " " + NSLocalizedString("This Week", comment: "")
                }
            case .movie(let type):
                if type == .topRated {
                    self.title = NSLocalizedString("Top Rated", comment: "") + " " + NSLocalizedString("Movies", comment: "")
                } else if type == .nowPlaying {
                    self.title = NSLocalizedString("Now Playing", comment: "") + " " + NSLocalizedString("Movies", comment: "")
                } else {
                    self.title = NSLocalizedString("Upcoming", comment: "") + " " + NSLocalizedString("Movies", comment: "")
                }
            case .tvshow(let type):
                if type == .topRated {
                    self.title = NSLocalizedString("Top Rated", comment: "") + " " + NSLocalizedString("TV Shows", comment: "")
                } else if type == .airToday {
                    self.title = NSLocalizedString("Air Today", comment: "") + " " + NSLocalizedString("TV Shows", comment: "")
                } else {
                    self.title = NSLocalizedString("On The Air", comment: "") + " " + NSLocalizedString("TV Shows", comment: "")
                }
            default:
                break
            }
        }
    }
    
    lazy var movieHandler: (Result<MovieResult, Error>) -> Void = { [unowned self] result in
        self.loadingIndicator.onNext(false)
        var previousMovies = try! self.items.value().first!
        switch result {
        case.success(let movieResult):
            self.currentPage += 1
            self.totalPages = movieResult.totalPages
            previousMovies.items.append(contentsOf: Array(movieResult.movies))
            self.items.onNext([previousMovies])
        case .failure(let error):
            debugPrint(error.localizedDescription)
            if previousMovies.items.isEmpty {
                self.errorLabel.onNext(error.localizedDescription)
            }
            StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                          bannerPosition: .top,
                                                                                          queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
        }
    }
    
    lazy var tvshowHandler: (Result<TVShowResult, Error>) -> Void = { [unowned self] result in
        self.loadingIndicator.onNext(false)
        var previousTVShows = try! self.items.value().first!
        switch result {
        case.success(let tvshowResult):
            self.currentPage += 1
            self.totalPages = tvshowResult.totalPages
            previousTVShows.items.append(contentsOf: Array(tvshowResult.onTV))
            self.items.onNext([previousTVShows])
        case .failure(let error):
            debugPrint(error.localizedDescription)
            if previousTVShows.items.isEmpty {
                self.errorLabel.onNext(error.localizedDescription)
            }
            StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                          bannerPosition: .top,
                                                                                          queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
        }
    }
    
    lazy var trendHandler: (Result<TrendingResult, Error>) -> Void = { [unowned self] result in
        self.loadingIndicator.onNext(false)
        var previousTrend = try! self.items.value().first!
        switch result {
        case .success(let trendingResult):
            self.currentPage += 1
            self.totalPages = trendingResult.totalPages
            previousTrend.items.append(contentsOf: Array(trendingResult.trending))
            self.items.onNext([previousTrend])
        case .failure(let error):
            debugPrint(error.localizedDescription)
            if previousTrend.items.isEmpty {
                self.errorLabel.onNext(error.localizedDescription)
            }
            StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                          bannerPosition: .top,
                                                                                          queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
        }
    }
    
    init(repository: TMDBRepository) {
        self.repository = repository
    }
    
    func getNextPage() {
        guard let type = viewAllType, totalPages >= currentPage + 1 else {
            hideEndOfResult.onNext(false)
            return
        }
        
        if try! loadingIndicator.value() {
            return
        }
 
        hideEndOfResult.onNext(true)
        loadingIndicator.onNext(true)
        errorLabel.onNext("")

        switch type {
        case .popular(let popularType):
            self.getPopular(type: popularType)
        case .trending(let trendingType):
            self.getTrending(time: trendingType)
        case .tvshow(let tvshowType):
            self.getTVShow(type: tvshowType)
        case .movie(let movieType):
            self.getMovie(type: movieType)
        }
    }
    
    private func getTrending(time: Trending) {
        if time == .today {
            repository.getTrending(page: currentPage + 1, time: .today, type: .all, completion: trendHandler)
        } else {
            repository.getTrending(page: currentPage + 1, time: .week, type: .all, completion: trendHandler)
        }
    }
    
    private func getTVShow(type: TVShow) {
        if type == .airToday {
            repository.getTVShowAiringToday(page: currentPage + 1, completion: tvshowHandler)
        } else if type == .onTheAir {
            repository.getTVShowOnTheAir(page: currentPage + 1, completion: tvshowHandler)
        } else {
            repository.getTopRatedTVShow(page: currentPage + 1, completion: tvshowHandler)
        }
    }
    
    private func getMovie(type: Movie) {
        if type == .nowPlaying {
            repository.getNowPlayingMovie(page: currentPage + 1, completion: movieHandler)
        } else if type == .topRated {
            repository.getTopRateMovie(page: currentPage + 1, completion: movieHandler)
        } else {
            repository.getUpcomingMovie(page: currentPage + 1, completion: movieHandler)
        }
    }
    
    private func getPopular(type: Popular) {
        if type == .movie {
            repository.getPopularMovie(page: currentPage + 1, completion: movieHandler)
        } else if type == .tvshow {
            repository.getPopularOnTV(page: currentPage + 1, completion: tvshowHandler)
        } else {
            repository.getPopularPeople(page: currentPage + 1) { result in
                self.loadingIndicator.onNext(false)
                var previousPeople = try! self.items.value().first!
                switch result {
                case.success(let peopleResult):
                    self.currentPage += 1
                    self.totalPages = peopleResult.totalPages
                    previousPeople.items.append(contentsOf: Array(peopleResult.peoples))
                    self.items.onNext([previousPeople])
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    if previousPeople.items.isEmpty {
                        self.errorLabel.onNext(error.localizedDescription)
                    }
                    StatusBarNotificationBanner(title: error.localizedDescription, style: .danger).show(queuePosition: .back,
                                                                                                  bannerPosition: .top,
                                                                                                  queue: NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1))
                }
            }
        }
    }
}
