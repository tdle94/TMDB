//
//  ImageConfig.swift
//  TMDB
//
//  Created by Tuyen Le on 6/16/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import RealmSwift

struct ImageConfigResult {
    let id: Int = 0
    var images: ImageConfig = ImageConfig()
    var changeKeys: [String] = [
      "adult",
      "air_date",
      "also_known_as",
      "alternative_titles",
      "biography",
      "birthday",
      "budget",
      "cast",
      "certifications",
      "character_names",
      "created_by",
      "crew",
      "deathday",
      "episode",
      "episode_number",
      "episode_run_time",
      "freebase_id",
      "freebase_mid",
      "general",
      "genres",
      "guest_stars",
      "homepage",
      "images",
      "imdb_id",
      "languages",
      "name",
      "network",
      "origin_country",
      "original_name",
      "original_title",
      "overview",
      "parts",
      "place_of_birth",
      "plot_keywords",
      "production_code",
      "production_companies",
      "production_countries",
      "releases",
      "revenue",
      "runtime",
      "season",
      "season_number",
      "season_regular",
      "spoken_languages",
      "status",
      "tagline",
      "title",
      "translations",
      "tvdb_id",
      "tvrage_id",
      "type",
      "video",
      "videos"
    ]
}

struct ImageConfig {
    var baseURL: String = "http://image.tmdb.org/t/p/"
    var secureBaseURL: String = "https://image.tmdb.org/t/p/"
    var backdropSizes: [String] = [
      "w300",
      "w780",
      "w1280",
      "original"
    ]
    var logoSizes: [String] = [
      "w45",
      "w92",
      "w154",
      "w185",
      "w300",
      "w500",
      "original"
    ]
    var posterSizes: [String] = [
      "w92",
      "w154",
      "w185",
      "w342",
      "w500",
      "w780",
      "original"
    ]
    var profileSizes: [String] = [
      "w45",
      "w185",
      "h632",
      "original"
    ]
    var stillSizes: [String] = [
      "w92",
      "w185",
      "w300",
      "original"
    ]
}
