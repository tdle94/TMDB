//
//  TMDBCreatorHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 7/30/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBCreatorHeaderView: TMDBPreviewHeaderView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = NSLocalizedString("Creator", comment: "")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
