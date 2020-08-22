//
//  TMDBPersonDetailViewController+UICollectionViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBPersonDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = appearInDataSource.itemIdentifier(for: indexPath) as? Movie {
            coordinate?.navigateToMovieDetail(id: item.id)
        } else if let item = appearInDataSource.itemIdentifier(for: indexPath) as? TVShow {
            coordinate?.navigateToTVShowDetail(tvId: item.id)
        }
    }
}
