//
//  TMDBHomeViewController+UICollectionViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/17/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension TMDBHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: Object? = dataSource.itemIdentifier(for: indexPath)

        if let item = item as? Movie ?? (item as? Trending)?.movie {
            coordinate?.navigateToMovieDetail(id: item.id)
        } else if let item = item as? People ?? (item as? Trending)?.people {
            coordinate?.navigateToPersonDetail(id: item.id)
        } else if let item = item as? TVShow ?? (item as? Trending)?.tv {
            coordinate?.navigateToTVShowDetail(tvId: item.id)
        } else if let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? TMDBPopularHeaderView {
            if header.segmentControl.selectedSegmentIndex == 0 {
                coordinate?.navigateToAllPopularMovie()
            } else if header.segmentControl.selectedSegmentIndex == 1 {
                coordinate?.navigateToAllPopularTVShow()
            } else {
                coordinate?.navigateToAllPopularPeople()
            }
        } else if let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? TMDBTrendHeaderView {
            if header.segmentControl.selectedSegmentIndex == 0 {
                coordinate?.navigateToAllTrend(time: .today)
            } else {
                coordinate?.navigateToAllTrend(time: .week)
            }
        } else if let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? TMDBMovieHeaderView {
            if header.segmentControl.selectedSegmentIndex == 0 {
                coordinate?.navigateToAllTopRatedMovie()
            } else if header.segmentControl.selectedSegmentIndex == 1 {
                coordinate?.navigateToAllNowPlayingMovie()
            } else {
                coordinate?.navigateToAllUpcomingMovie()
            }
        } else if let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath) as? TMDBTVShowHeaderView {
            if header.segmentControl.selectedSegmentIndex == 0 {
                coordinate?.navigateToAllTopRatedTVShow()
            } else if header.segmentControl.selectedSegmentIndex == 1 {
                coordinate?.navigateToAllTVShowAiringToday()
            } else {
                coordinate?.navigateToAllTVShowOnTheAir()
            }
        }
    }
}
