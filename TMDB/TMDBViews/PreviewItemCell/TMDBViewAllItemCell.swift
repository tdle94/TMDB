//
//  TMDBViewAllItemCell.swift
//  TMDB
//
//  Created by Tuyen Le on 2/19/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit

class TMDBViewAllItemCell: UICollectionViewCell {
    @IBOutlet weak var viewAllLabel: UILabel! {
        didSet {
            viewAllLabel.setHeader(title: "View All")
        }
    }
    
    @IBOutlet weak var borderView: UIView!
    
    override func awakeFromNib() {
        backgroundColor = .clear
        borderView.backgroundColor = .clear
        borderView.layer.borderWidth = 0.3
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.cornerRadius = 10
    }
}
