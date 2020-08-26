//
//  TMDBAllTVShowViewController+TMDBFilterDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBAllTVShowViewController: TMDBFilterDelegate {
    func filter(query: DiscoverQuery) {
        tvQuery = query
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom, animated: false)
        var snapshot = allTVShowDataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .tvShow))
        allTVShowDataSource.apply(snapshot, animatingDifferences: true)
        view.addSubview(loadingView)
        presenter.getAllTVShow(tvShowQuery: tvQuery)
    }
}
