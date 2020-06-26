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
            imageView.roundImage()
        }
    }
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadingIndicator.startAnimating()
        imageView.image = UIImage(named: "NoImage")
        title.text = ""
        releaseDate.text = ""
    }
}
