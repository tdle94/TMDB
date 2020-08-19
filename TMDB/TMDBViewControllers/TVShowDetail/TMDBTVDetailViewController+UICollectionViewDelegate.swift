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
            collectionView == matchingTVShowCollectionView,
            let id = (matchingTVShowDataSource.snapshot().itemIdentifiers[indexPath.row] as? TVShow)?.id {

            coordinate?.navigateToTVShowDetail(tvId: id)
        }

        if
            collectionView == tvShowCreditCollectionView,
            let id = (tvShowCreditDataSource.snapshot().itemIdentifiers[indexPath.row] as? Cast)?.id ?? (tvShowCreditDataSource.snapshot().itemIdentifiers[indexPath.row] as? Crew)?.id
        {
            coordinate?.navigateToPersonDetail(id: id)
        }

        if
            collectionView == videoCollectionView,
            let video = tvShowVideoDataSource.itemIdentifier(for: indexPath) as? Video,
            let url = TMDBUserSetting().getYoutubeVideoURL(key: video.key) {

                coordinate?.navigateToVideoPlayer(with: url)
        }
        
        if
            collectionView == creatorCollectionView,
            let id = (tvShowCreatorDataSrouce.itemIdentifier(for: indexPath) as? CreatedBy)?.id {
            
            coordinate?.navigateToPersonDetail(id: id)
        }

        if collectionView == keywordCollectionView, let id = tvId {
            let keywordId = presenter.repository.getTVShowKeywords(from: id)[indexPath.row].id
            coordinate?.navigateToAllTVShow(query: DiscoverQuery(page: 1, withKeyword: String(keywordId)))
        }
    }
}
