//
//  FilterViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/8/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//
import Foundation
import RxSwift

protocol FilterViewModelProtocol: ApplyProtocol {
    var userSetting: TMDBUserSettingProtocol { get }
    var selectedCountry: String { get }
    var selectdLanguage: String { get }
    var selectedYear: String { get }
    var selectedKeywordCount: String { get }
    var genres: [Genre] { get }
    var notifyUIChange: PublishSubject<Void> { get }

    func selectSortByAt(row: Int, section: Int)
    func deselectSortByAt()
    
    func handleGenre(id: Int, isSelected: Bool)
}

class FilterViewModel: FilterViewModelProtocol {

    var userSetting: TMDBUserSettingProtocol
    
    var query: DiscoverQuery?
    
    var notifyUIChange: PublishSubject<Void> = PublishSubject()
    
    var genres: [Genre] {
        return query?.filterType == .movie ? userSetting.movieGenres : userSetting.tvShowGenres
    }
    
    var selectedCountry: String {
        return userSetting.countriesCode.first(where: { $0.iso31661 == query?.region })?.name ?? NSLocalizedString("Any", comment: "")
    }
    
    var selectdLanguage: String {
        return userSetting.languagesCode.first(where: { $0.iso6391 == query?.withOriginalLanguage })?.name ?? NSLocalizedString("Any", comment: "")
    }
    
    var selectedKeywordCount: String {
        if let count = query?.keywords.count, count > 0 {
            return String(count)
        }
        return NSLocalizedString("Any", comment: "")
    }
    
    var selectedYear: String {
        if let year = query?.primaryReleaseYear {
            return String(year)
        }
        return NSLocalizedString("Any", comment: "")
    }
    
    private var selectedGenreId: [Int] = []
    
    init(userSetting: TMDBUserSettingProtocol) {
        self.userSetting = userSetting
    }
    
    func selectSortByAt(row: Int, section: Int) {
        if section == 0 {
            if row == 0 {
                query?.sortBy = .popularity(order: .ascending)
            } else {
                query?.sortBy = .popularity(order: .descending)
            }
        } else if section == 1 {
            if row == 0 {
                query?.sortBy = .voteAverage(order: .ascending)
            } else {
                query?.sortBy = .voteAverage(order: .descending)
            }
        } else if section == 2 {
            if row == 0 {
                query?.sortBy = .voteCount(order: .ascending)
            } else {
                query?.sortBy = .voteCount(order: .descending)
            }
        }
    }
    
    func deselectSortByAt() {
        query?.sortBy = .none
    }
    
    func handleGenre(id: Int, isSelected: Bool) {
        guard var genres = query?.withGenres else {
            query?.withGenres = "\(id)"
            return
        }

        if isSelected {
            genres += ",\(id)"
            query?.withGenres = genres
        } else {
            var modifiedGenres = genres.components(separatedBy: ",")
            modifiedGenres.removeAll(where: { $0 == String(id) })
            query?.withGenres = modifiedGenres.joined(separator: ",")
        }

        if query?.withGenres?.isEmpty ?? false {
            query?.withGenres = nil
        }
    }
    
    func apply(query: DiscoverQuery?) {
        if self.query != query {
            self.query = query
            notifyUIChange.onNext(())
        }
    }
}
