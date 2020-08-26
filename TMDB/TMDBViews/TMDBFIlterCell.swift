//
//  TMDBFIlterCell.swift
//  TMDB
//
//  Created by Tuyen Le on 8/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBFilterCell: TMDBKeywordCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 0
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
