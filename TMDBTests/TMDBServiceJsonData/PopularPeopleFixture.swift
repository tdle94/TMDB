//
//  PopularPeopleFixture.swift
//  TMDBTests
//
//  Created by Tuyen Le on 12.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

let popularPeopleFixture = Data("""
    {
      "page": 1,
      "results": [
        {
          "profile_path": "/z3sLuRKP7hQVrvSTsqdLjGSldwG.jpg",
          "adult": false,
          "id": 28782,
          "known_for": [
            {
              "poster_path": "/hE24GYddaxB9MVZl1CaiI86M3kp.jpg",
              "adult": false,
              "overview": "A cryptic message from Bond’s past sends him on a trail to uncover a sinister organization. While M battles political forces to keep the secret service alive, Bond peels back the layers of deceit to reveal the terrible truth behind SPECTRE.",
              "release_date": "2015-10-26",
              "original_title": "Spectre",
              "genre_ids": [
                28,
                12,
                80
              ],
              "id": 206647,
              "media_type": "movie",
              "original_language": "en",
              "title": "Spectre",
              "backdrop_path": "/wVTYlkKPKrljJfugXN7UlLNjtuJ.jpg",
              "popularity": 7.090211,
              "vote_count": 2956,
              "video": false,
              "vote_average": 6.2
            },
            {
              "poster_path": "/ezIurBz2fdUc68d98Fp9dRf5ihv.jpg",
              "adult": false,
              "overview": "Six months after the events depicted in The Matrix, Neo has proved to be a good omen for the free humans, as more and more humans are being freed from the matrix and brought to Zion, the one and only stronghold of the Resistance. Neo himself has discovered his superpowers including super speed, ability to see the codes of the things inside the matrix and a certain degree of pre-cognition. But a nasty piece of news hits the human resistance: 250,000 machine sentinels are digging to Zion and would reach them in 72 hours. As Zion prepares for the ultimate war, Neo, Morpheus and Trinity are advised by the Oracle to find the Keymaker who would help them reach the Source. Meanwhile Neo's recurrent dreams depicting Trinity's death have got him worried and as if it was not enough, Agent Smith has somehow escaped deletion, has become more powerful than before and has fixed Neo as his next target.",
              "release_date": "2003-05-15",
              "original_title": "The Matrix Reloaded",
              "genre_ids": [
                12,
                28,
                53,
                878
              ],
              "id": 604,
              "media_type": "movie",
              "original_language": "en",
              "title": "The Matrix Reloaded",
              "backdrop_path": "/1jgulSytTJcATkGX8syGbD2glXD.jpg",
              "popularity": 3.41123,
              "vote_count": 2187,
              "video": false,
              "vote_average": 6.57
            },
            {
              "poster_path": "/sKogjhfs5q3azmpW7DFKKAeLEG8.jpg",
              "adult": false,
              "overview": "The human city of Zion defends itself against the massive invasion of the machines as Neo fights to end the war at another front while also opposing the rogue Agent Smith.",
              "release_date": "2003-11-05",
              "original_title": "The Matrix Revolutions",
              "genre_ids": [
                12,
                28,
                53,
                878
              ],
              "id": 605,
              "media_type": "movie",
              "original_language": "en",
              "title": "The Matrix Revolutions",
              "backdrop_path": "/pdVHUsb2eEz9ALNTr6wfRJe5xVa.jpg",
              "popularity": 3.043018,
              "vote_count": 1971,
              "video": false,
              "vote_average": 6.35
            }
          ],
          "name": "Monica Bellucci",
          "popularity": 48.609344
        }
      ],
      "total_results": 19671,
      "total_pages": 984
    }
    """.utf8)
