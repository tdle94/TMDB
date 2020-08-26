//
//  TMDBAllMovieViewController+TMDBAllMovieDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBAllMovieViewController: TMDBAllMovieDelegate {
    func displayAllMovie(movies: [Movie]) {
        loadingView.removeFromSuperview()
        footerLoadingView?.loadingIndicator.stopAnimating()
        var snapshot = self.allMovieDataSource.snapshot()
        snapshot.appendItems(movies)
        self.allMovieDataSource.apply(snapshot, animatingDifferences: true)
    }
}
