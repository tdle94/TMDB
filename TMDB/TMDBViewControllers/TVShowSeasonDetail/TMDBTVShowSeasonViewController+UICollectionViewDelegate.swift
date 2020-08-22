//
//  TMDBTVShowSeasonViewController+UICollectionViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/21/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBTVShowSeasonViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == creditCollectionView, let cast = creditDataSource.itemIdentifier(for: indexPath) as? Cast {
            coordinate?.navigateToPersonDetail(id: cast.id)
        }
    }
}
