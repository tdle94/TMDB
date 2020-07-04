//
//  TMDBVideoHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 04.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBVideoHeaderView: TMDBPreviewHeaderView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Videos"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
