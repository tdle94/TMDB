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
        static let popularHeader = "PreviewHeader"
        static let trendHeader = "TrendHeader"
        static let additionalHeader = "AdditionalHeader"
        static let creditMovieHeader = "CreditMovieHeader"
        static let creatorTVShowHeader = "CreatorTVShowHeader"
        static let personImageHeader = "PersonImageHeader"
        static let videoMovieHeader = "VideoMovieHeader"
        static let movieProduceByHeader = "ProduceByHeader"
        static let preview = "Preview"
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
    }
    struct Color {
        static let primaryColor = UIColor(displayP3Red: 13/255, green: 37/255, blue: 63/255, alpha: 1)
        static let secondaryColor = UIColor(displayP3Red: 1/255, green: 180/255, blue: 228/255, alpha: 1)
        static let tertiaryColor = UIColor(displayP3Red: 144/255, green: 206/255, blue:  161/255, alpha: 1)
        static let backgroundColor = UIColor(displayP3Red: 235/255, green: 235/255, blue:  240/255, alpha: 1)
        static let tabBarSelectedTextColor = UIColor(displayP3Red: 231/255, green: 232/255, blue:  238/255, alpha: 1)
    }
    struct UserSetting {
        static let language = "language"
        static let region = "region"
        static let country = "country"
        static let imageConfig = "image config"
    }
    static let imageLogo = "TMDB"
}
