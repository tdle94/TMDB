//
//  TMDBReviewCell.swift
//  TMDB
//
//  Created by Tuyen Le on 7/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBReivewCell: UITableViewCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.detailTextLabel?.numberOfLines = 0
            } else {
                self.detailTextLabel?.numberOfLines = 4
            }
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.isSelected = false
    }
}
