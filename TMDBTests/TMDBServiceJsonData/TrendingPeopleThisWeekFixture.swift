//
//  TrendingPeopleThisWeekFixture.swift
//  TMDBTests
//
//  Created by Tuyen Le on 12.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

let trendingPeopleThisWeekFixture = Data("""
    {
      "page": 1,
      "results": [
        {
          "known_for_department": "Acting",
          "adult": false,
          "id": 287,
          "profile_path": "/tJiSUYst4ddIaz1zge2LqCtu9tw.jpg",
          "name": "Brad Pitt",
          "known_for": [
            {
              "poster_path": "/bptfVGEQuv6vDTIMVCHjJ9Dz8PX.jpg",
              "popularity": 34.693,
              "vote_count": 19370,
              "video": false,
              "media_type": "movie",
              "id": 550,
              "adult": false,
              "backdrop_path": "/8iVyhmjzUbvAGppkdCZPiyEHSoF.jpg",
              "original_language": "en",
              "original_title": "Fight Club",
              "genre_ids": [
                18
              ],
              "title": "Fight Club",
              "vote_average": 8.4,
              "overview": "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \\"fight clubs\\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
              "release_date": "1999-10-15"
            },
            {
              "poster_path": "/7sfbEnaARXDDhKm0CZ7D7uc2sbo.jpg",
              "popularity": 32.049,
              "vote_count": 14827,
              "video": false,
              "media_type": "movie",
              "id": 16869,
              "adult": false,
              "backdrop_path": "/8pEnePgGyfUqj8Qa6d91OZQ6Aih.jpg",
              "original_language": "en",
              "original_title": "Inglourious Basterds",
              "genre_ids": [
                28,
                18,
                53,
                10752
              ],
              "title": "Inglourious Basterds",
              "vote_average": 8.2,
              "overview": "In Nazi-occupied France during World War II, a group of Jewish-American soldiers known as \\"The Basterds\\" are chosen specifically to spread fear throughout the Third Reich by scalping and brutally killing Nazis. The Basterds, lead by Lt. Aldo Raine soon cross paths with a French-Jewish teenage girl who runs a movie theater in Paris which is targeted by the soldiers.",
              "release_date": "2009-08-18"
            },
            {
              "poster_path": "/6yoghtyTpznpBik8EngEmJskVUO.jpg",
              "popularity": 46.953,
              "vote_count": 13154,
              "video": false,
              "media_type": "movie",
              "id": 807,
              "adult": false,
              "backdrop_path": "/4U4q1zjIwCZTNkp6RKWkWPuC7uI.jpg",
              "original_language": "en",
              "original_title": "Se7en",
              "genre_ids": [
                80,
                9648,
                53
              ],
              "title": "Se7en",
              "vote_average": 8.3,
              "overview": "Two homicide detectives are on a desperate hunt for a serial killer whose crimes are based on the \\"seven deadly sins\\" in this dark and haunting film that takes viewers from the tortured remains of one victim to the next. The seasoned Det. Sommerset researches each sin in an effort to get inside the killer's mind, while his novice partner, Mills, scoffs at his efforts to unravel the case.",
              "release_date": "1995-09-22"
            }
          ],
          "gender": 2,
          "popularity": 23.428,
          "media_type": "person"
        }
      ],
      "total_pages": 1000,
      "total_results": 20000
    }
    """.utf8)
