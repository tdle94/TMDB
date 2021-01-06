//
//  UINavigationController+.swift
//  TMDB
//
//  Created by Tuyen Le on 12/10/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setNavBar(withAlphaComponent: CGFloat = 0.0) {
        let color = Constant.Color.primaryColor.withAlphaComponent(withAlphaComponent)
        let image = UIImage.imageFromColor(color: color)

        navigationBar.setBackgroundImage(image, for: .default)
        navigationBar.shadowImage = image
        navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.clear ]
    }
    
    func resetNavBar() {
        navigationBar.barTintColor = Constant.Color.primaryColor
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.shadowImage = nil
        navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor ]
    }
}
