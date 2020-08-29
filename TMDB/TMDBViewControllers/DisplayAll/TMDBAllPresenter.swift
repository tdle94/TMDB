//
//  TMDBAllPresenter.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

class TMDBAllPresenter {
    let repository: TMDBRepository = TMDBRepository.share
    
    private(set) var total: Int = 0

    weak var showAllDelegate: TMDBShowAllDelegate?

    init(delegate: TMDBShowAllDelegate) {
        showAllDelegate = delegate
    }

    func getAllTVShow(tvShowQuery: DiscoverQuery) {
        repository.getAllTVShow(query: tvShowQuery) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let tvShowResult):
                self.total = tvShowResult.totalResults
                self.showAllDelegate?.displayAll(objects: Array(tvShowResult.onTV))
            }
        }
    }

    func getAllMovie(query: DiscoverQuery) {
        repository.getAllMovie(query: query) { result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let allMovieResult):
                self.total = allMovieResult.totalResults
                self.showAllDelegate?.displayAll(objects: Array(allMovieResult.movies))
            }
        }
    }
}
