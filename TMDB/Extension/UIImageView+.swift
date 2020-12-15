//
//  UIImageView+.swift
//  TMDB
//
//  Created by Tuyen Le on 6/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundImage() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerCurve = .circular
    }
}
