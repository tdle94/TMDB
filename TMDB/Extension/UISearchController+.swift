//
//  UISearchController+.swift
//  TMDB
//
//  Created by Tuyen Le on 1/13/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit

extension UISearchController {
    func setup(withPlaceholder: String) {
        (searchBar.value(forKey: "searchField") as? UITextField)?.textColor = Constant.Color.backgroundColor
        (searchBar.value(forKey: "searchField") as? UITextField)?.attributedPlaceholder = NSAttributedString(string: withPlaceholder,
                                                                                                                              attributes: [ NSAttributedString.Key.foregroundColor : Constant.Color.backgroundColor ])
        searchBar.tintColor = Constant.Color.backgroundColor
        hidesNavigationBarDuringPresentation = false
        obscuresBackgroundDuringPresentation = false
        searchBar.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal),
                                    for: .search,
                                    state: .normal)
    }
}
