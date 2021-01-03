//
//  TMDBGuestStarHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/2/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit

class TMDBGuestStarHeaderView: TMDBCreditHeaderView {
    override func setup() {
        segmentControl.removeAllSegments()
        label.setHeader(title: NSLocalizedString("Credit", comment: ""))
        segmentControl.insertSegment(withTitle: NSLocalizedString("Guest Star", comment: ""), at: 0, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }
}
