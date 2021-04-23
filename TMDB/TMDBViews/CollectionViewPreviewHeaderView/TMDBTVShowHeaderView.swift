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
    var viewAllType: ViewAllViewModel.ViewAll {
        if segmentControl.selectedSegmentIndex == 0 {
            return ViewAllViewModel.ViewAll.tvshow(.topRated)
        } else if segmentControl.selectedSegmentIndex == 1 {
            return ViewAllViewModel.ViewAll.tvshow(.airToday)
        }
        return ViewAllViewModel.ViewAll.tvshow(.onTheAir)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.setHeader(title: NSLocalizedString("TV Shows", comment: ""))
        segmentControl.insertSegment(withTitle: NSLocalizedString("Top Rated", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("Air Today", comment: ""), at: 1, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("On The Air", comment: ""), at: 2, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }
}
