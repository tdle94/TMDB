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
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.setHeader(title: NSLocalizedString("Trends", comment: ""))
        segmentControl.insertSegment(withTitle: NSLocalizedString("Today", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("This Week", comment: ""), at: 1, animated: true)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
