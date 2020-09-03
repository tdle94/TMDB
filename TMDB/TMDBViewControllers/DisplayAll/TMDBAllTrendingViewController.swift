//
//  TMDBAllTrendingViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAllTrendingViewController: TMDBDisplayAllViewController {
    var time: TrendingTime = .today
    
    init(time: TrendingTime) {
        self.time = time
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        let trendingTime = time == .today ? NSLocalizedString("Today", comment: "") : NSLocalizedString("This Week", comment: "")
        title = NSLocalizedString("Trends", comment: "") + " " + trendingTime
        presenter.getTrending(page: 1, time: time)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let trendingCount = allDataSource.snapshot().itemIdentifiers.count
        if indexPath.row == trendingCount - 1, !(footerLoadingView?.loadingIndicator.isAnimating ?? true) {
            presenter.page += 1
            footerLoadingView?.loadingIndicator.startAnimating()
            presenter.getTrending(page: presenter.page, time: time)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let person = allDataSource.itemIdentifier(for: indexPath) as? People {
            coordinate?.navigateToPersonDetail(id: person.id)
        } else if let movie = allDataSource.itemIdentifier(for: indexPath) as? Movie {
            coordinate?.navigateToMovieDetail(id: movie.id)
        } else if let tvShow = allDataSource.itemIdentifier(for: indexPath) as? TVShow {
            coordinate?.navigateToTVShowDetail(tvId: tvShow.id)
        }
    }
}

