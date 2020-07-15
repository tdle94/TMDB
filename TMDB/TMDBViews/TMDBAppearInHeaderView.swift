//
//  TMDBAppearInHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 7/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBAppearInHeaderView: TMDBPreviewHeaderView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = NSLocalizedString("Appear In", comment: "")
        segmentControl.insertSegment(withTitle: NSLocalizedString("Movies", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("TV Shows", comment: ""), at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
