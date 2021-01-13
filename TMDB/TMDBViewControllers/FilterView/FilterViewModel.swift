//
//  FilterViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/8/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

protocol FilterViewModelProtocol {
    var applyFilterQuery: DiscoverQuery? { get set }
    var userSetting: TMDBUserSettingProtocol { get }
    var selectedCountry: String? { get }

    func selectSortByAt(row: Int, section: Int)
    func deselectSortByAt()
    
    func handleGenre(id: Int, isSelected: Bool)
}

class FilterViewModel: FilterViewModelProtocol {
    var userSetting: TMDBUserSettingProtocol
    
    var applyFilterQuery: DiscoverQuery?
    
    var selectedCountry: String? {
        return userSetting.countriesCode.first(where: { $0.iso31661 == applyFilterQuery?.region })?.name
    }
    
    private var selectedGenreId: [Int] = []
    
    init(userSetting: TMDBUserSettingProtocol) {
        self.userSetting = userSetting
    }
    
    func selectSortByAt(row: Int, section: Int) {
        if section == 0 {
            if row == 0 {
                applyFilterQuery?.sortBy = .popularity(order: .ascending)
            } else {
                applyFilterQuery?.sortBy = .popularity(order: .descending)
            }
        } else if section == 1 {
            if row == 0 {
                applyFilterQuery?.sortBy = .voteAverage(order: .ascending)
            } else {
                applyFilterQuery?.sortBy = .voteAverage(order: .descending)
            }
        } else if section == 2 {
            if row == 0 {
                applyFilterQuery?.sortBy = .voteCount(order: .ascending)
            } else {
                applyFilterQuery?.sortBy = .voteCount(order: .descending)
            }
        }
    }
    
    func deselectSortByAt() {
        applyFilterQuery?.sortBy = .none
    }
    
    func handleGenre(id: Int, isSelected: Bool) {
        guard var genres = applyFilterQuery?.withGenres else {
            applyFilterQuery?.withGenres = "\(id)"
            return
        }

        if isSelected {
            genres += ",\(id)"
            applyFilterQuery?.withGenres = genres
        } else {
            var modifiedGenres = genres.components(separatedBy: ",")
            modifiedGenres.removeAll(where: { $0 == String(id) })
            applyFilterQuery?.withGenres = modifiedGenres.joined(separator: ",")
        }

        if applyFilterQuery?.withGenres?.isEmpty ?? false {
            applyFilterQuery?.withGenres = nil
        }
    }
}
