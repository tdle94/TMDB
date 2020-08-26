//
//  TMDBAllTVShowViewController+UICollectionViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBAllTVShowViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movieCount = allTVShowDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == movieCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true), movieCount != presenter.totalTVShows {
            let page = movieCount / 20 + 1
            tvQuery.page = page
            footerLoadingView?.loadingIndicator.startAnimating()
            presenter.getAllTVShow(tvShowQuery: tvQuery)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tvShow = allTVShowDataSource.itemIdentifier(for: indexPath) as? TVShow else { return }
        coordinate?.navigateToTVShowDetail(tvId: tvShow.id)
    }
}
