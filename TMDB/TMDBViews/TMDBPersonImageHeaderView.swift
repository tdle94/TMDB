//
//  TMDBPersonImageHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 17.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBPersonImageHeaderView: TMDBPreviewHeaderView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = NSLocalizedString("Images", comment: "")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
