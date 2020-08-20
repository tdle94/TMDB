//
//  TMDBTVDetailViewController+TMDBPreviewSegmentControl.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBTVDetailViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(_ header: TMDBPreviewHeaderView, text selected: String) {
        if selected == NSLocalizedString("Similar", comment: "") {
            presenter.getSimilarTVShows(tvShowId: tvId!)
        } else if selected == NSLocalizedString("Recommend", comment: "") {
            presenter.getRecommendTVShows(tvShowId: tvId!)
        } else if selected == NSLocalizedString("Cast", comment: "") {
            presenter.getTVShowCast(tvShowId: tvId!)
        } else if selected == NSLocalizedString("Crew", comment: "") {
            presenter.getTVShowCrew(tvShowId: tvId!)
        }
    }
}
