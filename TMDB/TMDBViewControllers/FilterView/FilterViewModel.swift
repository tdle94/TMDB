//
//  FilterViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/8/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

protocol FilterViewModelProtocol {
    var applyFilterQuery: DiscoverQuery { get set }
    var userSetting: TMDBUserSettingProtocol { get }

    func selectSortByAt(row: Int, section: Int)
    func deselectSortByAt()
    
    func handleGenre(id: Int, isSelected: Bool)
}

class FilterViewModel: FilterViewModelProtocol {
    var userSetting: TMDBUserSettingProtocol
    
    var applyFilterQuery: DiscoverQuery = DiscoverQuery() {
        didSet {
            if let genres = applyFilterQuery.withGenres, selectedGenreId.isEmpty, genres.isNotEmpty {
                selectedGenreId = genres.components(separatedBy: ",").map { Int($0)! }
            }
        }
    }
    
    private var selectedGenreId: [Int] = []
    
    init(userSetting: TMDBUserSettingProtocol) {
        self.userSetting = userSetting
    }
    
    func selectSortByAt(row: Int, section: Int) {
        if section == 0 {
            if row == 0 {
                applyFilterQuery.sortBy = .popularity(order: .ascending)
            } else {
                applyFilterQuery.sortBy = .popularity(order: .descending)
            }
        } else if section == 1 {
            if row == 0 {
                applyFilterQuery.sortBy = .voteAverage(order: .ascending)
            } else {
                applyFilterQuery.sortBy = .voteAverage(order: .descending)
            }
        } else if section == 2 {
            if row == 0 {
                applyFilterQuery.sortBy = .voteCount(order: .ascending)
            } else {
                applyFilterQuery.sortBy = .voteCount(order: .descending)
            }
        }
    }
    
    func deselectSortByAt() {
        applyFilterQuery.sortBy = .none
    }
    
    func handleGenre(id: Int, isSelected: Bool) {
        if applyFilterQuery.withGenres == nil {
            applyFilterQuery.withGenres = ""
        }

        if isSelected {
            selectedGenreId.append(id)
        } else {
            selectedGenreId.removeAll(where: { $0 == id })
        }
        
        applyFilterQuery.withGenres = selectedGenreId.map { String($0) }.joined(separator: ",")

        if applyFilterQuery.withGenres?.isEmpty ?? false {
            applyFilterQuery.withGenres = nil
        }
    }
}
