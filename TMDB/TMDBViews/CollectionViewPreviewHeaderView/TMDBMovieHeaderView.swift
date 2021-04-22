//
//  TMDBMovieHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 09.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBMovieHeaderView: TMDBPreviewHeaderView {
    var viewAllType: ViewAllViewModel.ViewAll {
        if segmentControl.selectedSegmentIndex == 0 {
            return ViewAllViewModel.ViewAll.movie(.topRated)
        } else if segmentControl.selectedSegmentIndex == 1 {
            return ViewAllViewModel.ViewAll.movie(.nowPlaying)
        }
        return ViewAllViewModel.ViewAll.movie(.upcoming)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.setHeader(title: NSLocalizedString("Movies", comment: ""))
        segmentControl.insertSegment(withTitle: NSLocalizedString("Top Rated", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("Now Playing", comment: ""), at: 1, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("Upcoming", comment: ""), at: 2, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }
}
