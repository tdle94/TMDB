//
//  DiscoveryViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/4/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RxSwift
import NotificationBannerSwift

protocol DiscoveryViewModelProtocol {
    var movieRepository: TMDBMovieRepository { get }
    var tvShowRepository: TMDBTVShowRepository { get }

    func getAllMovie(query: DiscoverQuery) -> Observable<[Movie]>
    func getAllTVShow(query: DiscoverQuery) -> Observable<[TVShow]>
}

class DiscoveryViewModel: DiscoveryViewModelProtocol {
    var movieRepository: TMDBMovieRepository
    var tvShowRepository: TMDBTVShowRepository
    
    private var movieResult: MovieResult?
    
    private var tvShowResult: TVShowResult?

    init(movieRepository: TMDBMovieRepository, tvShowRepository: TMDBTVShowRepository) {
        self.movieRepository = movieRepository
        self.tvShowRepository = tvShowRepository
    }

    func getAllMovie(query: DiscoverQuery) -> Observable<[Movie]> {
        return Observable.create { observer in
            self.movieRepository.getAllMovie(query: query) { result in
                switch result {
                case .success(let movieResult):
                    self.movieResult = movieResult
                    observer.onNext(Array(movieResult.movies))
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
            
            return Disposables.create()
        }
    }

    func getAllTVShow(query: DiscoverQuery) -> Observable<[TVShow]> {
        return Observable.create { observer in
            self.tvShowRepository.getAllTVShow(query: query) { result in
                switch result {
                case .success(let tvShowResult):
                    self.tvShowResult = tvShowResult
                    observer.onNext(Array(tvShowResult.onTV))
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
            
            return Disposables.create()
        }
    }
}
