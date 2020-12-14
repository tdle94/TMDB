//
//  TDMBImageCell.swift
//  TMDB
//
//  Created by Tuyen Le on 18.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import SDWebImage

class TMDBImageCell: UICollectionViewCell {
    var imageView: UIImageView = UIImageView()
    let userSetting: TMDBUserSettingProtocol = TMDBUserSetting()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
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
