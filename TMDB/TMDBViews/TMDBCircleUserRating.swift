//
//  TMDBCircleUserRating.swift
//  TMDB
//
//  Created by Tuyen Le on 28.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TMDBCircleUserRating: UILabel {

    private var textLayer: CATextLayer = CATextLayer()
       
    private var remainingCircleLayer: CAShapeLayer = CAShapeLayer()
       
    private var partialCircleLayer: CAShapeLayer = CAShapeLayer()
    
    private var oldBounds: CGRect = .zero
       
    @IBInspectable
    var rating: Double = 0.0 {
        didSet {
            let endAngle: CGFloat
            
            if rating > 10 {
                endAngle = CGFloat(rating * (2 * .pi) / 100)
            } else {
                endAngle = CGFloat(rating * (2 * .pi) / 10)
            }

            textLayer.string = rating == 10.0 ? "10" : "\(rating)"
            
            remainingCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: oldBounds.size.width/2, y: oldBounds.size.height/2),
                                                     radius: oldBounds.size.width/2,
                                                     startAngle: endAngle,
                                                     endAngle: 2 * .pi,
                                                     clockwise: true).cgPath
            partialCircleLayer.path = UIBezierPath(arcCenter: CGPoint(x: oldBounds.size.width/2, y: oldBounds.size.height/2),
                                                   radius: oldBounds.size.width/2,
                                                   startAngle: 0,
                                                   endAngle: endAngle,
                                                   clockwise: true).cgPath
            
            partialCircleLayer.setNeedsLayout()
            partialCircleLayer.setNeedsDisplay()
            
            remainingCircleLayer.setNeedsLayout()
            remainingCircleLayer.setNeedsDisplay()
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.duration = 1
            partialCircleLayer.removeAnimation(forKey: "strokeEnd")
            partialCircleLayer.add(animation, forKey: "strokeEnd")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayer()
        backgroundColor = .clear
        partialCircleLayer.addSublayer(remainingCircleLayer)
        partialCircleLayer.insertSublayer(textLayer, above: remainingCircleLayer)
        layer.addSublayer(partialCircleLayer)
    }
    
    private func setupLayer() {
        oldBounds = bounds
        textLayer.frame = CGRect(x: bounds.midX - bounds.size.width/4,
                                 y: bounds.midY - bounds.size.height/4,
                                 width: bounds.size.width/2,
                                 height: bounds.size.height/2)
        textLayer.fontSize = 15
        textLayer.foregroundColor = Constant.Color.backgroundColor.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.alignmentMode = .center
        
        
        remainingCircleLayer.strokeColor = Constant.Color.primaryColor.cgColor
        remainingCircleLayer.fillColor = Constant.Color.primaryColor.cgColor
        remainingCircleLayer.lineWidth = 3
        
        partialCircleLayer.fillColor = Constant.Color.primaryColor.cgColor
        partialCircleLayer.strokeColor = Constant.Color.tertiaryColor.cgColor
        partialCircleLayer.lineWidth = 3
        
    }
}

