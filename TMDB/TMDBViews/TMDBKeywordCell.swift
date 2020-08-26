//
//  TMDBMovieKeywordCell.swift
//  TMDB
//
//  Created by Tuyen Le on 05.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBKeywordCell: UICollectionViewCell {
    let label = UILabel()

    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.backgroundColor = Constant.Color.primaryColor.cgColor
                label.textColor = .white
            } else {
                layer.backgroundColor = nil
                label.textColor = UIColor(white: 0.333333, alpha: 1)
            }
        }
    }

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
        label.sizeToFit()
        label.frame.origin = CGPoint(x: bounds.midX - label.frame.size.width/2,
                                     y: 0 + (bounds.maxY - label.bounds.maxY)/2)
    }
}
