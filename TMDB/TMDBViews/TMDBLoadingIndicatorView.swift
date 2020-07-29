//
//  TMDBLoadingScrollView.swift
//  TMDB
//
//  Created by Tuyen Le on 7/28/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBLoadingIndicatorView: UIView {
    private(set) var loadingLayer: CAShapeLayer = CAShapeLayer()
    private(set) var previousAngle: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        loadingLayer.frame = bounds
        loadingLayer.strokeColor = UIColor.clear.cgColor
        loadingLayer.fillColor = UIColor.clear.cgColor
        loadingLayer.lineWidth = 3
        loadingLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY - bounds.size.height/4), radius: 10, startAngle: -.pi/2, endAngle: .pi * 2, clockwise: true).cgPath
        layer.addSublayer(loadingLayer)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func animateLoading(scrollView: UIScrollView) {
        let endAngle = scrollView.contentOffset.y/2 * -1 * .pi/180
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = previousAngle
        animation.toValue = endAngle
        animation.duration = 1
        loadingLayer.removeAnimation(forKey: "strokeEnd")
        loadingLayer.add(animation, forKey: "strokeEnd")
        
        previousAngle = endAngle
    }
}
