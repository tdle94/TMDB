//
//  TMDBViewAllCell.swift
//  TMDB
//
//  Created by Tuyen Le on 29.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBViewAllCell: UICollectionViewCell {
    var label: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let borderView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height/1.27))
        borderView.layer.borderWidth = 0.1
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.cornerRadius = 10

        contentView.addSubview(borderView)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("View all", comment: "")
        label.centerYAnchor.constraint(equalTo: borderView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
