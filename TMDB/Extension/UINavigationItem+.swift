//
//  UINavigationItem+.swift
//  TMDB
//
//  Created by Tuyen Le on 12/10/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

extension UINavigationItem {
    func setBackArrowIcon() {
        setLeftBarButton(UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                        style: .plain,
                                                        target: self,
                                                        action: nil),
                                         animated: true)
        leftBarButtonItem?.tintColor = Constant.Color.backgroundColor
    }
    
    func setLoveIcon() {
        setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "heart"),
                                                         style: .plain,
                                                         target: self,
                                                         action: nil),
                                          animated: true)

        rightBarButtonItem?.tintColor = Constant.Color.backgroundColor
    }
}
