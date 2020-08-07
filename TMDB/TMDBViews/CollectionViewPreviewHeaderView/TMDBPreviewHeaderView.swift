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
    func segmentControlSelected(at index: Int, text selected: String)
}

class TMDBPreviewHeaderView: UICollectionReusableView {
    weak var delegate: TMDBPreviewSegmentControl?
    var label: UILabel = UILabel()
    var segmentControl: UISegmentedControl = UISegmentedControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        segmentControl.selectedSegmentTintColor = Constant.Color.primaryColor
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constant.Color.tertiaryColor], for: .selected)
        segmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
        
        addSubview(label)
        addSubview(segmentControl)

        label.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        segmentControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 44).isActive = true
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
        delegate?.segmentControlSelected(at: sender.selectedSegmentIndex, text: text)
    }
}
