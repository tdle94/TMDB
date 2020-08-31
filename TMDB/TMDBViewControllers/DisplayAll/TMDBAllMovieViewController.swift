//
//  AllMovieCollectionView.swift
//  TMDB
//
//  Created by Tuyen Le on 8/12/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAllMovieViewController: TMDBDisplayAllViewController {
    // MARK: - query
    var movieQuery: DiscoverQuery = DiscoverQuery(page: 1)

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Movies", comment: "")
        let filter = UIBarButtonItem(title: NSLocalizedString("Filter", comment: ""),
                                style: .plain,
                                target: self,
                                action: #selector(filterMovies))
        navigationItem.setRightBarButton(filter, animated: false)
        presenter.getAllMovie(query: movieQuery)
    }

    override func filter(query: DiscoverQuery) {
        super.filter(query: query)
        movieQuery = query
        presenter.getAllMovie(query: movieQuery)
    }

    // MARK: - user action
    @objc func filterMovies() {
        coordinate?.presentFilter(delegate: self, query: movieQuery, choice: .movie)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movieCount = allDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == movieCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true), movieCount != presenter.total {
            let page = movieQuery.page + 1
            movieQuery.page = page
            footerLoadingView?.loadingIndicator.startAnimating()
            presenter.getAllMovie(query: movieQuery)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = allDataSource.itemIdentifier(for: indexPath) as? Movie else { return }
        coordinate?.navigateToMovieDetail(id: movie.id)
    }
}
