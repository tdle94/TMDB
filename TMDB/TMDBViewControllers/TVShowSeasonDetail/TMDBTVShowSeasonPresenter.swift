//
//  TMDBTVShowSeasonDisplay.swift
//  TMDB
//
//  Created by Tuyen Le on 02.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBTVShowSeasonPresenter {
    var repository: TMDBRepository = TMDBRepository.share

    private weak var tvShowSeasonDetailDelegate: TMDBTVShowSeasonDelegate?

    init(delegate: TMDBTVShowSeasonDelegate) {
        tvShowSeasonDetailDelegate = delegate
    }

    func getSeasonDetail(tvId: Int, seasonNumber: Int) {
        repository.getTVShowSeasonDetail(from: tvId, seasonNumber: seasonNumber) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.tvShowSeasonDetailDelegate?.displayError(error)
            case .success(let season):
                self.tvShowSeasonDetailDelegate?.displaySeason(season: season)
            }
        }
    }

    func getTVShowSeasonImage(tvId: Int, seasonNumber: Int) {
        repository.getTVShowSeasonImage(from: tvId, seasonNumber: seasonNumber) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let imageResult):
                self.tvShowSeasonDetailDelegate?.displayBackdropImage(backdropImages: Array(imageResult.posters))
            }
        }
    }
}
