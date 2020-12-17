//
//  UILabel+.swift
//  TMDB
//
//  Created by Tuyen Le on 12/8/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

struct TMDBLabel {
    static func setAttributeText(title: String, subTitle: String? = nil) -> NSMutableAttributedString {
        guard let subTitle = subTitle else {
            return NSMutableAttributedString(string: title, attributes: [
                NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.systemFontSize)!),
                NSAttributedString.Key.foregroundColor: UIColor.darkGray
            ])
        }

        let firstString = NSMutableAttributedString(string: "\(title): ", attributes: [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "Circular-Black", size: UIFont.systemFontSize)!),
        ])

        let secondString = NSMutableAttributedString(string: subTitle, attributes: [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.systemFontSize)!),
        ])

        firstString.append(secondString)
        return firstString
    }
    
    static func setAtributeParagraph(title: String, paragraph: String) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        let headerStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 3
        headerStyle.lineSpacing = 6

        
        let first = NSMutableAttributedString(string: "\(title):\n", attributes: [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!),
            NSAttributedString.Key.paragraphStyle: headerStyle
        ])
        
        let second = NSAttributedString(string: paragraph,
                                        attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.systemFontSize)!),
                                                     NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                     NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        first.append(second)
        return first
    }
    
    static func setHeader(title: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!),
        ])
    }
}

extension UILabel {
    func setHeader(title: String) {
        attributedText = TMDBLabel.setHeader(title: title)
    }
}
