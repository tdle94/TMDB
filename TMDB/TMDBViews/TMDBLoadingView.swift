//
//  TMDBLoadingView.swift
//  TMDB
//
//  Created by Tuyen Le on 7/27/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBLoadingView: UIView {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.text = "Something went wrong"
        }
    }

    override func awakeFromNib() {
        errorLabel.isHidden = true
        loadingIndicator.startAnimating()
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func showError(_ show: Bool) {
        if show {
            loadingIndicator.stopAnimating()
            errorLabel.isHidden = false
        }
    }
}
