//
//  MovieDetailFixture.swift
//  TMDBTests
//
//  Created by Tuyen Le on 12.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

let movieDetailFixtureWithReleaseDates = Data("""
    {
      "adult": false,
      "backdrop_path": "/jMmHFm0TcjiN9QDICXY2tJcQsDl.jpg",
      "belongs_to_collection": null,
      "budget": 0,
      "genres": [
        {
          "id": 18,
          "name": "Drama"
        },
        {
          "id": 35,
          "name": "Comedy"
        }
      ],
      "homepage": "",
      "id": 3,
      "imdb_id": "tt0092149",
      "original_language": "fi",
      "original_title": "Varjoja paratiisissa",
      "overview": "An episode in the life of Nikander, a garbage man, involving the death of a co-worker, an affair and much more.",
      "popularity": 10.195,
      "poster_path": "/nj01hspawPof0mJmlgfjuLyJuRN.jpg",
      "production_companies": [
        {
          "id": 2303,
          "logo_path": null,
          "name": "Villealfa Filmproductions",
          "origin_country": "FI"
        }
      ],
      "production_countries": [
        {
          "iso_3166_1": "FI",
          "name": "Finland"
        }
      ],
      "release_date": "1986-10-17",
      "revenue": 0,
      "runtime": 72,
      "spoken_languages": [
        {
          "iso_639_1": "en",
          "name": "English"
        },
        {
          "iso_639_1": "fi",
          "name": "suomi"
        },
        {
          "iso_639_1": "sv",
          "name": "svenska"
        }
      ],
      "status": "Released",
      "tagline": "",
      "title": "Shadows in Paradise",
      "video": false,
      "vote_average": 7.3,
      "vote_count": 113,
      "release_dates": {
        "results": [
          {
            "iso_3166_1": "NL",
            "release_dates": [
              {
                "certification": "",
                "iso_639_1": "",
                "note": "",
                "release_date": "1993-07-29T00:00:00.000Z",
                "type": 3
              }
            ]
          },
          {
            "iso_3166_1": "FI",
            "release_dates": [
              {
                "certification": "S",
                "iso_639_1": "",
                "note": "",
                "release_date": "1986-10-17T00:00:00.000Z",
                "type": 3
              }
            ]
          },
          {
            "iso_3166_1": "US",
            "release_dates": [
              {
                "certification": "",
                "iso_639_1": "",
                "note": "",
                "release_date": "1990-08-22T00:00:00.000Z",
                "type": 3
              }
            ]
          }
        ]
      }
    }
    """.utf8)

let movieDetailFixtureWithReview = Data("""
    {"adult":false,"backdrop_path":"/jMmHFm0TcjiN9QDICXY2tJcQsDl.jpg","belongs_to_collection":null,"budget":0,"genres":[{"id":18,"name":"Drama"},{"id":35,"name":"Comedy"}],"homepage":"","id":3,"imdb_id":"tt0092149","original_language":"fi","original_title":"Varjoja paratiisissa","overview":"An episode in the life of Nikander, a garbage man, involving the death of a co-worker, an affair and much more.","popularity":10.669,"poster_path":"/nj01hspawPof0mJmlgfjuLyJuRN.jpg","production_companies":[{"id":2303,"logo_path":null,"name":"Villealfa Filmproductions","origin_country":"FI"}],"production_countries":[{"iso_3166_1":"FI","name":"Finland"}],"release_date":"1986-10-17","revenue":0,"runtime":72,"spoken_languages":[{"iso_639_1":"en","name":"English"},{"iso_639_1":"fi","name":"suomi"},{"iso_639_1":"sv","name":"svenska"}],"status":"Released","tagline":"","title":"Shadows in Paradise","video":false,"vote_average":7.3,"vote_count":113,"reviews":{"page":1,"results":[{"author":"CRCulver","content":"it suck","id":"5b9180a7c3a3687adc005547","url":"https://www.themoviedb.org/review/5b9180a7c3a3687adc005547"}],"total_pages":1,"total_results":1}}
    """.utf8)

let movieDetailFixtureWithVideoKeywordSimilarRecommendationCredit = Data("""
    {
      "adult": false,
      "backdrop_path": "/jMmHFm0TcjiN9QDICXY2tJcQsDl.jpg",
      "belongs_to_collection": null,
      "budget": 0,
      "genres": [
        {
          "id": 18,
          "name": "Drama"
        },
        {
          "id": 35,
          "name": "Comedy"
        }
      ],
      "homepage": "",
      "id": 3,
      "imdb_id": "tt0092149",
      "original_language": "fi",
      "original_title": "Varjoja paratiisissa",
      "overview": "An episode in the life of Nikander, a garbage man, involving the death of a co-worker, an affair and much more.",
      "popularity": 7.621,
      "poster_path": "/nj01hspawPof0mJmlgfjuLyJuRN.jpg",
      "production_companies": [
        {
          "id": 2303,
          "logo_path": null,
          "name": "Villealfa Filmproductions",
          "origin_country": "FI"
        }
      ],
      "production_countries": [
        {
          "iso_3166_1": "FI",
          "name": "Finland"
        }
      ],
      "release_date": "1986-10-17",
      "revenue": 0,
      "runtime": 72,
      "spoken_languages": [
        {
          "iso_639_1": "en",
          "name": "English"
        },
        {
          "iso_639_1": "fi",
          "name": "suomi"
        },
        {
          "iso_639_1": "sv",
          "name": "svenska"
        }
      ],
      "status": "Released",
      "tagline": "",
      "title": "Shadows in Paradise",
      "video": false,
      "vote_average": 7.3,
      "vote_count": 113,
      "keywords": {
        "keywords": [
          {
            "id": 1361,
            "name": "salesclerk"
          },
          {
            "id": 1787,
            "name": "helsinki, finland"
          },
          {
            "id": 3700,
            "name": "garbage"
          }
        ]
      },
      "videos": {
        "results": [
          {
            "id": "5cc9967092514151ca0b4b11",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "bOYvq-Sj4Ls",
            "name": "Harri Marstio - Älä Kiiruhda [HQ]",
            "site": "YouTube",
            "size": 720,
            "type": "Clip"
          }
        ]
      },
      "similar": {
        "page": 1,
        "results": [
          {
            "id": 35,
            "video": false,
            "vote_count": 5549,
            "vote_average": 7,
            "title": "The Simpsons Movie",
            "release_date": "2007-07-26",
            "original_language": "en",
            "original_title": "The Simpsons Movie",
            "genre_ids": [
              16,
              35,
              10751
            ],
            "backdrop_path": "/o7XHctO2t4fIdzch8v8ApNaJMcX.jpg",
            "adult": false,
            "overview": "After Homer accidentally pollutes the town's water supply, Springfield is encased in a gigantic dome by the EPA and the Simpsons are declared fugitives.",
            "poster_path": "/a6bdbK0pctG3iGgAZg7EyOCmDod.jpg",
            "popularity": 18.755
          },
          {
            "id": 5516,
            "video": false,
            "vote_count": 971,
            "vote_average": 6.1,
            "title": "The Ladykillers",
            "release_date": "2004-03-25",
            "original_language": "en",
            "original_title": "The Ladykillers",
            "genre_ids": [
              35,
              80,
              53
            ],
            "backdrop_path": "/72WDz4czgJXmR6C9V0J6vCpsf1t.jpg",
            "adult": false,
            "overview": "An eccentric, if not charming Southern professor and his crew pose as a band in order to rob a casino, all under the nose of his unsuspecting landlord – a sharp old woman.",
            "poster_path": "/l4g9R39NCp6VaYFrw6q8JwKNW9x.jpg",
            "popularity": 11.617
          },
          {
            "adult": false,
            "backdrop_path": "/747dgDfL5d8esobk7h4odaOFhUq.jpg",
            "genre_ids": [
              80,
              18,
              53
            ],
            "id": 275,
            "original_language": "en",
            "original_title": "Fargo",
            "overview": "Jerry, a small-town Minnesota car salesman is bursting at the seams with debt... but he's got a plan. He's going to hire two thugs to kidnap his wife in a scheme to collect a hefty ransom from his wealthy father-in-law. It's going to be a snap and nobody's going to get hurt... until people start dying. Enter Police Chief Marge, a coffee-drinking, parka-wearing - and extremely pregnant - investigator who'll stop at nothing to get her man. And if you think her small-time investigative skills will give the crooks a run for their ransom... you betcha!",
            "poster_path": "/kKpORM0G7xDvJGQiXpQ0wUp9Dwo.jpg",
            "release_date": "1996-03-08",
            "title": "Fargo",
            "video": false,
            "vote_average": 7.9,
            "vote_count": 4816,
            "popularity": 19.582
          },
          {
            "id": 7518,
            "video": false,
            "vote_count": 2920,
            "vote_average": 6.4,
            "title": "Over the Hedge",
            "release_date": "2006-05-17",
            "original_language": "en",
            "original_title": "Over the Hedge",
            "genre_ids": [
              16,
              35,
              10751
            ],
            "backdrop_path": "/kmkmZIYAK1m2Q9ez03NJH6y7oNB.jpg",
            "adult": false,
            "overview": "A scheming raccoon fools a mismatched family of forest creatures into helping him repay a debt of food, by invading the new suburban sprawl that popped up while they were hibernating – and learns a lesson about family himself.",
            "poster_path": "/6qKM3Rl1tQgOFO1fMA7DAizWZ5n.jpg",
            "popularity": 19.581
          },
          {
            "adult": false,
            "backdrop_path": "/ySjsS30FZjb1yKNh26517dcSBXM.jpg",
            "genre_ids": [
              35
            ],
            "id": 2292,
            "original_language": "en",
            "original_title": "Clerks",
            "overview": "Convenience and video store clerks Dante and Randal are sharp-witted, potty-mouthed and bored out of their minds. So in between needling customers, the counter jockeys play hockey on the roof, visit a funeral home and deal with their love lives.",
            "poster_path": "/9IiSgiq4h4siTIS9H3o4nZ3h5L9.jpg",
            "release_date": "1994-09-13",
            "title": "Clerks",
            "video": false,
            "vote_average": 7.4,
            "vote_count": 1553,
            "popularity": 13.232
          },
          {
            "id": 399174,
            "video": false,
            "vote_count": 2886,
            "vote_average": 7.9,
            "title": "Isle of Dogs",
            "release_date": "2018-03-23",
            "original_language": "en",
            "original_title": "Isle of Dogs",
            "genre_ids": [
              12,
              16,
              35
            ],
            "backdrop_path": "/dkk1wFBDhPzLXPwVmHTRzny3rkX.jpg",
            "adult": false,
            "overview": "In the future, an outbreak of canine flu leads the mayor of a Japanese city to banish all dogs to an island that's a garbage dump. The outcasts must soon embark on an epic journey when a 12-year-old boy arrives on the island to find his beloved pet.",
            "poster_path": "/c0nUX6Q1ZB0P2t1Jo6EeFSVnOGQ.jpg",
            "popularity": 15.757
          },
          {
            "adult": false,
            "backdrop_path": "/an9BiFx8MFpvitloksYD50YHmfo.jpg",
            "genre_ids": [
              18,
              28,
              53,
              9648
            ],
            "id": 2087,
            "original_language": "en",
            "original_title": "The Getaway",
            "overview": "Doc McCoy is put in prison because his partners chickened out and flew off without him after exchanging a prisoner with a lot of money. Doc knows Jack Benyon, a rich \\"business\\"-man, is up to something big, so he tells his wife (Carol McCoy) to tell him that he's for sale if Benyon can get him out of prison. Benyon pulls some strings and Doc McCoy is released again. Unfortunately he has to cooperate with the same person that got him to prison.",
            "poster_path": "/4tWvZ4BQu3ICmtUL8lXHa9OgkoF.jpg",
            "release_date": "1994-02-11",
            "title": "The Getaway",
            "video": false,
            "vote_average": 5.5,
            "vote_count": 178,
            "popularity": 10.791
          },
          {
            "adult": false,
            "backdrop_path": "/3WhW4VDxCNd81tzYIm84vbi4koX.jpg",
            "genre_ids": [
              35,
              27,
              53
            ],
            "id": 11974,
            "original_language": "en",
            "original_title": "The 'Burbs",
            "overview": "When secretive new neighbors move in next door, suburbanite Ray Peterson and his friends let their paranoia get the best of them as they start to suspect the newcomers of evildoings and commence an investigation. But it's hardly how Ray, who much prefers drinking beer, reading his newspaper and watching a ball game on the tube expected to spend his vacation.",
            "poster_path": "/1oyRR8D5WiVHwunIkOMjl30Jdg5.jpg",
            "release_date": "1989-02-17",
            "title": "The 'Burbs",
            "video": false,
            "vote_average": 6.8,
            "vote_count": 689,
            "popularity": 10.902
          },
          {
            "id": 2,
            "video": false,
            "vote_count": 105,
            "vote_average": 6.8,
            "title": "Ariel",
            "release_date": "1988-10-21",
            "original_language": "fi",
            "original_title": "Ariel",
            "genre_ids": [
              35,
              80,
              18
            ],
            "backdrop_path": "/kpuTCMw3v2AuKjqGS7383uWbc8V.jpg",
            "adult": false,
            "overview": "Taisto Kasurinen is a Finnish coal miner whose father has just committed suicide and who is framed for a crime he did not commit. In jail, he starts to dream about leaving the country and starting a new life. He escapes from prison but things don't go as planned...",
            "poster_path": "/ojDg0PGvs6R9xYFodRct2kdI6wC.jpg",
            "popularity": 9.615
          },
          {
            "id": 10681,
            "video": false,
            "vote_count": 12993,
            "vote_average": 8,
            "title": "WALL·E",
            "release_date": "2008-06-22",
            "original_language": "en",
            "original_title": "WALL·E",
            "genre_ids": [
              16,
              878,
              10751
            ],
            "backdrop_path": "/ai2FicMUxLCurVkjtYdSvVDWRmS.jpg",
            "adult": false,
            "overview": "WALL·E is the last robot left on an Earth that has been overrun with garbage and all humans have fled to outer space. For 700 years he has continued to try and clean up the mess, but has developed some rather interesting human-like qualities. When a ship arrives with a sleek new type of robot, WALL·E thinks he's finally found a friend and stows away on the ship when it leaves.",
            "poster_path": "/3g8vyePqVatTaUSnrNnrrwguhxM.jpg",
            "popularity": 24.773
          },
          {
            "id": 21733,
            "video": false,
            "vote_count": 98,
            "vote_average": 7,
            "title": "Dragons Forever",
            "release_date": "1988-02-11",
            "original_language": "cn",
            "original_title": "飛龍猛將",
            "genre_ids": [
              28,
              35,
              10749
            ],
            "backdrop_path": "/5KwIMLRVOfwVmYId7IEkhF5vssp.jpg",
            "adult": false,
            "overview": "Jackie Chan stars as a hot-shot lawyer hired by a Hong Kong chemical plant to dispose of opposition to their polluting ways. But when he falls for a beautiful woman out to stop the plant, Jackie is torn in a conflict of interest and asks his trusty friends Samo and Biao to help out at least until they discover the true purpose of the plant.",
            "poster_path": "/wKwHhFRjJFjlBF9R6JAqfkAuJAJ.jpg",
            "popularity": 11.833
          },
          {
            "adult": false,
            "backdrop_path": "/wDjXuW3q41SGaUG643m5ssyod0S.jpg",
            "genre_ids": [
              35,
              18
            ],
            "id": 339,
            "original_language": "en",
            "original_title": "Night on Earth",
            "overview": "An anthology of 5 different cab drivers in 5 American and European cities and their remarkable fares on the same eventful night.",
            "poster_path": "/2bcWW7bNVBIwklxeBwnASR8NLzO.jpg",
            "release_date": "1991-12-12",
            "title": "Night on Earth",
            "video": false,
            "vote_average": 7.6,
            "vote_count": 442,
            "popularity": 12.264
          },
          {
            "id": 9713,
            "video": false,
            "vote_count": 242,
            "vote_average": 5.1,
            "title": "Holy Man",
            "release_date": "1998-10-08",
            "original_language": "en",
            "original_title": "Holy Man",
            "genre_ids": [
              35,
              18
            ],
            "backdrop_path": "/e45CObYN29s1ZXL9fT0IuRN7aB2.jpg",
            "adult": false,
            "overview": "Eddie Murphy stars as an over-the-top television evangelist who finds a way to turn television home shopping into a religious experience, and takes America by storm.",
            "poster_path": "/e3cGk3kQ1NLs0n4mMCPxhia66iD.jpg",
            "popularity": 8.726
          },
          {
            "id": 9794,
            "video": false,
            "vote_count": 367,
            "vote_average": 5.4,
            "title": "Employee of the Month",
            "release_date": "2006-10-06",
            "original_language": "en",
            "original_title": "Employee of the Month",
            "genre_ids": [
              35,
              10749
            ],
            "backdrop_path": "/fOSbp9p257ENUjCibCSQ1gsdpOT.jpg",
            "adult": false,
            "overview": "When he hears that the new female employee digs ambitious men who are the store employee of the month, a slacker gets his act together but finds himself in competition with his rival, an ambitious co-worker.",
            "poster_path": "/q6Q6cp5TKfZzpLqvFRL2mldtSTA.jpg",
            "popularity": 10.121
          },
          {
            "id": 10425,
            "video": false,
            "vote_count": 205,
            "vote_average": 6,
            "title": "The Death and Life of Bobby Z",
            "release_date": "2007-07-23",
            "original_language": "en",
            "original_title": "The Death and Life of Bobby Z",
            "genre_ids": [
              28,
              80,
              18,
              53
            ],
            "backdrop_path": "/b8pnblEGdMFIBOU6OsWlsLJalMn.jpg",
            "adult": false,
            "overview": "A DEA agent provides former Marine Tim Kearney with a way out of his prison sentence: impersonate Bobby Z, a recently deceased drug dealer, in a hostage switch with a crime lord. When the negotiations go awry, Kearney flees, with Z's son in tow.",
            "poster_path": "/yFwiPQ3OYljXlkGBEQL2XgFlP8h.jpg",
            "popularity": 11.99
          },
          {
            "id": 7294,
            "video": false,
            "vote_count": 154,
            "vote_average": 7.4,
            "title": "The Man Without a Past",
            "release_date": "2002-03-01",
            "original_language": "fi",
            "original_title": "Mies vailla menneisyyttä",
            "genre_ids": [
              35,
              18,
              10749
            ],
            "backdrop_path": "/nvzRMLQSYB1XYooexBr8Nqp5vcU.jpg",
            "adult": false,
            "overview": "The second part of Aki Kaurismäki's \\"Finland\\" trilogy, the film follows a man who arrives in Helsinki and gets beaten up so severely he develops amnesia. Unable to remember his name or anything from his past life, he cannot get a job or an apartment, so he starts living on the outskirts of the city and slowly starts putting his life back on track.",
            "poster_path": "/9tBepCujkyNg1qM52MsaJfDkIRw.jpg",
            "popularity": 7.23
          },
          {
            "adult": false,
            "backdrop_path": null,
            "genre_ids": [
              99
            ],
            "id": 46689,
            "original_language": "en",
            "original_title": "Waste Land",
            "overview": "An uplifting feature documentary highlighting the transformative power of art and the beauty of the human spirit. Top-selling contemporary artist Vik Muniz takes us on an emotional journey from Jardim Gramacho, the world's largest landfill on the outskirts of Rio de Janeiro, to the heights of international art stardom. Vik collaborates with the brilliant catadores, pickers of recyclable materials, true Shakespearean characters who live and work in the garbage quoting Machiavelli and showing us how to recycle ourselves.",
            "poster_path": "/wvaVhCRVPSYZp2A3utfyrPl0dNw.jpg",
            "release_date": "2010-01-24",
            "title": "Waste Land",
            "video": false,
            "vote_average": 7.8,
            "vote_count": 62,
            "popularity": 3.437
          },
          {
            "id": 339065,
            "video": false,
            "vote_count": 159,
            "vote_average": 7.8,
            "title": "The True Cost",
            "release_date": "2015-05-29",
            "original_language": "en",
            "original_title": "The True Cost",
            "genre_ids": [
              99
            ],
            "backdrop_path": "/lJBYqKoig6TbRVTuNpCocrtxrH9.jpg",
            "adult": false,
            "overview": "Film from Andrew Morgan.  The True Cost is a documentary film exploring the impact of fashion on people and the planet.",
            "poster_path": "/ql9HzESBhlNZowI0Tn2J1wYFmhv.jpg",
            "popularity": 8.779
          },
          {
            "id": 284470,
            "video": false,
            "vote_count": 147,
            "vote_average": 6.7,
            "title": "Atari: Game Over",
            "release_date": "2014-11-19",
            "original_language": "en",
            "original_title": "Atari: Game Over",
            "genre_ids": [
              99
            ],
            "backdrop_path": "/aLulOrEbBua5D5lsTlo3a204dih.jpg",
            "adult": false,
            "overview": "The Xbox Originals documentary that chronicles the fall of the Atari Corporation through the lens of one of the biggest mysteries of all time, dubbed “The Great Video Game Burial of 1983.” Rumor claims that millions of returned and unsold E.T. cartridges were buried in the desert, but what really happened there?",
            "poster_path": "/n6HJMlDs3jIiqFfiDSB3Bf784zo.jpg",
            "popularity": 9.878
          },
          {
            "id": 11129,
            "video": false,
            "vote_count": 186,
            "vote_average": 6.7,
            "title": "Human Traffic",
            "release_date": "1999-06-04",
            "original_language": "en",
            "original_title": "Human Traffic",
            "genre_ids": [
              35,
              18
            ],
            "backdrop_path": "/j1BWdnbzIJckxeOHlyzRNQCs5yZ.jpg",
            "adult": false,
            "overview": "Five twenty-something friends spend a drug-fueled weekend in Cardiff, Wales.",
            "poster_path": "/8JgsTybbrMGK39bFXDL1nJcreAK.jpg",
            "popularity": 7.559
          }
        ],
        "total_pages": 4,
        "total_results": 71
      },
      "recommendations": {
        "page": 1,
        "results": [
          {
            "id": 2,
            "video": false,
            "vote_count": 105,
            "vote_average": 6.8,
            "title": "Ariel",
            "release_date": "1988-10-21",
            "original_language": "fi",
            "original_title": "Ariel",
            "genre_ids": [
              35,
              80,
              18
            ],
            "backdrop_path": "/kpuTCMw3v2AuKjqGS7383uWbc8V.jpg",
            "adult": false,
            "overview": "Taisto Kasurinen is a Finnish coal miner whose father has just committed suicide and who is framed for a crime he did not commit. In jail, he starts to dream about leaving the country and starting a new life. He escapes from prison but things don't go as planned...",
            "poster_path": "/ojDg0PGvs6R9xYFodRct2kdI6wC.jpg",
            "popularity": 9.615
          },
          {
            "adult": false,
            "backdrop_path": "/tHF5OIcguut0Y83BXzqHtGdJOAf.jpg",
            "genre_ids": [
              18,
              35
            ],
            "id": 7974,
            "original_language": "fi",
            "original_title": "Tulitikkutehtaan tyttö",
            "overview": "Iris has a soul-deadening job as a quality-control worker watching boxes of matches go by on an assembly line all day. At night, she eats silently with her dour mother and stepfather. One weekend, wearing her new red dress at a local dance, she ends up going home with Aarne, whom she mistakenly believes is her new boyfriend. When she discovers that she's pregnant, years of pent-up rage explode in a shocking outburst.",
            "poster_path": "/zHfabvr3RKEbNfksFBs2Cder91i.jpg",
            "release_date": "1990-01-12",
            "title": "The Match Factory Girl",
            "video": false,
            "vote_average": 7.3,
            "vote_count": 93,
            "popularity": 7.809
          },
          {
            "id": 28212,
            "video": false,
            "vote_count": 56,
            "vote_average": 7.6,
            "title": "La Vie de Bohème",
            "release_date": "1992-02-27",
            "original_language": "fr",
            "original_title": "La Vie de Bohème",
            "genre_ids": [
              35,
              18,
              10749
            ],
            "backdrop_path": "/F9yotopY4t5P9DBvY28iTIO6hl.jpg",
            "adult": false,
            "overview": "Three penniless artists become friends in modern-day Paris: Rodolfo, an Albanian painter with no visa, Marcel, a playwright and magazine editor with no publisher, and Schaunard, a post-modernist composer of execrable noise.",
            "poster_path": "/5yxQ1As3FYzAGVpmpHmgh7sdsr0.jpg",
            "popularity": 7.303
          },
          {
            "id": 8214,
            "video": false,
            "vote_count": 66,
            "vote_average": 7.6,
            "title": "Drifting Clouds",
            "release_date": "1996-01-26",
            "original_language": "fi",
            "original_title": "Kauas pilvet karkaavat",
            "genre_ids": [
              18
            ],
            "backdrop_path": "/1ylTwjObkf7e4XvGbpYLvyZxQBB.jpg",
            "adult": false,
            "overview": "Tram driver Lauri looses his job. Shortly later, the restaurant where his wife Ilona works as a headwaitress is closed. Too proud, to receive money from the social welfare system, they hardly try to find new jobs. But they are completely unlucky and clumsy, one disaster is followed by the next. Finally, their courage, confidence, and their unbreakable love triumph over the fate.",
            "poster_path": "/xxzuKTo3RNyyUGXghfVkeiSbVDt.jpg",
            "popularity": 5.784
          },
          {
            "id": 58416,
            "video": false,
            "vote_count": 24,
            "vote_average": 7.3,
            "title": "Take Care of Your Scarf, Tatiana",
            "release_date": "1994-01-14",
            "original_language": "fi",
            "original_title": "Pidä huivista kiinni, Tatjana",
            "genre_ids": [
              35,
              10749
            ],
            "backdrop_path": "/mfHOfkkYukIM2yFDy4hV4PBNFPx.jpg",
            "adult": false,
            "overview": "Lugubrious Finns Valto and Reino take to the road in search of coffee and vodka, without which their lives are not worth living. But their reveries are interrupted by the arrival of garrulous Russian Klaudia and Estonian Tatiana - who are clearly interested in the two men, despite the language barrier. But what are the chances of getting a response from men who prefer staring at vodka bottles to talking?",
            "poster_path": "/t1DNH2bPgCKSjRHHH3F9Evezsra.jpg",
            "popularity": 3.327
          },
          {
            "id": 74295,
            "video": false,
            "vote_count": 31,
            "vote_average": 6.6,
            "title": "Crime and Punishment",
            "release_date": "1983-12-02",
            "original_language": "fi",
            "original_title": "Rikos ja rangaistus",
            "genre_ids": [
              80,
              18
            ],
            "backdrop_path": "/95dkgjeH6h9hstplkg4RSvWEmhH.jpg",
            "adult": false,
            "overview": "An adaptation of Dostoyevsky's novel, updated to present-day Helsinki. Slaughterhouse worker Rahikainen murders a man, and is forced to live with the consequences of his actions...",
            "poster_path": "/2z9EotczX6EY2oxhHU6PnpDmrrI.jpg",
            "popularity": 4.095
          },
          {
            "adult": false,
            "backdrop_path": "/vbbxn85rbcfchIcLDpxfhssundR.jpg",
            "genre_ids": [
              35
            ],
            "id": 59388,
            "original_language": "en",
            "original_title": "Calamari Union",
            "overview": "Calamari Union is an allegorical movie that tells the story of sixteen men all of whom are called Frank (inspired by Frank Armoton) apart from a single confrere, Pekka. Collectively the Franks and Pekka are unhappy with the perceived oppression they face in their district of Helsinki, Kallio, and decide to move to another, Eira, imagining it to be an unspoiled place where people can live lives of dignity. The journey is an ironic one given that both districts are not so far apart. In this spirit, their journey across the city takes on epic proportions with each of the travellers gradually falling by the wayside due to such travails as marriage, work, and death. In its entirety the film is a wry discussion of humanity within a system that regards humans as subservient components.",
            "poster_path": "/1rS3Rl17upvBEnaUE67lCPowDEs.jpg",
            "release_date": "1985-02-08",
            "title": "Calamari Union",
            "video": false,
            "vote_average": 6.8,
            "vote_count": 29,
            "popularity": 5.049
          },
          {
            "id": 1379,
            "video": false,
            "vote_count": 59,
            "vote_average": 6.7,
            "title": "Lights in the Dusk",
            "release_date": "2006-02-03",
            "original_language": "fi",
            "original_title": "Laitakaupungin valot",
            "genre_ids": [
              80,
              18
            ],
            "backdrop_path": "/6xB518f4K1uxOIPCENvVuiFj7CX.jpg",
            "adult": false,
            "overview": "Koistinen is a sad sack, a man without affect or friends. He's a night-watchman in Helsinki with ideas of starting his own business, but nothing to go with those intentions. He sometimes talks a bit with a woman who runs a snack trailer near his work. Out of the blue, a young sophisticated blonde woman attaches herself to Koistinen. He thinks of her as his girlfriend, he takes her on her rounds.",
            "poster_path": "/qLs0LoxaQIfwIGsA3ZRZYSzfYkA.jpg",
            "popularity": 5.328
          },
          {
            "adult": false,
            "backdrop_path": "/kevyDBlyEJvQOPGd0b3BbtPKqrK.jpg",
            "genre_ids": [
              35,
              10402
            ],
            "id": 11475,
            "original_language": "en",
            "original_title": "Leningrad Cowboys Go America",
            "overview": "The Leningrad Cowboys, a group of Russian musicians, and their manager, travel to America seeking fame and fortune. As they cross the country, trying to get to a wedding in Mexico, they are followed by the village idiot, who wishes to join the band.",
            "poster_path": "/6lJj3w5ebOkrsNx6sJXyNuWDJIB.jpg",
            "release_date": "1989-03-24",
            "title": "Leningrad Cowboys Go America",
            "video": false,
            "vote_average": 7.1,
            "vote_count": 74,
            "popularity": 7.453
          },
          {
            "id": 7975,
            "video": false,
            "vote_count": 79,
            "vote_average": 7.1,
            "title": "I Hired a Contract Killer",
            "release_date": "1990-10-12",
            "original_language": "en",
            "original_title": "I Hired a Contract Killer",
            "genre_ids": [
              35,
              18
            ],
            "backdrop_path": "/bD77pA3bC8zJVAmsHcQ6s9nuQo0.jpg",
            "adult": false,
            "overview": "After fifteen years' service, Henri Boulanger is made redundant from his job. Shocked, he attempts suicide, but can't go through with it, so he hires a contract killer in a seedy bar to murder him at some unspecified time in the future. But almost immediately he meets and falls in love with Margaret, a flower-seller, which makes Henri realise that his life has some meaning after all. But when he goes back to the bar to cancel the contract, he finds it has been demolished - and there's no way he can get in touch with the killer...",
            "poster_path": "/isn7m40ihEgY8A1ebzU98HrNhbU.jpg",
            "popularity": 5.973
          },
          {
            "id": 144728,
            "video": false,
            "vote_count": 8,
            "vote_average": 7.8,
            "title": "The Stars Will Tell, Inspector Palmu",
            "release_date": "1962-09-07",
            "original_language": "fi",
            "original_title": "Tähdet kertovat, komisario Palmu",
            "genre_ids": [
              35,
              80
            ],
            "backdrop_path": "/rqF2lDTbCYyvjoHk1evAxEQkFbB.jpg",
            "adult": false,
            "overview": "Ms. Alli Pelkonen's terrier finds a body from Tähtitorninmäki, that's thought to be a wino at first. But Inspector Palmu knows a little better. And yes, it was a murder.  Tähdet kertovat, Komisario Palmu (1962) is directed by Matti Kassila, as were all of these movies. This is the third Inspector Palmu movie. Mika Waltari worked on the script, and after that he came up with the novel.",
            "poster_path": "/adMU4TzWWBlElOSwsBTPUlWUtC7.jpg",
            "popularity": 3.808
          },
          {
            "adult": false,
            "backdrop_path": "/cTQj5vHj9K0roiMW7uIYooCIpEz.jpg",
            "genre_ids": [
              18
            ],
            "id": 125276,
            "original_language": "ja",
            "original_title": "(秘)色情めす市場",
            "overview": "Roman Porno from 1974, focusing on the daily life of lower-class individuals in the slums of Osaka.",
            "poster_path": "/iFpqFaa6SO2YeMMMTqGE7hjqwwr.jpg",
            "release_date": "1974-09-11",
            "title": "Secret Chronicle: She Beast Market",
            "video": false,
            "vote_average": 6.6,
            "vote_count": 7,
            "popularity": 3.158
          },
          {
            "id": 7294,
            "video": false,
            "vote_count": 154,
            "vote_average": 7.4,
            "title": "The Man Without a Past",
            "release_date": "2002-03-01",
            "original_language": "fi",
            "original_title": "Mies vailla menneisyyttä",
            "genre_ids": [
              35,
              18,
              10749
            ],
            "backdrop_path": "/nvzRMLQSYB1XYooexBr8Nqp5vcU.jpg",
            "adult": false,
            "overview": "The second part of Aki Kaurismäki's \\"Finland\\" trilogy, the film follows a man who arrives in Helsinki and gets beaten up so severely he develops amnesia. Unable to remember his name or anything from his past life, he cannot get a job or an apartment, so he starts living on the outskirts of the city and slowly starts putting his life back on track.",
            "poster_path": "/9tBepCujkyNg1qM52MsaJfDkIRw.jpg",
            "popularity": 7.23
          },
          {
            "adult": false,
            "backdrop_path": "/yZqZsZft1a71BpzBAc7oBroUfrK.jpg",
            "genre_ids": [
              10749,
              35,
              18
            ],
            "id": 55257,
            "original_language": "fi",
            "original_title": "Juha",
            "overview": "A farmer's wife is seduced into running away from her stolid older husband by a city slicker, who enslaves her in a brothel.",
            "poster_path": "/idh0ybgYH0ttildtRjxaRrYWWto.jpg",
            "release_date": "1999-02-26",
            "title": "Juha",
            "video": false,
            "vote_average": 6.8,
            "vote_count": 23,
            "popularity": 3.27
          },
          {
            "id": 144724,
            "video": false,
            "vote_count": 4,
            "vote_average": 6,
            "title": "Vodka, Mr. Palmu",
            "release_date": "1969-09-12",
            "original_language": "fi",
            "original_title": "Vodkaa, komisario Palmu",
            "genre_ids": [
              35,
              80
            ],
            "backdrop_path": "/bo47YyUrw99cf9QIevQgMuTWnG.jpg",
            "adult": false,
            "overview": "A TV reporter is murdered when he is eavesdropping on a secret Finnish-Soviet conference. The National Broadcasting Corporation enlists the help of police lieutenant Palmu, who comes out of retirement for this case. However, some have their doubts about the loyalities of Palmu, seeing that he was spotted in a diplomatic soiree in Moscow just a few weeks before the murder.",
            "poster_path": "/cDY1KuoUEX5mA77w9cICigmw1sO.jpg",
            "popularity": 2.801
          },
          {
            "id": 42718,
            "video": false,
            "vote_count": 15,
            "vote_average": 7.3,
            "title": "The Pornographers",
            "release_date": "1966-03-12",
            "original_language": "ja",
            "original_title": "「エロ事師たち」より 人類学入門",
            "genre_ids": [
              18,
              10749
            ],
            "backdrop_path": null,
            "adult": false,
            "overview": "Subu makes pornographic films. He sees nothing wrong with it. They are an aid to a repressed society, and he uses the money to support his landlady, Haru, and her family. From time to time, Haru shares her bed with Subu, though she believes her dead husband, reincarnated as a carp, disapproves. Director Shohei Imamura has always delighted in the kinky exploits of lowlifes, and in this 1966 classic, he finds subversive humor in the bizarre dynamics of Haru, her Oedipal son, and her daughter, the true object of her pornographer-boyfriend’s obsession. Imamura’s comic treatment of such taboos as voyeurism and incest sparked controversy when the film was released, but The Pornographers has outlasted its critics, and now seems frankly ahead of its time.",
            "poster_path": "/seIiQOJDUmOUQ6bx2AanzuHXncH.jpg",
            "popularity": 4.69
          },
          {
            "id": 31589,
            "video": false,
            "vote_count": 104,
            "vote_average": 7.9,
            "title": "The Bad Sleep Well",
            "release_date": "1960-09-15",
            "original_language": "ja",
            "original_title": "悪い奴ほどよく眠る",
            "genre_ids": [
              80,
              18,
              53
            ],
            "backdrop_path": "/m9NzvzYugcjkkZ5A3WdQhI3Mbe7.jpg",
            "adult": false,
            "overview": "In this loose adaptation of \\"Hamlet,\\" illegitimate son Kôichi Nishi climbs to a high position within a Japanese corporation and marries the crippled daughter of company vice president Iwabuchi. At the reception, the wedding cake is a replica of their corporate headquarters, but an aspect of the design reminds the party of the hushed-up death of Nishi's father. It is then that Nishi unleashes his plan to avenge his father's death.",
            "poster_path": "/z0LhZ121uaqa31RUeu1mOnaFb5w.jpg",
            "popularity": 7.339
          },
          {
            "adult": false,
            "backdrop_path": "/ygpyhavKrCoCSvvXPVWm9cP8wI9.jpg",
            "genre_ids": [
              18
            ],
            "id": 49571,
            "original_language": "ja",
            "original_title": "赤い殺意",
            "overview": "Sadako, cursed by generations before her and neglected by her common-law husband, falls prey to a brutal home intruder. But rather than become a victim, she forges a path to her own awakening.",
            "poster_path": "/i9w3qP6eg33NMJ0kxwy9J8kYeE3.jpg",
            "release_date": "1964-06-28",
            "title": "Intentions of Murder",
            "video": false,
            "vote_average": 7,
            "vote_count": 22,
            "popularity": 4.869
          },
          {
            "id": 8749,
            "video": false,
            "vote_count": 18,
            "vote_average": 6.2,
            "title": "Hamlet Goes Business",
            "release_date": "1987-08-21",
            "original_language": "fi",
            "original_title": "Hamlet liikemaailmassa",
            "genre_ids": [
              35,
              18
            ],
            "backdrop_path": "/YbzfnWSeZvfABKn0zSyY3IY0IV.jpg",
            "adult": false,
            "overview": "A bizarre black-and-white film noir reworking of Shakespeare's 'Hamlet'.",
            "poster_path": "/5OjVh44NDV3m8ePTt2BXMWTzlH5.jpg",
            "popularity": 3.475
          },
          {
            "adult": false,
            "backdrop_path": null,
            "genre_ids": [
              18
            ],
            "id": 55396,
            "original_language": "fi",
            "original_title": "Koirankynnen leikkaaja",
            "overview": "",
            "poster_path": "/7Myk0sEW5AcwZyAN8kQVaokfDAy.jpg",
            "release_date": "2004-02-12",
            "title": "Dog Nail Clipper",
            "video": false,
            "vote_average": 7,
            "vote_count": 7,
            "popularity": 2.922
          }
        ],
        "total_pages": 2,
        "total_results": 40
      },
      "credits": {
        "cast": [
          {
            "cast_id": 5,
            "character": "Nikander",
            "credit_id": "52fe420dc3a36847f8000087",
            "gender": 2,
            "id": 4826,
            "name": "Matti Pellonpää",
            "order": 0,
            "profile_path": "/1Qzhkkp3wFE2NMGKVyOra9931q2.jpg",
            "popularity": 32.43
          },
          {
            "cast_id": 6,
            "character": "Ilona Rajamäki",
            "credit_id": "52fe420dc3a36847f800008b",
            "gender": 1,
            "id": 5999,
            "name": "Kati Outinen",
            "order": 1,
            "profile_path": "/mi78e4O4hQBQygxVVtwXdV2xqiu.jpg",
            "popularity": 32.43
          },
          {
            "cast_id": 7,
            "character": "Melartin",
            "credit_id": "52fe420dc3a36847f800008f",
            "gender": 2,
            "id": 4828,
            "name": "Sakari Kuosmanen",
            "order": 2,
            "profile_path": "/syM87lzV2IqFno87Za1PbeAUdMW.jpg",
            "popularity": 32.43
          },
          {
            "cast_id": 9,
            "character": "Co-worker",
            "credit_id": "52fe420dc3a36847f8000099",
            "gender": 2,
            "id": 53508,
            "name": "Esko Nikkari",
            "order": 3,
            "profile_path": "/mNiyD3BOzWba4CB0VTbIqA4EAVm.jpg",
            "popularity": 32.43
          },
          {
            "cast_id": 10,
            "character": "Ilona's Girlfriend",
            "credit_id": "52fe420dc3a36847f800009d",
            "gender": 1,
            "id": 1086499,
            "name": "Kylli Köngäs",
            "order": 4,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 11,
            "character": "Shop Steward",
            "credit_id": "52fe420dc3a36847f80000a1",
            "gender": 2,
            "id": 222320,
            "name": "Pekka Laiho",
            "order": 5,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 12,
            "character": "Third Man",
            "credit_id": "52fe420dc3a36847f80000a5",
            "gender": 2,
            "id": 1086500,
            "name": "Jukka-Pekka Palo",
            "order": 6,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 28,
            "character": "Police",
            "credit_id": "5eca14ba0fb17f001d8041f2",
            "gender": 2,
            "id": 2307211,
            "name": "Svante Korkiakoski",
            "order": 7,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 29,
            "character": "Nikander's Sister",
            "credit_id": "5eca154d0fb17f001d804249",
            "gender": 1,
            "id": 148389,
            "name": "Mari Rantasila",
            "order": 8,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 30,
            "character": "Pianist",
            "credit_id": "5eca15850fb17f001d80428c",
            "gender": 2,
            "id": 1761924,
            "name": "Safka Pekkonen",
            "order": 9,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 31,
            "character": "Pianist",
            "credit_id": "5eca17d8e635710022d365e3",
            "gender": 2,
            "id": 2651471,
            "name": "Antti Ortamo",
            "order": 10,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 32,
            "character": "Pelle",
            "credit_id": "5eca1824e635710022d36658",
            "gender": 2,
            "id": 106172,
            "name": "Mato Valtonen",
            "order": 11,
            "profile_path": "/3JFNkSzPjptZ8RUrrjKhtCPEsEt.jpg",
            "popularity": 32.43
          },
          {
            "cast_id": 33,
            "character": "Staffan",
            "credit_id": "5eca1849e635710022d3668a",
            "gender": 2,
            "id": 69552,
            "name": "Sakke Järvenpää",
            "order": 12,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 34,
            "character": "Melartin's Wife",
            "credit_id": "5eca18a50fb17f001d80472b",
            "gender": 1,
            "id": 2651474,
            "name": "Ulla Kuosmanen",
            "order": 13,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 35,
            "character": "Cook",
            "credit_id": "5eca18f9140bad001b1c1016",
            "gender": 2,
            "id": 1294421,
            "name": "Neka Haapanen",
            "order": 14,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 36,
            "character": "Singer",
            "credit_id": "5eca19778e2e0000202396a4",
            "gender": 2,
            "id": 2651478,
            "name": "Pentti Koski",
            "order": 15,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 37,
            "character": "Man in the Restaurant",
            "credit_id": "5eca1a35140bad001b1c1203",
            "gender": 2,
            "id": 2651481,
            "name": "Ari Korhonen",
            "order": 16,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 38,
            "character": "Police",
            "credit_id": "5eca1aaf140bad001b1c1663",
            "gender": 2,
            "id": 2651483,
            "name": "Teuvo Rissanen",
            "order": 17,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 39,
            "character": "Porter",
            "credit_id": "5eca1ba3d2147c0023c3440f",
            "gender": 2,
            "id": 2651486,
            "name": "Erkki Rissanen",
            "order": 18,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 40,
            "character": "Woman in the Restaurant",
            "credit_id": "5eca1c1b8e2e000020239a87",
            "gender": 1,
            "id": 2651487,
            "name": "Sirkka Silin",
            "order": 19,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 41,
            "character": "Hostess",
            "credit_id": "5eca1ca1140bad001c19fa7f",
            "gender": 1,
            "id": 2651488,
            "name": "Marina Martinoff",
            "order": 20,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 42,
            "character": "Garbage Man / Bartender",
            "credit_id": "5eca1d7f140bad001b1c199a",
            "gender": 2,
            "id": 2651489,
            "name": "Jussi Tiitinen",
            "order": 21,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 43,
            "character": "Melartin's Daughter",
            "credit_id": "5eca1e2de635710020d0a2a0",
            "gender": 1,
            "id": 2651491,
            "name": "Riikka Kuosmanen",
            "order": 22,
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "cast_id": 44,
            "character": "Hotel Receptionist (uncredited)",
            "credit_id": "5eca1ef2d2147c0023c34830",
            "gender": 2,
            "id": 16767,
            "name": "Aki Kaurismäki",
            "order": 23,
            "profile_path": "/kiJErWEOv4Ew7aHOGKg4ljsmppZ.jpg",
            "popularity": 32.43
          }
        ],
        "crew": [
          {
            "credit_id": "52fe420dc3a36847f8000077",
            "department": "Writing",
            "gender": 2,
            "id": 16767,
            "job": "Screenplay",
            "name": "Aki Kaurismäki",
            "profile_path": "/kiJErWEOv4Ew7aHOGKg4ljsmppZ.jpg",
            "popularity": 32.43
          },
          {
            "credit_id": "52fe420dc3a36847f8000071",
            "department": "Directing",
            "gender": 2,
            "id": 16767,
            "job": "Director",
            "name": "Aki Kaurismäki",
            "profile_path": "/kiJErWEOv4Ew7aHOGKg4ljsmppZ.jpg",
            "popularity": 32.43
          },
          {
            "credit_id": "5963e8a3c3a36828fc0e46e5",
            "department": "Camera",
            "gender": 2,
            "id": 16769,
            "job": "Director of Photography",
            "name": "Timo Salminen",
            "profile_path": "/a8rH6eJ0XY1zQph18eNDj7MC8y4.jpg",
            "popularity": 32.43
          },
          {
            "credit_id": "52fe420dc3a36847f8000083",
            "department": "Editing",
            "gender": 1,
            "id": 54766,
            "job": "Editor",
            "name": "Raija Talvio",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "5e1395b26c0b360011ffb228",
            "department": "Costume & Make-Up",
            "gender": 1,
            "id": 54771,
            "job": "Costume Design",
            "name": "Tuula Hilkamo",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "52fe420dc3a36847f8000095",
            "department": "Production",
            "gender": 2,
            "id": 54767,
            "job": "Producer",
            "name": "Mika Kaurismäki",
            "profile_path": "/p9Z53Mi03GPkyznS6Ho0RuEedyJ.jpg",
            "popularity": 32.43
          },
          {
            "credit_id": "5e1395dd9020120018b8d2cf",
            "department": "Production",
            "gender": 2,
            "id": 4831,
            "job": "Production Manager",
            "name": "Jaakko Talaskivi",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "5e1396178741c400143f3d16",
            "department": "Sound",
            "gender": 2,
            "id": 16772,
            "job": "Sound Editor",
            "name": "Jouko Lumme",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "5e1395d0d8af670014bfaed4",
            "department": "Directing",
            "gender": 2,
            "id": 1034489,
            "job": "Assistant Director",
            "name": "Pauli Pentti",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "52fe420dc3a36847f80000b1",
            "department": "Art",
            "gender": 2,
            "id": 1084612,
            "job": "Art Direction",
            "name": "Heikki Ukkonen",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "52fe420dc3a36847f80000ab",
            "department": "Art",
            "gender": 2,
            "id": 1084614,
            "job": "Art Direction",
            "name": "Pertti Hilkamo",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "5ebb8978614c6d001d8f006d",
            "department": "Camera",
            "gender": 1,
            "id": 1303969,
            "job": "Still Photographer",
            "name": "Marja-Leena Hukkanen",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "5ebb89bbc3514c002062a0f7",
            "department": "Directing",
            "gender": 1,
            "id": 1303969,
            "job": "Script Supervisor",
            "name": "Marja-Leena Hukkanen",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "5e13960c5907de0017e10896",
            "department": "Sound",
            "gender": 0,
            "id": 1683985,
            "job": "Sound Mixer",
            "name": "Kjell Westman",
            "profile_path": null,
            "popularity": 32.43
          },
          {
            "credit_id": "5e1395c0fc5f06001991e483",
            "department": "Costume & Make-Up",
            "gender": 1,
            "id": 1761858,
            "job": "Makeup Artist",
            "name": "Leena Kouhia",
            "profile_path": null,
            "popularity": 32.43
          }
        ]
      }
    }
    """.utf8)

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
