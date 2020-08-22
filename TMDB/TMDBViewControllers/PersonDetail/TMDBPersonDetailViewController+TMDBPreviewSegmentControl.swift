//
//  TMDBPersonDetailViewController+TMDBPreviewSegmentControl.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBPersonDetailViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(_ header: TMDBPreviewHeaderView, text selected: String) {
        if selected == NSLocalizedString("Movies", comment: "") {
            presenter.getMovieCredit(personId: personId!)
        } else if selected == NSLocalizedString("TV Shows", comment: "") {
            presenter.getTVShowCredit(personId: personId!)
        }
    }
}
