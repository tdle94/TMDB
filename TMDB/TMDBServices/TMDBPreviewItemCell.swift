//
//  PopularItemCell.swift
//  TMDB
//
//  Created by Tuyen Le on 6/16/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SDWebImage

class TMDBPreviewItemCell: UICollectionViewCell {
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.roundImage()
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackViewTopConstraint.constant = 10
        imageView.image = UIImage(named: "NoImage")
        imageView.isHidden = false
        title.text = ""
        releaseDate.text = ""
    }

    func configure(item: Object, with repository: TMDBRepositoryProtocol) {
        var url: URL?

        if let item = item as? Movie ?? (item as? Trending)?.movie {
            title.text = item.originalTitle
            releaseDate.text = item.releaseDate
            if let path = item.posterPath {
                url = repository.getImageURL(from: path)
            }
        } else if let item = item as? TVShow ?? (item as? Trending)?.tv {
            title.text = item.originalName
            releaseDate.text = item.firstAirDate
            if let path = item.posterPath {
                url = repository.getImageURL(from: path)
            }
        } else if let item = item as? People ?? (item as? Trending)?.people {
            title.text = item.name
            if let path = item.profilePath {
                url = repository.getImageURL(from: path)
            }
        } else if let item = item as? ProductionCompany {
            title.textAlignment = .center
            title.text = ""
            imageView.contentMode = .scaleAspectFit
            imageView.layer.borderColor = .none
            imageView.layer.borderWidth = 0
            stackViewTopConstraint.constant = 10
            if let path = item.logoPath {
                url = repository.getImageURL(from: path)
            } else {
                stackViewTopConstraint.constant = -25
                title.text = item.name
                imageView.isHidden = true
            }
        }
        imageView.sd_setImage(with: url, placeholderImage: nil, options: .init(rawValue: 0))
    }
}
