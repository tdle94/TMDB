//
//  TMDBTelevisionViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 6/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAllTVShowViewController: TMDBDisplayAllViewController {
    // MARK: - query
    var tvQuery: DiscoverQuery = DiscoverQuery(page: 1)

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("TV Shows", comment: "")
        let filter = UIBarButtonItem(title: NSLocalizedString("Filter", comment: ""),
                                style: .plain,
                                target: self,
                                action: #selector(filterMovies))
        navigationItem.setRightBarButton(filter, animated: false)
        presenter.getAllTVShow(tvShowQuery: tvQuery)
    }
    
    override func filter(query: DiscoverQuery) {
        super.filter(query: query)
        tvQuery = query
        presenter.getAllTVShow(tvShowQuery: tvQuery)
    }

    // MARK: - user action
    @objc func filterMovies() {
        coordinate?.presentFilter(delegate: self, query: tvQuery, choice: .tvShow)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movieCount = allDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == movieCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true), movieCount != presenter.total {
            let page = tvQuery.page + 1
            tvQuery.page = page
            footerLoadingView?.loadingIndicator.startAnimating()
            presenter.getAllTVShow(tvShowQuery: tvQuery)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tvShow = allDataSource.itemIdentifier(for: indexPath) as? TVShow else { return }
        coordinate?.navigateToTVShowDetail(tvId: tvShow.id)
    }
}
