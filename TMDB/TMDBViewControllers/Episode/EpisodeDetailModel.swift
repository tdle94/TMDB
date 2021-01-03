//
//  EpisodeDetailViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/2/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RealmSwift
import RxDataSources

enum EpisodeDetailModel {
    case Credits(items: [CustomElementType])
}

extension EpisodeDetailModel: AnimatableSectionModelType {
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
        
    init(original: EpisodeDetailModel, items: [CustomElementType]) {
        switch original {
        case .Credits(items: let items):
            self = .Credits(items: items)
        }
    }
}

