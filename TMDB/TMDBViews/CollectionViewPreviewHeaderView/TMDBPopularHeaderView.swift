//
//  TMDBPreviewHeaderCell.swift
//  TMDB
//
//  Created by Tuyen Le on 6/16/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//
import Foundation
import UIKit

class TMDBPopularHeaderView: TMDBPreviewHeaderView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.setHeader(title: NSLocalizedString("Popular", comment: ""))
        segmentControl.insertSegment(withTitle: NSLocalizedString("Movies", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("TV Shows", comment: ""), at: 1, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("People", comment: ""), at: 2, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
