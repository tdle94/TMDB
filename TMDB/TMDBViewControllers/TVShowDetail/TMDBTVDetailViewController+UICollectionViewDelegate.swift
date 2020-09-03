//
//  TMDBTVDetailViewController+UICollectionViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBTVDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if
            let selectedIndex = addtionalHeaderView?.segmentControl.selectedSegmentIndex,
            collectionView == matchingTVShowCollectionView,
            indexPath.row == 0 {
            if addtionalHeaderView?.segmentControl.titleForSegment(at: selectedIndex) == NSLocalizedString("Similar", comment: "") {
                coordinate?.navigateToSimilarTVShow(id: tvId!)
            } else {
                coordinate?.navigateToRecommendTVShow(id: tvId!)
            }
        } else if
            collectionView == matchingTVShowCollectionView,
            let id = (matchingTVShowDataSource.snapshot().itemIdentifiers[indexPath.row] as? TVShow)?.id {

            coordinate?.navigateToTVShowDetail(tvId: id)
        } else if
            collectionView == tvShowCreditCollectionView,
            let id = (tvShowCreditDataSource.snapshot().itemIdentifiers[indexPath.row] as? Cast)?.id ?? (tvShowCreditDataSource.snapshot().itemIdentifiers[indexPath.row] as? Crew)?.id
        {
            coordinate?.navigateToPersonDetail(id: id)
        } else if
            collectionView == videoCollectionView,
            let video = tvShowVideoDataSource.itemIdentifier(for: indexPath) as? Video,
            let url = TMDBUserSetting().getYoutubeVideoURL(key: video.key) {

                coordinate?.navigateToVideoPlayer(with: url)
        } else if
            collectionView == creatorCollectionView,
            let id = (tvShowCreatorDataSrouce.itemIdentifier(for: indexPath) as? CreatedBy)?.id {
            
            coordinate?.navigateToPersonDetail(id: id)
        } else if collectionView == keywordCollectionView, let id = tvId {
            let keywordId = presenter.repository.getTVShowKeywords(from: id)[indexPath.row].id
            coordinate?.navigateToAllTVShow(query: DiscoverQuery(page: 1, withKeyword: String(keywordId)))
        }
    }
}
