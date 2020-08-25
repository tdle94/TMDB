//
//  TMDBMovieFilterViewController+UICollectionViewDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

extension TMDBMovieFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == languageCollectionView else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? TMDBFilterCell

        if cell?.label.text == languageSelected {
            collectionView.deselectItem(at: indexPath, animated: false)
            languageSelected = nil
        } else {
            languageSelected = cell?.label.text
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TMDBFilterCell

        if collectionView == languageCollectionView {
            query?.withOriginalLanguage = nil
        } else {
            var genres = query?.withGenres?.components(separatedBy: ",")
            let genreId = setting.movieGenres.first(where: { $0.name == cell.label.text })!.id
            genres?.removeAll(where: { $0 == String(genreId) })
            query?.withGenres = genres?.joined(separator: ",")
        }
    }
    
}
