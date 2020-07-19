//
//  TMDBImageCollectionView.swift
//  TMDB
//
//  Created by Tuyen Le on 18.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBImageFooterView: UICollectionReusableView {
    lazy var halfCircleLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                  radius: bounds.size.width/2,
                                  startAngle: 0,
                                  endAngle: .pi,
                                  clockwise: true).cgPath
        shape.lineWidth = 1
        shape.strokeColor = Constant.Color.primaryColor.cgColor
        return shape
    }()
    
    lazy var textLayer: CATextLayer = {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 0,
                                 y: bounds.midY - bounds.size.height/4,
                                 width: bounds.size.width,
                                 height: bounds.size.height/2)
        textLayer.fontSize = 15
        textLayer.foregroundColor = Constant.Color.tertiaryColor.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.string = "More"
        return textLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
//        layer.addSublayer(halfCircleLayer)
//        layer.addSublayer(textLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

