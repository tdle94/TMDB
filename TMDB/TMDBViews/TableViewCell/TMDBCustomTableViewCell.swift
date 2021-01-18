//
//  TMDBSearchResultCell.swift
//  TMDB
//
//  Created by Tuyen Le on 12.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SDWebImage

class TMDBCustomTableViewCell: UITableViewCell {
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()
    private lazy var noImage: UIImage? = UIImage(named: "NoImage")?.sd_resizedImage(with: _imageView.frame.size, scaleMode: .aspectFit)

    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var _imageView: UIImageView!

    override func prepareForReuse() {
        label.text = ""
        subTitle.text = ""
        _imageView.image = noImage
        _imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        _imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension TMDBCustomTableViewCell: TMDBCellConfig {
    func configure(item: Object) {
        var path: String?
        if let item = item as? MultiSearch {
            label.setHeader(title: item.originalTitle ?? item.originalName ?? item.name ?? "")
            subTitle.setAttributeText(title: item.releaseDate ?? item.firstAirDate ?? "")
            path = item.posterPath ?? item.profilePath
        } else if let item = item as? Season {
            label.setHeader(title: item.name)
            subTitle.setAttributeText(title: item.overview)
            path = item.posterPath
        } else if let item = item as? Episode {
            label.setHeader(title: item.name)
            subTitle.setAttributeText(title: item.overview)
            path = item.stillPath
        }
        
        if let path = path {
            _imageView.sd_setImage(with: userSetting.getImageURL(from: path))
        } else {
            _imageView.image = noImage
            _imageView.sd_imageIndicator = nil
        }
    }
}
