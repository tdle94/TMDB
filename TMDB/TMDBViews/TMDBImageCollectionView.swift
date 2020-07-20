//
//  TMDBImageCollectionView.swift
//  TMDB
//
//  Created by Tuyen Le on 19.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBImageCollectionView: UICollectionView {
    var rightIndicator: TMDBHalfCircleIndicator?
    var leftIndicator: TMDBHalfCircleIndicator?

    override func awakeFromNib() {
        super.awakeFromNib()
        rightIndicator = TMDBHalfCircleIndicator(frame: CGRect(x: bounds.maxX - 100,
                                                               y: bounds.midY - 50,
                                                               width: 100,
                                                               height: 100),
                                                 orientation: .clockwise)
        leftIndicator = TMDBHalfCircleIndicator(frame: CGRect(x: 0,
                                                              y: bounds.midY - 50,
                                                              width: 100,
                                                              height: 100),
                                                orientation: .counterclockwise)
        leftIndicator?.isHidden = true
        rightIndicator?.isHidden = true
        superview?.addSubview(rightIndicator!)
        superview?.addSubview(leftIndicator!)
    }
}

