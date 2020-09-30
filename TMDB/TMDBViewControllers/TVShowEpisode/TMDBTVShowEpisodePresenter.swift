//
//  TMDBTVShowEpisodeDisplay.swift
//  TMDB
//
//  Created by Tuyen Le on 8/7/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBTVShowEpisodePresenter {
    let repository: TMDBRepository = TMDBRepository.share

    private weak var tvShowEpisodeDelegate: TMDBTVShowEpisodeDelegate?

    init(delegate: TMDBTVShowEpisodeDelegate) {
        tvShowEpisodeDelegate = delegate
    }

    func getEpisodeDetail(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) {
        repository.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.tvShowEpisodeDelegate?.displayError(error)
            case .success(let episode):
                self.tvShowEpisodeDelegate?.displayEpisode(episode: episode)
            }
        }
    }

    func getEpisodeImage(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) {
        repository.getTVShowEpisodeImage(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let imageResult):
                self.tvShowEpisodeDelegate?.displayImages(images: Array(imageResult.stills))
            }
        }
    }

    func getEpisodeCast(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) {
        let casts = repository.getTVShowEpisodeCast(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
        tvShowEpisodeDelegate?.displayCasts(casts: casts)
    }

    func getEpisodeCrew(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) {
        let crews = repository.getTVShowEpisodeCrew(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
        tvShowEpisodeDelegate?.displayCrews(crews: crews)
    }

    func getEpisodeGuestStar(tvShowId: Int, seasonNumber: Int, episodeNumber: Int) {
        let guestStars = repository.getTVShowEpisodeGuestStar(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
        tvShowEpisodeDelegate?.displayCasts(casts: guestStars)
    }
}
