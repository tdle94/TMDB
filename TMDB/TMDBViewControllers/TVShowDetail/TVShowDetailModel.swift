//
//  TVShowDetailModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/18/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RealmSwift
import RxDataSources

enum TVShowDetailModel {
    case Credits(items: [CustomElementType])
    case TVShowsLikeThis(items: [CustomElementType])
}

extension TVShowDetailModel: AnimatableSectionModelType {
    typealias Item = CustomElementType
    
    typealias Identity = Int
    
    var identity: Int {
        switch self {
        case .Credits(items: let items):
            return items.hashValue
        case .TVShowsLikeThis(items: let items):
            return items.hashValue
        }
    }
        
    var items: [CustomElementType] {
        switch self {
        case .Credits(items: let items):
            return items
        case .TVShowsLikeThis(items: let items):
            return items
        }
    }
        
    init(original: TVShowDetailModel, items: [CustomElementType]) {
        switch original {
        case .Credits(items: let items):
            self = .Credits(items: items)
        case .TVShowsLikeThis(items: let items):
            self = .TVShowsLikeThis(items: items)
        }
    }
}
