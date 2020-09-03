//
//  TMDBDisplayAllViewController+TMDBShowAllDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

extension TMDBDisplayAllViewController: TMDBShowAllDelegate {
    func displayAll(objects: [Object]) {
        loadingView.removeFromSuperview()
        footerLoadingView?.loadingIndicator.stopAnimating()
        var snapshot = allDataSource.snapshot()
        snapshot.appendItems(objects)
        allDataSource.apply(snapshot, animatingDifferences: true)
    }
}
