//
//  TMDBCircleUserRating.swift
//  TMDB
//
//  Created by Tuyen Le on 28.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBCircleUserRating: UILabel {
    private var partialCircle: UIBezierPath?

    private var remainingCircle: UIBezierPath?

    private lazy var textLayer: CATextLayer = {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: bounds.midX - bounds.size.width/4,
                                 y: bounds.midY - bounds.size.height/4,
                                 width: bounds.size.width/2,
                                 height: bounds.size.height/2)
        textLayer.fontSize = 15
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        return textLayer
    }()
       
    private lazy var remainingCircleLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = Constant.Color.primaryColor.cgColor
        shapeLayer.fillColor = Constant.Color.primaryColor.cgColor
        shapeLayer.lineWidth = 3
        return shapeLayer
    }()
       
    private lazy var partialCircleLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = Constant.Color.primaryColor.cgColor
        shapeLayer.strokeColor = Constant.Color.tertiaryColor.cgColor
        shapeLayer.lineWidth = 3
        return shapeLayer
    }()
       
    var rating: Double = 0.0 {
        didSet {
            let endAngle = CGFloat(rating * (2 * .pi) / 10)
            textLayer.string = rating == 10.0 ? "10" : "\(rating)"

            partialCircle = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width/2, y: bounds.size.height/2),
                                         radius: 20,
                                         startAngle: 0,
                                         endAngle: endAngle,
                                         clockwise: true)
            remainingCircle = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width/2, y: bounds.size.height/2),
                                           radius: 20,
                                           startAngle: endAngle,
                                           endAngle: 2 * .pi,
                                           clockwise: true)

            remainingCircleLayer.path = remainingCircle?.cgPath
            remainingCircleLayer.setNeedsLayout()
            remainingCircleLayer.setNeedsDisplay()
               
            partialCircleLayer.path = partialCircle?.cgPath
            partialCircleLayer.setNeedsLayout()
            partialCircleLayer.setNeedsDisplay()
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 1
            partialCircleLayer.removeAnimation(forKey: "strokeEnd")
            partialCircleLayer.add(animation, forKey: "strokeEnd")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        partialCircleLayer.addSublayer(remainingCircleLayer)
        partialCircleLayer.insertSublayer(textLayer, above: remainingCircleLayer)
        layer.addSublayer(partialCircleLayer)
    }
}

