//
//  TMDBMovieDetailViewController+TMDBPreviewSegmentControl.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

// MARK: - segment user interaction
extension TMDBMovieDetailViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(_ header: TMDBPreviewHeaderView, text selected: String) {
        if selected == NSLocalizedString("Cast", comment: "") {
            presenter.getMovieCast(movieId: movieId!)
        } else if selected == NSLocalizedString("Crew", comment: "") {
            presenter.getMovieCrew(movieId: movieId!)
        } else if selected == NSLocalizedString("Similar", comment: "") {
            presenter.getSimilarMovie(movieId: movieId!)
        } else {
            presenter.getRecommendMovie(movieId: movieId!)
        }
    }
}
