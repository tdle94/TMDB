//
//  UINavigationController+.swift
//  TMDB
//
//  Created by Tuyen Le on 12/10/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

extension UINavigationController {
    func resetNavBar() {
        guard !isMovingToParent else { return }
        navigationBar.barTintColor = Constant.Color.primaryColor
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.shadowImage = nil
        navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor ]
    }
}
