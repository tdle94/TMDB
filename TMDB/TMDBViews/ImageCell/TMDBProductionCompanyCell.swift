//
//  TMDBProductionCompanyCell.swift
//  TMDB
//
//  Created by Tuyen Le on 12/11/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RealmSwift
import UIKit

class TMDBProductionCompanyCell: TMDBImageCell, TMDBCellConfig {
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(item: Object) {
        guard
            let logoPath = (item as? ProductionCompany)?.logoPath,
            let url = userSetting.getImageURL(from: logoPath) else {
            return
        }
        imageView.sd_setImage(with: url)
    }
}
