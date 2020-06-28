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
    @IBOutlet weak var subTitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackViewTopConstraint.constant = 10
        imageView.image = nil
        imageView.isHidden = false
        title.text = ""
        subTitle.text = ""
    }

    private func getImage(from path: String?, repository: TMDBRepositoryProtocol) {
        guard
            let path = path,
            let url = repository.getImageURL(from: path) else {
                imageView.image = UIImage(named: "NoImage")
                return
        }
        imageView.sd_setImage(with: url, placeholderImage: nil, options: .init(rawValue: 0))
    }

    func configure(item: Object, with repository: TMDBRepositoryProtocol) {
        if let item = item as? Movie ?? (item as? Trending)?.movie {
            title.text = item.originalTitle
            subTitle.text = item.releaseDate
            getImage(from: item.posterPath, repository: repository)
        } else if let item = item as? TVShow ?? (item as? Trending)?.tv {
            title.text = item.originalName
            subTitle.text = item.firstAirDate
            getImage(from: item.posterPath, repository: repository)
        } else if let item = item as? People ?? (item as? Trending)?.people {
            title.text = item.name
            getImage(from: item.profilePath, repository: repository)
        } else if let item = item as? ProductionCompany {
            title.textAlignment = .center
            title.text = ""
            imageView.contentMode = .scaleAspectFit
            imageView.layer.borderColor = .none
            imageView.layer.borderWidth = 0
            stackViewTopConstraint.constant = 10
            if let path = item.logoPath {
                getImage(from: path, repository: repository)
            } else {
                stackViewTopConstraint.constant = -25
                title.text = item.name
                imageView.isHidden = true
            }
        } else if let item = item as? Cast {
            title.text = item.name
            subTitle.text = item.character
            
            getImage(from: item.profilePath, repository: repository)
        } else if let item = item as? Crew {
            title.text = item.name
            subTitle.text = item.job
            
            getImage(from: item.profilePath, repository: repository)
        }
    }
}
