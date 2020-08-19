//
//  TMDBHomeViewController+TMDBHomeViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/17/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

extension TMDBHomeViewController: TMDBHomeViewDelegate {
    func displayMovies(_ movies: [Movie], type: TMDBHomePresenter.Popular) {
        var snaphot = self.dataSource.snapshot()
        
        if type == .popularMovie {
            snaphot.deleteItems(snaphot.itemIdentifiers(inSection: .popular))
            snaphot.appendItems(movies, toSection: .popular)
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        } else {
            snaphot.deleteItems(snaphot.itemIdentifiers(inSection: .movie))
            snaphot.appendItems(movies, toSection: .movie)
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 2), at: .centeredHorizontally, animated: true)
        }

        self.dataSource.apply(snaphot, animatingDifferences: true)
    }

    func displayTVShows(_ tvShows: [TVShow], type: TMDBHomePresenter.Popular) {
        var snapshot = self.dataSource.snapshot()

        if type == .popularTVShow {
            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .popular))
            snapshot.appendItems(tvShows, toSection: .popular)
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        } else {
            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .tvShow))
            snapshot.appendItems(tvShows, toSection: .tvShow)
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 3), at: .centeredHorizontally, animated: true)
        }

        self.dataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayPeople(_ people: [People]) {
        var snapshot = self.dataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .popular))
        snapshot.appendItems(people, toSection: .popular)
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayTrends(_ trends: [Trending]) {
        var snapshot = self.dataSource.snapshot()
        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .trending))
        snapshot.appendItems(trends, toSection: .trending)
        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 1), at: .centeredHorizontally, animated: true)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
}
