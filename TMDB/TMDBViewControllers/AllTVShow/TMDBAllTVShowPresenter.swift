//
//  TMDBAllTVShowPresenter.swift
//  TMDB
//
//  Created by Tuyen Le on 8/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

class TMDBAllTVShowPresenter {
    let repository: TMDBRepository = TMDBRepository.share
    
    private(set) var totalTVShows: Int = 0
    
    private weak var allTVShowDelegate: TMDBAllTVShowDelegate?

    init(delegate: TMDBAllTVShowDelegate) {
        allTVShowDelegate = delegate
    }

    func getAllTVShow(tvShowQuery: DiscoverQuery) {
        repository.getAllTVShow(query: tvShowQuery) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let tvShowResult):
                self.totalTVShows = tvShowResult.totalResults
                self.allTVShowDelegate?.displayAllTVShow(tvShows: Array(tvShowResult.onTV))
            }
        }
    }
}
