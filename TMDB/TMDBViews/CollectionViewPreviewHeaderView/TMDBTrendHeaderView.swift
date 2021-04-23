//
//  TMDBTrendHeaderCell.swift
//  TMDB
//
//  Created by Tuyen Le on 7/3/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBTrendHeaderView: TMDBPreviewHeaderView {
    var viewAllType: ViewAllViewModel.ViewAll {
        if segmentControl.selectedSegmentIndex == 0 {
            return ViewAllViewModel.ViewAll.trending(.today)
        }
        return ViewAllViewModel.ViewAll.trending(.thisWeek)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.setHeader(title: NSLocalizedString("Trends", comment: ""))
        segmentControl.insertSegment(withTitle: NSLocalizedString("Today", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("This Week", comment: ""), at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
