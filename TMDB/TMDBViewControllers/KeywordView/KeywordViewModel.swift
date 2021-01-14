//
//  KeywordViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/10/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RxSwift

protocol ApplyKeyword: class {
    func apply(newKeywords: [Keyword])
}

protocol KeywordViewModelProtocol: ApplyKeyword {
    var query: DiscoverQuery? { get set }
    var keywords: BehaviorSubject<[Keyword]> { get }
    
    func handle(keyword: Keyword, isSelected: Bool)
    func isThere(keyword: Keyword, at: Int) -> Bool
}

class KeywordViewModel: KeywordViewModelProtocol {
    var query: DiscoverQuery? {
        willSet {
            guard query == nil else {
                return
            }
            
            var previousKeywords = try! keywords.value()

            for keyword in newValue?.keywords ?? [] where !previousKeywords.contains(where: { $0 == keyword })  {
                previousKeywords.append(keyword)
            }

            keywords.onNext(previousKeywords)
        }
    }

    var keywords: BehaviorSubject<[Keyword]> = BehaviorSubject(value: [
        Keyword(name: "action hero", id: 219404), Keyword(name: "alternate history", id: 12026),
        Keyword(name: "ambiguous ending", id: 256055), Keyword(name: "americana", id: 165508),
        Keyword(name: "anime", id: 210024), Keyword(name: "anti hero", id: 2095),
        Keyword(name: "avant-garde", id: 15216), Keyword(name: "b movie", id: 11034),
        Keyword(name: "bank heist", id: 191845), Keyword(name: "based on novel", id: 274858)
    ])
    
    func handle(keyword: Keyword, isSelected: Bool) {
        guard self.query?.keywords.isNotEmpty ?? false else {
            query?.keywords.append(keyword)
            return
        }

        if isSelected {
            query?.keywords.append(keyword)
        } else {
            query?.keywords.removeAll(where: { $0 == keyword })
        }
    }
    
    func apply(newKeywords: [Keyword]) {
        var currentKeywords = try! keywords.value()

        if query?.keywords.isEmpty ?? false {
            query?.keywords = newKeywords
            currentKeywords.append(contentsOf: newKeywords)
        } else {
            let filterNewKeywords = newKeywords.filter { keyword in
                return !currentKeywords.contains(where: { $0 == keyword })
            }

            query?.keywords.append(contentsOf: filterNewKeywords)
            currentKeywords.append(contentsOf: filterNewKeywords)
        }
        
        keywords.onNext(currentKeywords)
    }
    
    func isThere(keyword: Keyword, at: Int) -> Bool {
        return query?.keywords.contains(where: { $0 == keyword }) ?? false
    }
}
