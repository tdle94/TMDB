//
//  TMDBTVShowHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 8/10/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBTVShowHeaderView: TMDBPreviewHeaderView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = NSLocalizedString("TV Shows", comment: "")
        segmentControl.insertSegment(withTitle: NSLocalizedString("Top Rated", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("Air Today", comment: ""), at: 1, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("On The Air", comment: ""), at: 2, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }
}
