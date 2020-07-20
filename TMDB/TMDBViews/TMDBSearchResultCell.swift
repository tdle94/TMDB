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
    private lazy var noImage: UIImage? = UIImage(named: "NoImage")?.sd_resizedImage(with: CGSize(width: imageView?.frame.size.width ?? 0, height: imageView?.frame.size.height ?? 0), scaleMode: .aspectFit)

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
            imageView?.image = noImage
        }
    }
    
    override func prepareForReuse() {
        textLabel?.text = ""
        detailTextLabel?.text = ""
        mediaType = ""
        imageView?.image = noImage
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
