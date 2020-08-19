//
//  TMDBMovieDetailViewController+UICollectionViewDataSource.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

// MARK: -  keyword collectionview datasource
extension TMDBMovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let id = movieId else {
            return UICollectionViewCell()
        }

        if
            collectionView == keywordCollectionView,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.keywordCell, for: indexPath) as? TMDBKeywordCell
        {
            let keyword = repository.getMovieKeywords(from: id)[indexPath.row]
            cell.configure(keyword: keyword)
            return cell
        }
        return UICollectionViewCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let id = movieId else { return 0 }
        return repository.getMovieKeywords(from: id).count
    }
}
