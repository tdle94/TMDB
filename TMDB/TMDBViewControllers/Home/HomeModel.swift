//
//  HomeMultipleSection.swift
//  TMDB
//
//  Created by Tuyen Le on 11/28/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Differentiator
import RealmSwift


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
