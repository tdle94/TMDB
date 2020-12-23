//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 11/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift
import RealmSwift

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
            let items = Array(movieResult.movies).map { CustomElementType(identity: $0) }
            let firstTwo = Array((try! self.collectionViewSection.value().dropLast(2)))
            let last = try! self.collectionViewSection.value().last!

            self.collectionViewSection
                .onNext(firstTwo + [.Movie(items: items), last])
        case .failure(let error):
            self.collectionViewSection.onError(error)
        }
    }
    
    lazy var tvShowHandler: (Result<TVShowResult, Error>) -> Void = { result in
        switch result {
        case .success(let tvShowResult):
            let items = Array(tvShowResult.onTV).map { CustomElementType(identity: $0) }
            let firstThree = Array(try! self.collectionViewSection.value().dropLast())
            
            self.collectionViewSection
                .onNext(firstThree + [.TVShow(items: items)])
        case .failure(let error):
            self.collectionViewSection.onError(error)
        }
    }
    
    lazy var trendingHandler: (Result<TrendingResult, Error>) -> Void = { result in
        switch result {
        case .success(let trendResult):
            let items = Array(trendResult.trending).map { CustomElementType(identity: $0) }
            let first = try! self.collectionViewSection.value().first!
            let lastTwo = Array(try! self.collectionViewSection.value().dropFirst(2))
            
            self.collectionViewSection.onNext([first, .Trending(items: items)] + lastTwo)
        case .failure(let error):
            self.collectionViewSection.onError(error)
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
                let items = Array(movieResult.movies).map { CustomElementType(identity: $0) }
                let lastThree = Array(try! self.collectionViewSection.value().dropFirst())
                
                self.collectionViewSection.onNext([.Popular(items: items)] + lastThree)
            case .failure(let error):
                self.collectionViewSection.onError(error)
            }
        }
    }
    
    func getPopularTVShow() {
        tvShowRepository.getPopularOnTV(page: 1) { result in
            switch result {
            case .success(let tvShowResult):
                let items = Array(tvShowResult.onTV).map { CustomElementType(identity: $0) }
                let lastThree = Array(try! self.collectionViewSection.value().dropFirst())
                self.collectionViewSection.onNext([.Popular(items: items)] + lastThree)
            case .failure(let error):
                self.collectionViewSection.onError(error)
            }
        }
    }
    
    func getPopularPeople() {
        peopleRepository.getPopularPeople(page: 1) { result in
            switch result {
            case .success(let peopleResult):
                let items = Array(peopleResult.peoples).map { CustomElementType(identity: $0) }
                let lastThree = Array(try! self.collectionViewSection.value().dropFirst())
                
                self.collectionViewSection.onNext([.Popular(items: items)] + lastThree)
            case .failure(let error):
                self.collectionViewSection.onError(error)
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
}
