//
//  TDMBImageCell.swift
//  TMDB
//
//  Created by Tuyen Le on 18.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class TMDBImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    let userSetting: TMDBUserSettingProtocol = TMDBUserSetting()
    
    func configure(image: Images) {
        guard let url = userSetting.getImageURL(from: image.filePath) else {
            imageView.image = UIImage(named: "NoImage")
            return
        }

        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"), options: [SDWebImageOptions.continueInBackground, SDWebImageOptions.avoidAutoSetImage]) { newImage, _, _, _ in
            if newImage == nil {
                self.imageView.image = UIImage(named: "NoImage")
            } else {
                self.imageView.image = newImage?.sd_resizedImage(with: CGSize(width: self.bounds.size.width, height: 212), scaleMode: .aspectFit)
            }
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
