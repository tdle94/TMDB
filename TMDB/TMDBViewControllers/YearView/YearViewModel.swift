//
//  YearViewModel.swift
//  TMDB
//
//  Created by Tuyen Le on 1/11/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//
import UIKit

protocol YearViewModelProtocol {
    var query: DiscoverQuery? { get set }
    var years: [String] { get }
    var selectedIndexPath: IndexPath? { get set }
    var selectedYear: String? { get set }
    
    func handleSelect(at: Int, isSelected: Bool)
}

class YearViewModel: YearViewModelProtocol {
    var query: DiscoverQuery?
    
    var selectedIndexPath: IndexPath?

    var selectedYear: String?
    
    var years: [String] = [
        "1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963",
        "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977",
        "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991",
        "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005",
        "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019",
        "2020", "2021", "2022"
    ]
    
    func handleSelect(at: Int, isSelected: Bool) {
        if isSelected {
            selectedIndexPath = IndexPath(row: at, section: 0)
            selectedYear = years[at]
            query?.primaryReleaseYear = Int(years[at])
        } else {
            selectedIndexPath = nil
            selectedYear = nil
            query?.primaryReleaseYear = nil
        }
    }
}
