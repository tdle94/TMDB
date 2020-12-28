//
//  PersonDetailModel.swift
//  TMDB
//
//  Created by Tuyen Le on 12/26/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import RealmSwift
import RxDataSources

enum PersonDetailModel {
    case Credits(items: [CustomElementType])
}

extension PersonDetailModel: AnimatableSectionModelType {
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
        
    init(original: PersonDetailModel, items: [CustomElementType]) {
        switch original {
        case .Credits(items: let items):
            self = .Credits(items: items)
        }
    }
}

