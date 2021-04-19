//
//  LoadIndicatorCollectionView.swift
//  TMDB
//
//  Created by Tuyen Le on 4/15/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit

class LoadIndicatorCollectionView: UICollectionView {
    var loadIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var errorLabel: UILabel = UILabel()
    
    private var background: UIView = UIView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundView = background
        background.addSubview(loadIndicator)
        background.addSubview(errorLabel)
        
        loadIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadIndicator.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
        loadIndicator.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        loadIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        loadIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: background.widthAnchor).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        errorLabel.textAlignment = .center
        errorLabel.textColor = .black
        
        loadIndicator.color = .black
        loadIndicator.startAnimating()
    }
}
