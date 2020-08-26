//
//  Constant.swift
//  TMDB
//
//  Created by Tuyen Le on 6/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    struct Identifier {
        static let previewFooter = "PreviewFooter"
        static let popularPreviewHeader = "PreviewHeader"
        static let trendPreviewHeader = "TrendHeader"
        static let moviePreviewHeader = "MovieHeader"
        static let tvShowPreviewHeader = "TVShowHeader"
        static let previewHeader = "PreviewHeader"
        static let previewItem = "PreviewItem"
        static let reviewCell = "ReviewCell"
        static let keywordCell = "KeywordCell"
        static let countryCell = "CountryCell"
        static let languageCell = "LanguageCell"
        static let countrySearch = "CountrySearch"
        static let searchResultCell = "SearchResultCell"
        static let imageCell = "ImageCell"
        static let releaseDateCell = "ReleaseDateCell"
        static let tvShowSeasonCell = "TVShowSeasonCell"
        static let tvShowEpisodeCell = "TVShowEpisodeCell"
    }
    struct ViewControllerIdentifier {
        static let tmdbSearchResultViewController = "TMDBSearchResultViewController"
        static let tmdbSearchController = "TMDBCountrySearchResultController"
        static let tmdbCountry = "TMDBCountryViewController"
        static let tmdbHome = "TMDBHomeViewController"
        static let tmdbCountryNavigation = "TMDBCountrySettingNavigation"
        static let tmdbLanguageNavigation = "TMDBLanguageSettingNavigation"
        static let tmdbMovieDetail = "TMDBMovieDetailViewController"
        static let tmdbVideoPlayer = "TMDBVideoPlayerViewController"
        static let tmdbReviewVC = "TMDBReivewTableViewController"
        static let tmdbPersonDetailVC = "TMDBPersonDetailViewController"
        static let tmdbCompleteReleaseDateTableVC = "TMDBCompleteReleaseDateTableViewController"
        static let tmdbTVDetailVC = "TMDBTVDetailViewController"
        static let tmdbTVShowSeasonVC = "TMDBTVShowSeasonViewController"
        static let tmdbTVShowEpisodeVC = "TMDBTVShowEpisodeViewController"
        static let tmdbAllMovieVC = "TMDBAllMovieViewController"
        static let tmdbAllTVShowVC = "TMDBAllTVShowViewController"
        static let tmdbFilterNav = "TMDBFilterNavigation"
    }
    struct Color {
        static let primaryColor = UIColor(displayP3Red: 13/255, green: 37/255, blue: 63/255, alpha: 1)
        static let secondaryColor = UIColor(displayP3Red: 1/255, green: 180/255, blue: 228/255, alpha: 1)
        static let tertiaryColor = UIColor(displayP3Red: 144/255, green: 206/255, blue:  161/255, alpha: 1)
        static let backgroundColor = UIColor(displayP3Red: 235/255, green: 235/255, blue:  240/255, alpha: 1)
        static let tabBarSelectedTextColor = UIColor(displayP3Red: 231/255, green: 232/255, blue:  238/255, alpha: 1)
    }
    static let imageLogo = "TMDB"
}
