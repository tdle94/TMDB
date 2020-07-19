//
//  TMDBImageCollectionView.swift
//  TMDB
//
//  Created by Tuyen Le on 18.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBHalfCircleIndicator: UICollectionReusableView {
    lazy var halfCircleLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.lineWidth = 1
        shape.strokeColor = Constant.Color.backgroundColor.cgColor
        shape.fillColor = UIColor.clear.cgColor
        return shape
    }()
    
    lazy var textLayer: CATextLayer = {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 0,
                                 y: bounds.midY - 7.5,
                                 width: 50,
                                 height: 20)
        textLayer.fontSize = 15
        textLayer.foregroundColor = Constant.Color.backgroundColor.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.string = NSLocalizedString("More", comment: "")
        textLayer.alignmentMode = .center
        return textLayer
    }()

    enum Orientation {
        case clockwise
        case counterclockwise
    }
    
    init(frame: CGRect, orientation: Orientation) {
        super.init(frame: frame)

        switch orientation {
        case .clockwise:
            halfCircleLayer.frame.origin.x += 10
            halfCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                                radius: bounds.size.width/2,
                                                startAngle: .pi/2,
                                                endAngle: .pi * 3/2,
                                                clockwise: true).cgPath
        case .counterclockwise:
            halfCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: 0, y: bounds.midY),
                                                radius: bounds.size.width/2,
                                                startAngle: .pi/2,
                                                endAngle: .pi * 3/2,
                                                clockwise: false).cgPath
        }

        backgroundColor = .clear
        halfCircleLayer.addSublayer(textLayer)
        layer.addSublayer(halfCircleLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
