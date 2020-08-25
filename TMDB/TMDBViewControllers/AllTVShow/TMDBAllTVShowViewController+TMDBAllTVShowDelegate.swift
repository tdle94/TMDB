//
//  TMDBAllTVShowViewController+TMDBAllTVShowDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBAllTVShowViewController: TMDBAllTVShowDelegate {
    func displayAllTVShow(tvShows: [TVShow]) {
        loadingView.removeFromSuperview()
        footerLoadingView?.loadingIndicator.stopAnimating()
        var snapshot = allTVShowDataSource.snapshot()
        snapshot.appendItems(tvShows)
        allTVShowDataSource.apply(snapshot, animatingDifferences: true)
    }
}
