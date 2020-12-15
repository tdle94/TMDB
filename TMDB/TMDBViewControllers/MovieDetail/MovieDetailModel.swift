//
//  MovieDetailModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/10/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RealmSwift
import RxDataSources

enum MovieDetailModel {
    case Credits(items: [CustomElementType])
    case MoviesLikeThis(items: [CustomElementType])
}

extension MovieDetailModel: AnimatableSectionModelType {
    typealias Item = CustomElementType
    
    typealias Identity = Int
    
    var identity: Int {
        switch self {
        case .Credits(items: let items):
            return items.hashValue
        case .MoviesLikeThis(items: let items):
            return items.hashValue
        }
    }
        
    var items: [CustomElementType] {
        switch self {
        case .Credits(items: let items):
            return items
        case .MoviesLikeThis(items: let items):
            return items
        }
    }
        
    init(original: MovieDetailModel, items: [CustomElementType]) {
        switch original {
        case .Credits(items: let items):
            self = .Credits(items: items)
        case .MoviesLikeThis(items: let items):
            self = .MoviesLikeThis(items: items)
        }
    }
}




