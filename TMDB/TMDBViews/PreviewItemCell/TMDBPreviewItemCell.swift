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
    @IBOutlet weak var ratingLabel: TMDBCircleUserRating!
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

    let userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    override func prepareForReuse() {
        super.prepareForReuse()
        stackViewTopConstraint.constant = 8
        imageView.image = nil
        imageView.isHidden = false
        ratingLabel.isHidden = true
        title.text = ""
        subTitle.text = ""
    }

    private func getImage(from path: String?) {
        guard
            let path = path,
            let url = userSetting.getImageURL(from: path) else {
                imageView.image = UIImage(named: "NoImage")
                return
        }
        imageView.sd_setImage(with: url)
    }
}

extension TMDBPreviewItemCell: TMDBCellConfig {
    func configure(item: Object) {
        if let item = item as? Movie ?? (item as? Trending)?.movie {
            ratingLabel.isHidden = false
            ratingLabel.rating = item.voteAverage
            title.text = item.originalTitle
            subTitle.text = item.releaseDate
            getImage(from: item.posterPath)
        } else if let item = item as? TVShow ?? (item as? Trending)?.tv {
            ratingLabel.isHidden = false
            ratingLabel.rating = item.voteAverage
            title.text = item.originalName
            subTitle.text = item.firstAirDate
            getImage(from: item.posterPath)
        } else if let item = item as? People ?? (item as? Trending)?.people {
            title.text = item.name
            ratingLabel.isHidden = false
            ratingLabel.rating = item.popularity
            subTitle.text = item.knownForDepartment
            getImage(from: item.profilePath)
        } else if let item = item as? ProductionCompany {
            title.textAlignment = .center
            title.text = ""
            imageView.layer.borderColor = .none
            imageView.layer.borderWidth = 0
            stackViewTopConstraint.constant = 0
            if let path = item.logoPath {
                getImage(from: path)
            } else {
                stackViewTopConstraint.constant = -80
                title.text = item.name
                imageView.isHidden = true
            }
        } else if let item = item as? Cast {
            title.text = item.name
            stackViewTopConstraint.constant = -8
            subTitle.text = item.character
            getImage(from: item.profilePath)
        } else if let item = item as? Crew {
            title.text = item.name
            subTitle.text = item.job
            stackViewTopConstraint.constant = -8
            getImage(from: item.profilePath)
        } else if let item = item as? Video, let url = userSetting.getYoutubeImageURL(key: item.key) {
            title.text = item.name
            imageView.sd_setImage(with: url)
        } else if let item = item as? Images {
            getImage(from: item.filePath)
        } else if let item = item as? CreatedBy {
            title.text = item.name
            getImage(from: item.profilePath)
        }
    }
}
