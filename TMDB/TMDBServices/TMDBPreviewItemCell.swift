//
//  PopularItemCell.swift
//  TMDB
//
//  Created by Tuyen Le on 6/16/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBPreviewItemCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            imageView.layer.borderWidth = 1.0
            imageView.layer.cornerCurve = .circular
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        title.text = ""
        releaseDate.text = ""
    }
}
