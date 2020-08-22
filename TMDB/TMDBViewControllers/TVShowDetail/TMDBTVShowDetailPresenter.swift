//
//  TMDBTVShowDetailPresenter.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

class TMDBTVShowDetailPresenter {
    var repository: TMDBRepository = TMDBRepository.share
    
    private weak var tvShowDetailDelegate: TMDBTVShowDetailDelegate?
    
    init(delegate: TMDBTVShowDetailDelegate) {
        tvShowDetailDelegate = delegate
    }

    private lazy var tvShowResultHandler: (Result<TVShowResult, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let tvShowResult):
            self.tvShowDetailDelegate?.displayTVShows(tvShows: Array(tvShowResult.onTV))
        }
    }
    
    private lazy var tvShowDetailHandler: (Result<TVShow, Error>) -> Void = { result in
        switch result {
        case .failure(let error):
            debugPrint(error)
        case .success(let tvShow):
            self.tvShowDetailDelegate?.displayTVShowDetail(tvShow: tvShow)
        }
    }

    func refreshTVShowDetail(tvShowId: Int) {
        repository.refreshTVShow(id: tvShowId, completion: tvShowDetailHandler)
    }

    func getTVShowDetail(tvShowId: Int) {
        repository.getTVShowDetail(from: tvShowId, completion: tvShowDetailHandler)
    }

    func getSimilarTVShows(tvShowId: Int) {
        repository.getSimilarTVShows(from: tvShowId, page: 1, completion: tvShowResultHandler)
    }

    func getRecommendTVShows(tvShowId: Int) {
        repository.getRecommendTVShows(from: tvShowId, page: 1, completion: tvShowResultHandler)
    }

    func getTVShowCast(tvShowId: Int) {
        let casts = repository.getTVShowCast(from: tvShowId)
        tvShowDetailDelegate?.displayCasts(casts: casts)
    }

    func getTVShowCrew(tvShowId: Int) {
        let crews = repository.getTVShowCrew(from: tvShowId)
        tvShowDetailDelegate?.displayCrews(crews: crews)
    }
    
    func getBackdropImages(tvShowId: Int) {
        repository.getTVShowImages(from: tvShowId) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let imageResult):
                self.tvShowDetailDelegate?.displayBackdropImage(images: Array(imageResult.backdrops))
            }
        }
    }
}
