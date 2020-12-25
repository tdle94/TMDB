//
//  TVShowSeasonDetailModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RxDataSources

enum TVShowSeasonDetailModel {
    case Credits(items: [CustomElementType])
}

extension TVShowSeasonDetailModel: AnimatableSectionModelType {
    typealias Item = CustomElementType
    
    typealias Identity = Int
    
    var identity: Int {
        switch self {
        case .Credits(items: let items):
            return items.hashValue
        }
    }
        
    var items: [CustomElementType] {
        switch self {
        case .Credits(items: let items):
            return items
        }
    }
        
    init(original: TVShowSeasonDetailModel, items: [CustomElementType]) {
        switch original {
        case .Credits(items: let items):
            self = .Credits(items: items)
        }
    }
}
