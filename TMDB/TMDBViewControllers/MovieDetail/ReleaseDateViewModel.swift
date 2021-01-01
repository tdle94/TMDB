//
//  ReleaseDateViewViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/31/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RxSwift

protocol ReleaseDateViewModelProtocol {
    var repository: TMDBMovieRepository { get }
    var releaseDates: PublishSubject<[ReleaseDateResult]> { get }
    
    func getReleaseDates(movieId: Int)
}

class ReleaseDateViewModel: ReleaseDateViewModelProtocol {
    var releaseDates: PublishSubject<[ReleaseDateResult]> = PublishSubject()
    
    var delegate: CommonNavigation?

    var repository: TMDBMovieRepository
    
    init(repository: TMDBMovieRepository) {
        self.repository = repository
    }
    
    func getReleaseDates(movieId: Int) {
        if let releaseDate = repository.getMovieReleaseDates(from: movieId) {
            releaseDates.onNext(Array(releaseDate.results))
        } else {
            releaseDates.onNext([])
        }
    }
}
