//
//  TMDBAllMovieViewController+TMDBMovieFilterDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 23.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBAllMovieViewController: TMDBMovieFilterDelegate {
    func filter(query: DiscoverQuery) {
        movieQuery = query
        collectionView.scrollRectToVisible(.zero, animated: false)
        var snapshot = allMovieDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .movie))
        allMovieDataSource.apply(snapshot, animatingDifferences: true)
        view.addSubview(loadingView)
        presenter.getAllMovie(query: movieQuery)
    }
}
