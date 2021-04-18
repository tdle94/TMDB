//
//  Constant.swift
//  TMDB
//
//  Created by Tuyen Le on 6/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    struct Identifier {
        static let previewFooter = "PreviewFooter"
        static let previewHeader = "PreviewHeader"
        static let previewItem = "PreviewItem"
        static let sortByCell = "SortByCell"
        static let cell = "Cell"
        static let viewAllCell = "ViewAllCell"
        static let genreCell = "GenreCell"
    }
    struct Color {
        static let primaryColor = UIColor(displayP3Red: 13/255, green: 37/255, blue: 63/255, alpha: 1)
        static let secondaryColor = UIColor(displayP3Red: 1/255, green: 180/255, blue: 228/255, alpha: 1)
        static let tertiaryColor = UIColor(displayP3Red: 144/255, green: 206/255, blue:  161/255, alpha: 1)
        static let backgroundColor = UIColor(displayP3Red: 235/255, green: 235/255, blue: 240/255, alpha: 1)
        static let tabBarSelectedTextColor = UIColor(displayP3Red: 231/255, green: 232/255, blue:  238/255, alpha: 1)
    }
}
