//
//  TMDBMovieKeywordCell.swift
//  TMDB
//
//  Created by Tuyen Le on 05.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBMovieKeywordCell: UICollectionViewCell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        contentView.addSubview(label)
        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.3
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(keyword: Keyword) {
        label.text = keyword.name
    }
}
