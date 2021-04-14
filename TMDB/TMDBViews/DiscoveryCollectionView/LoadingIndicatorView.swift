//
//  LoadingIndicatorView.swift
//  TMDB
//
//  Created by Tuyen Le on 1/4/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UICollectionReusableView {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.isHidden = true
            label.setHeader(title: "End of result")
        }
    }
}
