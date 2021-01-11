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
}

class KeywordViewModel: KeywordViewModelProtocol {
    var query: DiscoverQuery?

    var keywords: BehaviorSubject<[Keyword]> = BehaviorSubject(value: [
        Keyword(name: "action hero", id: 219404), Keyword(name: "alternate history", id: 12026),
        Keyword(name: "ambiguous ending", id: 256055), Keyword(name: "americana", id: 165508),
        Keyword(name: "anime", id: 210024), Keyword(name: "anti hero", id: 2095),
        Keyword(name: "avant-garde", id: 15216), Keyword(name: "b movie", id: 11034),
        Keyword(name: "bank heist", id: 191845), Keyword(name: "based on novel", id: 274858)
    ])
    
    func handle(keyword: Keyword, isSelected: Bool) {
        guard var withKeywords = self.query?.withKeyword else {
            self.query?.withKeyword = "\(keyword.id)"
            return
        }

        if isSelected {
            withKeywords += ",\(keyword.id)"
            query?.withKeyword = withKeywords
        } else {
            var modifyWithKeywords = withKeywords.components(separatedBy: ",")
            modifyWithKeywords.removeAll(where: { $0 == String(keyword.id) })
            query?.withKeyword = modifyWithKeywords.joined(separator: ",")
        }

        if query?.withKeyword?.isEmpty ?? false {
            query?.withKeyword = nil
        }
    }
    
    func apply(newKeywords: [Keyword]) {
        let stringKeywords = newKeywords.map { String($0.id) }.joined(separator: ",")
        
        if query?.withKeyword == nil {
            query?.withKeyword = stringKeywords
        } else {
            query?.withKeyword?.append(",\(stringKeywords)")
        }

        var previousKeywords = try! keywords.value()
        previousKeywords.append(contentsOf: newKeywords)
        
        keywords.onNext(previousKeywords)
    }
}
