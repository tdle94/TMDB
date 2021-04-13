//
//  TMDBSimilarAndRecommendMovieHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/10/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

class TMDBMovieLikeThisHeaderView: TMDBPreviewHeaderView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() {
        segmentControl.removeAllSegments()
        label.setHeader(title: NSLocalizedString("More", comment: ""))
        segmentControl.insertSegment(withTitle: NSLocalizedString("Similar", comment: ""), at: 0, animated: true)
        segmentControl.insertSegment(withTitle: NSLocalizedString("Recommend", comment: ""), at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
    }
}
