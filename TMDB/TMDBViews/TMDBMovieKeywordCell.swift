//
//  KeywordCell.swift
//  TMDB
//
//  Created by Tuyen Le on 05.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBMovieKeywordCell: UICollectionViewCell {
    var label: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: bounds.size.width).isActive = true
        label.heightAnchor.constraint(equalToConstant: bounds.size.height).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
 
    func configure(keyword: Keyword) {
        label.text = keyword.name
    }
}
