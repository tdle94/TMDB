//
//  MovieDetailFixture.swift
//  TMDBTests
//
//  Created by Tuyen Le on 12.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

let movieDetailFixtureWithVideo = Data("""
    {
    "adult": false,
    "backdrop_path": "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg",
    "belongs_to_collection": null,
    "budget": 87500000,
    "genres": [
    {
      "id": 878,
      "name": "Science Fiction"
    },
    {
      "id": 18,
      "name": "Drama"
    }
    ],
    "homepage": "https://www.foxmovies.com/movies/ad-astra",
    "id": 419704,
    "imdb_id": "tt2935510",
    "original_language": "en",
    "original_title": "Ad Astra",
    "overview": "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.",
    "popularity": 207.629,
    "poster_path": "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
    "production_companies": [
    {
      "id": 490,
      "logo_path": null,
      "name": "New Regency Productions",
      "origin_country": "US"
    },
    {
      "id": 79963,
      "logo_path": null,
      "name": "Keep Your Head",
      "origin_country": ""
    },
    {
      "id": 73492,
      "logo_path": null,
      "name": "MadRiver Pictures",
      "origin_country": ""
    },
    {
      "id": 81,
      "logo_path": "/8wOfUhA7vwU2gbPjQy7Vv3EiF0o.png",
      "name": "Plan B Entertainment",
      "origin_country": "US"
    },
    {
      "id": 30666,
      "logo_path": "/g8LmDZVFWDRJW72sj0nAj1gh8ac.png",
      "name": "RT Features",
      "origin_country": "BR"
    },
    {
      "id": 30148,
      "logo_path": "/zerhOenUD6CkH8SMgZUhrDkOs4w.png",
      "name": "Bona Film Group",
      "origin_country": "CN"
    },
    {
      "id": 22213,
      "logo_path": "/qx9K6bFWJupwde0xQDwOvXkOaL8.png",
      "name": "TSG Entertainment",
      "origin_country": "US"
    }
    ],
    "production_countries": [
    {
      "iso_3166_1": "BR",
      "name": "Brazil"
    },
    {
      "iso_3166_1": "CN",
      "name": "China"
    },
    {
      "iso_3166_1": "US",
      "name": "United States of America"
    }
    ],
    "release_date": "2019-09-17",
    "revenue": 132807427,
    "runtime": 123,
    "spoken_languages": [
    {
      "iso_639_1": "en",
      "name": "English"
    },
    {
      "iso_639_1": "no",
      "name": "Norsk"
    }
    ],
    "status": "Released",
    "tagline": "The answers we seek are just outside our reach",
    "title": "Ad Astra",
    "video": false,
    "vote_average": 6.1,
    "vote_count": 3821,
    "videos": {
    "results": [
      {
        "id": "5cf81bfb92514153b7b9e733",
        "iso_639_1": "en",
        "iso_3166_1": "US",
        "key": "P6AaSMfXHbA",
        "name": "Official Trailer #1",
        "site": "YouTube",
        "size": 1080,
        "type": "Trailer"
      },
      {
        "id": "5d313d7c326c1900101eba51",
        "iso_639_1": "en",
        "iso_3166_1": "US",
        "key": "nxi6rtBtBM0",
        "name": "Official Trailer #2",
        "site": "YouTube",
        "size": 2160,
        "type": "Trailer"
      },
      {
        "id": "5d894d8a79b3d4001f832e8d",
        "iso_639_1": "en",
        "iso_3166_1": "US",
        "key": "t6g0dsQzfqY",
        "name": "Official Trailer #3",
        "site": "YouTube",
        "size": 1080,
        "type": "Trailer"
      },
      {
        "id": "5d894d21d9f4a6000e4dc169",
        "iso_639_1": "en",
        "iso_3166_1": "US",
        "key": "stOVFXuyyWQ",
        "name": "Moon Rover",
        "site": "YouTube",
        "size": 1080,
        "type": "Clip"
      },
      {
        "id": "5d894d5179b3d4002782dd61",
        "iso_639_1": "en",
        "iso_3166_1": "US",
        "key": "Nvb9cDDFHtk",
        "name": "Lima Project",
        "site": "YouTube",
        "size": 1080,
        "type": "Clip"
      },
      {
        "id": "5d894d5cd9f4a600204da4ea",
        "iso_639_1": "en",
        "iso_3166_1": "US",
        "key": "ykC_wu6ffOU",
        "name": "Antenna",
        "site": "YouTube",
        "size": 1080,
        "type": "Clip"
      }
    ]
    }
    }
    """.utf8)

let movieDetailFixture1 = Data("""
    {
    "adult": false,
    "backdrop_path": "/bVmSXNgH1gpHYTDyF9Q826YwJT5.jpg",
    "belongs_to_collection": {
    "id": 121938,
    "name": "The Hobbit Collection",
    "poster_path": "/hQghXOjSS2xfzx9XnMyZqt8brCF.jpg",
    "backdrop_path": "/7wO7MSnP5UcwR2cTHdJFF1vP4Ie.jpg"
    },
    "budget": 250000000,
    "genres": [
    {
      "id": 28,
      "name": "Action"
    },
    {
      "id": 12,
      "name": "Adventure"
    },
    {
      "id": 14,
      "name": "Fantasy"
    }
    ],
    "homepage": "https://www.warnerbros.com/movies/hobbit-battle-five-armies/",
    "id": 122917,
    "imdb_id": "tt2310332",
    "original_language": "en",
    "original_title": "The Hobbit: The Battle of the Five Armies",
    "overview": "Immediately after the events of The Desolation of Smaug, Bilbo and the dwarves try to defend Erebor's mountain of treasure from others who claim it: the men of the ruined Laketown and the elves of Mirkwood. Meanwhile an army of Orcs led by Azog the Defiler is marching on Erebor, fueled by the rise of the dark lord Sauron. Dwarves, elves and men must unite, and the hope for Middle-Earth falls into Bilbo's hands.",
    "popularity": 77.457,
    "poster_path": "/xT98tLqatZPQApyRmlPL12LtiWp.jpg",
    "production_companies": [
    {
      "id": 174,
      "logo_path": "/IuAlhI9eVC9Z8UQWOIDdWRKSEJ.png",
      "name": "Warner Bros. Pictures",
      "origin_country": "US"
    },
    {
      "id": 11,
      "logo_path": "/6FAuASQHybRkZUk08p9PzSs9ezM.png",
      "name": "WingNut Films",
      "origin_country": "NZ"
    },
    {
      "id": 12,
      "logo_path": "/iaYpEp3LQmb8AfAtmTvpqd4149c.png",
      "name": "New Line Cinema",
      "origin_country": "US"
    },
    {
      "id": 7413,
      "logo_path": null,
      "name": "3Foot7",
      "origin_country": "NZ"
    },
    {
      "id": 21,
      "logo_path": "/mjofSXiHpG5t6KYmU4l4FrUhT7m.png",
      "name": "Metro-Goldwyn-Mayer",
      "origin_country": "US"
    }
    ],
    "production_countries": [
    {
      "iso_3166_1": "NZ",
      "name": "New Zealand"
    },
    {
      "iso_3166_1": "US",
      "name": "United States of America"
    }
    ],
    "release_date": "2014-12-10",
    "revenue": 956019788,
    "runtime": 144,
    "spoken_languages": [
    {
      "iso_639_1": "en",
      "name": "English"
    }
    ],
    "status": "Released",
    "tagline": "Witness the defining chapter of the Middle-Earth saga",
    "title": "The Hobbit: The Battle of the Five Armies",
    "video": false,
    "vote_average": 7.3,
    "vote_count": 9939
    }
    """.utf8)

let movieDetailFixture = Data("""
    {
      "adult": false,
      "backdrop_path": "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
      "belongs_to_collection": null,
      "budget": 63000000,
      "genres": [
        {
          "id": 18,
          "name": "Drama"
        }
      ],
      "homepage": "",
      "id": 550,
      "imdb_id": "tt0137523",
      "original_language": "en",
      "original_title": "Fight Club",
      "overview": "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \\"fight clubs\\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
      "poster_path": null,
      "production_companies": [
        {
          "id": 508,
          "logo_path": "/7PzJdsLGlR7oW4J0J5Xcd0pHGRg.png",
          "name": "Regency Enterprises",
          "origin_country": "US"
        },
        {
          "id": 711,
          "logo_path": null,
          "name": "Fox 2000 Pictures",
          "origin_country": ""
        },
        {
          "id": 20555,
          "logo_path": null,
          "name": "Taurus Film",
          "origin_country": ""
        },
        {
          "id": 54050,
          "logo_path": null,
          "name": "Linson Films",
          "origin_country": ""
        },
        {
          "id": 54051,
          "logo_path": null,
          "name": "Atman Entertainment",
          "origin_country": ""
        },
        {
          "id": 54052,
          "logo_path": null,
          "name": "Knickerbocker Films",
          "origin_country": ""
        },
        {
          "id": 25,
          "logo_path": "/qZCc1lty5FzX30aOCVRBLzaVmcp.png",
          "name": "20th Century Fox",
          "origin_country": "US"
        }
      ],
      "production_countries": [
        {
          "iso_3166_1": "US",
          "name": "United States of America"
        }
      ],
      "release_date": "1999-10-12",
      "revenue": 100853753,
      "runtime": 139,
      "spoken_languages": [
        {
          "iso_639_1": "en",
          "name": "English"
        }
      ],
      "status": "Released",
      "tagline": "How much can you know about yourself if you've never been in a fight",
      "title": "Fight Club",
      "video": false,
      "vote_average": 7.8,
      "vote_count": 3439
    }
""".utf8)
