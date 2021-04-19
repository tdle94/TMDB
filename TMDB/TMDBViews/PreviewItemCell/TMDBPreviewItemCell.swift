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
    @IBOutlet weak var title: UILabel! {
        didSet {
            title.font = UIFont(name: "Circular-Black", size: UIFont.systemFontSize)
        }
    }
    @IBOutlet weak var subTitle: UILabel! {
        didSet {
            subTitle.font = UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)
        }
    }

    let userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

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
        ratingLabel.isHidden = item.hideRatingLabel
        title.setHeader(title: item.displayTitle)
        subTitle.setAttributeText(item.displaySubtitle)
        ratingLabel.rating = item.displayRating
        getImage(from: item.imagePath)
    }
}
