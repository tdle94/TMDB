//
//  HomeMultipleSection.swift
//  TMDB
//
//  Created by Tuyen Le on 11/28/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Differentiator
import RealmSwift

enum HomeModel {
    case Popular(items: [CustomElementType])
    case Trending(items: [CustomElementType])
    case Movie(items: [CustomElementType])
    case TVShow(items: [CustomElementType])
}

struct CustomElementType: IdentifiableType, Hashable {
    var identity: Object
    
    typealias Identity = Object
    
    static func == (lhs: CustomElementType, rhs: CustomElementType) -> Bool {
        return rhs.identity.isSameObject(as: lhs.identity)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identity)
    }
    
}

extension HomeModel: AnimatableSectionModelType {
    typealias Item = CustomElementType
    
    typealias Identity = Int
    
    var identity: Int {
        switch self {
        case .Popular(items: let items):
            return items.hashValue
        case .Trending(items: let items):
            return items.hashValue
        case .Movie(items: let items):
            return items.hashValue
        case .TVShow(items: let items):
            return items.hashValue
        }
    }
    
    var items: [CustomElementType] {
        switch self {
        case .Popular(items: let items):
            return items
        case .Trending(items: let items):
            return items
        case .Movie(items: let items):
            return items
        case .TVShow(items: let items):
            return items
        }
    }
    
    init(original: HomeModel, items: [CustomElementType]) {
        switch original {
        case .Popular(items: _):
            self = .Popular(items: items)
        case .Trending(items: _):
            self = .Trending(items: items)
        case .Movie(items: let items):
            self = .Movie(items: items)
        case .TVShow(items: let items):
            self = .TVShow(items: items)
        }
    }
}
