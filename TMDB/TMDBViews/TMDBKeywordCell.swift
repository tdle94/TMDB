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
    let label = UILabel(frame: .zero)

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
        contentView.addSubview(label)

        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true

        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(keyword: Keyword) {
        label.text = keyword.name
    }
}
