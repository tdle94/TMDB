//
//  TMDBMovieDetailViewController+TMDBKeywordLayoutDelegate.swift
//  TMDB
//
//  Created by Tuyen Le on 8/19/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

// MARK: - keyword collectionview delegate
extension TMDBMovieDetailViewController: TMDBKeywordLayoutDelegate {
    // dynamic width base on text
    func tagCellLayoutSize(layout: TMDBKeywordLayout, at index: Int) -> CGSize {
        let keyword = presenter.repository.getMovieKeywords(from: movieId!)[index]
        let label = UILabel()
        label.text = keyword.name
        return label.intrinsicContentSize
    }
}
