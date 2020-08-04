//
//  TMDBSearchResultCell.swift
//  TMDB
//
//  Created by Tuyen Le on 12.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class TMDBCustomTableViewCell: UITableViewCell {
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()
    var noImage: UIImage?

    override func prepareForReuse() {
        textLabel?.text = ""
        detailTextLabel?.text = ""
        imageView?.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: imageView?.frame.origin.x ?? 0,
                                  y: 5,
                                  width: imageView?.frame.size.width ?? 0,
                                  height: frame.height - 10)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constant.Color.backgroundColor
        textLabel?.font = UIFont(name: textLabel!.font.fontName, size: 15)
        detailTextLabel?.numberOfLines = 2
        accessoryType = .disclosureIndicator
        noImage = UIImage(named: "NoImage")?.sd_resizedImage(with: self.imageView?.frame.size ?? .zero, scaleMode: .aspectFit)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(text: String?, detailText: String?, imagePath: String?) {
        textLabel?.text = text
        detailTextLabel?.text = detailText
        if let path = imagePath {
            imageView?.sd_setImage(with: userSetting.getImageURL(from: path), placeholderImage: nil) { image, _, _, _ in
                if image == nil {
                    self.imageView?.image = self.noImage
                }
                self.layoutSubviews()
            }
        } else {
            imageView?.image = noImage
        }
    }
}
