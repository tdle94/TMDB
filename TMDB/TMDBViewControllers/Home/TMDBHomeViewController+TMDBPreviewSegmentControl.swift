//
//  TMDBHomeViewController+TMDBPreviewSegmentControl.swift
//  TMDB
//
//  Created by Tuyen Le on 8/17/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

// MARK: - segment control user interaction
extension TMDBHomeViewController: TMDBPreviewSegmentControl {
    func segmentControlSelected(_ header: TMDBPreviewHeaderView, text selected: String) {
        if selected == NSLocalizedString("Today", comment: "") {
            presenter.getTrend(time: .today)
        } else if selected == NSLocalizedString("This Week", comment: "")  {
            presenter.getTrend(time: .week)
        } else if selected == NSLocalizedString("Movies", comment: "") {
            presenter.getPopularMovie(page: 1)
        } else if selected == NSLocalizedString("People", comment: "") {
            presenter.getPopularPeople(page: 1)
        } else if selected == NSLocalizedString("TV Shows", comment: "") {
            presenter.getPopularTVShow(page: 1)
        } else if selected == NSLocalizedString("Top Rated", comment: "") {
            if header is TMDBMovieHeaderView {
                presenter.getTopRatedMovie(page: 1)
            } else {
                presenter.getTopRatedTVShow(page: 1)
            }
        } else if selected == NSLocalizedString("Upcoming", comment: "") {
            presenter.getUpcomingMovie(page: 1)
        } else if selected == NSLocalizedString("Now Playing", comment: "") {
            presenter.getNowPlayingMovie(page: 1)
        } else if selected == NSLocalizedString("Air Today", comment: "") {
            presenter.getTVShowAirToday(page: 1)
        } else if selected == NSLocalizedString("On The Air", comment: "") {
            presenter.getTVShowOnTheAir(page: 1)
        }
    }
}
