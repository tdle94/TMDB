//
//  TMDBTVShowEpisodeViewController+TMDBPreviewSegmentControl.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBTVShowEpisodeViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(_ header: TMDBPreviewHeaderView, text selected: String) {
        if selected == NSLocalizedString("Cast", comment: "") {
            presenter.getEpisodeCast(tvShowId: tvId!, seasonNumber: seasonNumber!, episodeNumber: episodeNumber!)
        } else if selected == NSLocalizedString("Crew", comment: "") {
            presenter.getEpisodeCrew(tvShowId: tvId!, seasonNumber: seasonNumber!, episodeNumber: episodeNumber!)
        } else if selected == NSLocalizedString("Guest Star", comment: "") {
            presenter.getEpisodeGuestStar(tvShowId: tvId!, seasonNumber: seasonNumber!, episodeNumber: episodeNumber!)
        }
    }
}
