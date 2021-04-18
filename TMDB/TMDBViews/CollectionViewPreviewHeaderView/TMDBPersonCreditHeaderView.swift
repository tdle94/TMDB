//
//  TMDBPersonCreditHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/26/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

class TMDBPersonCreditHeaderView: TMDBCreditHeaderView {
    override func setup() {
        segmentControl.removeAllSegments()
        label.setHeader(title: NSLocalizedString("Credit", comment: ""))
        segmentControl.insertSegment(withTitle: NSLocalizedString("Movies", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("TV Shows", comment: ""), at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }
}
