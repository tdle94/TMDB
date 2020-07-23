//
//  TMDBMoreMovieHeaderCell.swift
//  TMDB
//
//  Created by Tuyen Le on 7/1/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

/*
    Header View to display similar and recommend movie or tv show
 */
class TMDBAdditionalHeaderView: TMDBPreviewHeaderView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = NSLocalizedString("More", comment: "")
        segmentControl.insertSegment(withTitle: NSLocalizedString("Similar", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("Recommend", comment: ""), at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
