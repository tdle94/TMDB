//
//  TMDBAllPopularMovieViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAllPopularMovieViewController: TMDBDisplayAllViewController {
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Popular", comment: "") + " " + NSLocalizedString("Movies", comment: "")
        presenter.getPopularMovie(page: 1)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movieCount = allDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == movieCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true), movieCount != presenter.total {
            presenter.page = presenter.page + 1
            footerLoadingView?.loadingIndicator.startAnimating()
            presenter.getPopularMovie(page: presenter.page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = allDataSource.itemIdentifier(for: indexPath) as? Movie else { return }
        coordinate?.navigateToMovieDetail(id: movie.id)
    }
}
