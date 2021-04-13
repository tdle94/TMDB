//
//  TMDBPreviewHeaderView.swift
//  TMDB
//
//  Created by Tuyen Le on 7/3/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

protocol TMDBPreviewSegmentControl: AnyObject {
    func segmentControlSelected(_ header: TMDBPreviewHeaderView, text selected: String)
}

class TMDBPreviewHeaderView: UICollectionReusableView {
    weak var delegate: TMDBPreviewSegmentControl?
    var label: UILabel = UILabel()
    var segmentControl: UISegmentedControl = UISegmentedControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let solidIndicator = UIView()
        solidIndicator.backgroundColor = Constant.Color.tertiaryColor
        
        segmentControl.selectedSegmentTintColor = Constant.Color.primaryColor
        segmentControl.setTitleTextAttributes([
                                                NSAttributedString.Key.foregroundColor: Constant.Color.tertiaryColor
                                                ], for: .selected)
        segmentControl.setTitleTextAttributes([
                                                NSAttributedString.Key.foregroundColor: UIColor.darkText],
                                              for: .normal)
        
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        
        addSubview(label)
        addSubview(segmentControl)
        addSubview(solidIndicator)
        
        solidIndicator.widthAnchor.constraint(equalToConstant: 5).isActive = true
        solidIndicator.heightAnchor.constraint(equalToConstant: bounds.height).isActive = true
        solidIndicator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        solidIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        solidIndicator.transform = CGAffineTransform.init(scaleX: 1, y: 0.9)

        label.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        solidIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        label.heightAnchor.constraint(equalToConstant: bounds.height).isActive = true

        segmentControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: bounds.height).isActive = true

        addConstraint(NSLayoutConstraint(item: label,
                                         attribute: .trailing,
                                         relatedBy: .equal,
                                         toItem: segmentControl,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: -8))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func segmentControlAction(_ sender: UISegmentedControl) {
        let text = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        delegate?.segmentControlSelected(self, text: text)
    }
}
