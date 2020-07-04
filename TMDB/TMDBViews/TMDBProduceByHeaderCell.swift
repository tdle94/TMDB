//
//  TMDBProductionHeaderCell.swift
//  TMDB
//
//  Created by Tuyen Le on 7/3/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBProduceByHeaderView: TMDBPreviewHeaderView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = NSLocalizedString("Produce by", comment: "")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
