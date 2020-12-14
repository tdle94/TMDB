//
//  UILabel+.swift
//  TMDB
//
//  Created by Tuyen Le on 12/8/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

extension UILabel {
    func setAttributeText(title: String, subTitle: String? = nil) {
        guard let subTitle = subTitle else {
            attributedText = NSMutableAttributedString(string: title, attributes: [
                NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.systemFontSize)!),
                NSAttributedString.Key.foregroundColor: UIColor.darkGray
            ])
            return
        }

        let firstString = NSMutableAttributedString(string: "\(title): ", attributes: [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "Circular-Black", size: UIFont.systemFontSize)!),
        ])

        let secondString = NSMutableAttributedString(string: subTitle, attributes: [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.systemFontSize)!),
        ])

        firstString.append(secondString)
        attributedText = firstString
    }
    
    func setAtributeParagraph(title: String, paragraph: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3

        
        let first = NSMutableAttributedString(string: "\(title):\n", attributes: [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!),
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        
        let second = NSAttributedString(string: paragraph,
                                        attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.systemFontSize)!),
                                                     NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                     NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        first.append(second)
        attributedText = first
    }
    
    func setHeader(title: String) {
        attributedText = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!),
        ])
    }
}
