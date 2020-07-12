//
//  TMDBSearchResultCell.swift
//  TMDB
//
//  Created by Tuyen Le on 12.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBSearchResultCell: UITableViewCell {
    var id: Int?
    var mediaType: String?
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    func configure(item: MultiSearch) {
        textLabel?.text = item.originalTitle ?? item.originalName ?? item.name
        detailTextLabel?.text = item.releaseDate ?? item.firstAirDate
        id = item.id
        mediaType = item.mediaType
        if let path = item.profilePath ?? item.posterPath {
            imageView?.sd_setImage(with: userSetting.getImageURL(from: path),
                                   placeholderImage: UIImage(named: "NoImage")) { _, _, _, _ in
                                    self.layoutSubviews()
            }
        } else {
            imageView?.image = UIImage(named: "NoImage")?.resize(newWidth: imageView!.frame.width)
        }
    }
    
    override func prepareForReuse() {
        textLabel?.text = ""
        detailTextLabel?.text = ""
        mediaType = ""
        imageView?.image = UIImage(named: "NoImage")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: imageView!.frame.origin.x,
                                  y: 5,
                                  width: imageView!.frame.size.width,
                                  height: frame.height - 10)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constant.Color.backgroundColor
        textLabel?.font = UIFont(name: textLabel!.font.fontName, size: 15)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
