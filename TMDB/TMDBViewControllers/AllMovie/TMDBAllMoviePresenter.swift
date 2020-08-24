//
//  TMDBAllMoviePresenter.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

class TMDBAllMoviePresenter {
    let repository: TMDBRepository = TMDBRepository.share
    
    private(set) var totalMovie: Int = 0

    private weak var allMovieDelegate: TMDBAllMovieDelegate?
    
    init(delegate: TMDBAllMovieDelegate) {
        allMovieDelegate = delegate
    }
    
    func getAllMovie(query: DiscoverQuery) {
        repository.getAllMovie(query: query) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let allMovieResult):
                self.totalMovie = allMovieResult.totalResults
                self.allMovieDelegate?.displayAllMovie(movies: Array(allMovieResult.movies))
            }
        }
    }
}
