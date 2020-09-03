//
//  TMDBAllPopularTVShowController.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAllPopularTVShowController: TMDBDisplayAllViewController {
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Popular", comment: "") + " " + NSLocalizedString("TV Shows", comment: "")
        presenter.getPopularTVShow(page: 1)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let tvShowCount = allDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == tvShowCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true) {
            presenter.page = presenter.page + 1
            footerLoadingView?.loadingIndicator.startAnimating()
            presenter.getPopularTVShow(page: presenter.page + 1)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tvShow = allDataSource.itemIdentifier(for: indexPath) as? TVShow else { return }
        coordinate?.navigateToTVShowDetail(tvId: tvShow.id)
    }
}
