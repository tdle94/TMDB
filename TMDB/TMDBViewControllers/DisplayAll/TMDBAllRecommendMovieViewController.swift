//
//  TMDBAllRecommendMovieViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 31.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAllRecommendMovieViewController: TMDBDisplayAllViewController {
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Recommend", comment: "")
        if let id = presenter.id {
            presenter.getRecommendMovie(id: id, page: 1)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let peopleCount = allDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == peopleCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true), peopleCount != presenter.total, let id = presenter.id {
            presenter.page = presenter.page + 1
            footerLoadingView?.loadingIndicator.startAnimating()
            presenter.getRecommendMovie(id: id, page: presenter.page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = allDataSource.itemIdentifier(for: indexPath) as? Movie else { return }
        coordinate?.navigateToMovieDetail(id: movie.id)
    }
}
