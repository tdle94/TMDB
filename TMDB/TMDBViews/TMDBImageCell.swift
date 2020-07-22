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
    var imageView: UIImageView = UIImageView()
    let userSetting: TMDBUserSettingProtocol = TMDBUserSetting()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        imageView.image = nil
    }
}

class TMDBBackdropImageCell: TMDBImageCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .top
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(image: Images) {
        guard let url = userSetting.getImageURL(from: image.filePath) else {
            imageView.image = UIImage(named: "NoImage")
            return
        }

        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"),
                              options: [SDWebImageOptions.continueInBackground, SDWebImageOptions.avoidAutoSetImage]) { newImage, _, _, _ in
            self.imageView.image = newImage?.sd_resizedImage(with: self.bounds.size, scaleMode: .aspectFit)
        }
    }
}

class TMDBNetworkImageCell: TMDBImageCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .center
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(networks: Networks) {
        guard let url = userSetting.getImageURL(from: networks.logoPath) else {
            return
        }

        imageView.sd_setImage(with: url) { image, _, _, _ in
            self.imageView.image = image?.sd_resizedImage(with: self.bounds.size, scaleMode: .aspectFit)
        }
    }
}
