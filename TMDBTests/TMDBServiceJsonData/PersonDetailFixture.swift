//
//  PersonDetailFixture.swift
//  TMDBTests
//
//  Created by Tuyen Le on 7/14/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

let personDetailFixture = Data("""
    {
      "birthday": "1963-12-18",
      "known_for_department": "Acting",
      "id": 287,
      "movie_credits": {
        "cast": [
          {
            "poster_path": "/v0ogdW7JfrssGTk2ugn0IS0kLVj.jpg",
            "adult": false,
            "backdrop_path": "/3guCfwRt3MrmO6q56I4F5xN1LYB.jpg",
            "vote_count": 4917,
            "video": false,
            "id": 163,
            "popularity": 22.1,
            "genre_ids": [
              80,
              53
            ],
            "original_language": "en",
            "title": "Ocean's Twelve",
            "original_title": "Ocean's Twelve",
            "release_date": "2004-12-09",
            "character": "Rusty Ryan",
            "vote_average": 6.5,
            "overview": "Danny Ocean reunites with his old flame and the rest of his merry band of thieves in carrying out three huge heists in Rome, Paris and Amsterdam – but a Europol agent is hot on their heels.",
            "credit_id": "52fe4221c3a36847f80062e5"
          },
          {
            "poster_path": "/aVP45oS2cBL4WtZ1kB7r8uarruB.jpg",
            "adult": false,
            "backdrop_path": "/oPb7pSGhCRlqJX3s40ehr6gnTLi.jpg",
            "vote_count": 584,
            "video": false,
            "id": 293,
            "popularity": 10.038,
            "genre_ids": [
              18
            ],
            "original_language": "en",
            "title": "A River Runs Through It",
            "original_title": "A River Runs Through It",
            "release_date": "1992-10-09",
            "character": "Paul Maclean",
            "vote_average": 7.1,
            "overview": "A River Runs Through is a cinematographically stunning true story of Norman Maclean. The story follows Norman and his brother Paul through the experiences of life and growing up, and how their love of fly fishing keeps them together despite varying life circumstances in the untamed west of Montana in the 1920's.",
            "credit_id": "52fe4233c3a36847f800bb79"
          },
          {
            "poster_path": "/fDPAjvfPMomkKF7cMRmL5Anak61.jpg",
            "adult": false,
            "backdrop_path": "/xYI72IVRK7MTQpENTdt4L20Aa2I.jpg",
            "vote_count": 2945,
            "video": false,
            "id": 297,
            "popularity": 22.452,
            "genre_ids": [
              18,
              14,
              10749
            ],
            "original_language": "en",
            "title": "Meet Joe Black",
            "original_title": "Meet Joe Black",
            "release_date": "1998-11-12",
            "character": "Joe Black / Young Man in Coffee Shop",
            "vote_average": 7.2,
            "overview": "When the grim reaper comes to collect the soul of megamogul Bill Parrish, he arrives with a proposition: Host him for a \\"vacation\\" among the living in trade for a few more days of existence. Parrish agrees, and using the pseudonym Joe Black, Death begins taking part in Parrish's daily agenda and falls in love with the man's daughter. Yet when Black's holiday is over, so is Parrish's life.",
            "credit_id": "52fe4234c3a36847f800bdbb"
          },
          {
            "release_date": "1994-11-11",
            "adult": false,
            "vote_average": 7.3,
            "vote_count": 3648,
            "video": false,
            "title": "Interview with the Vampire",
            "popularity": 20.373,
            "genre_ids": [
              27,
              18,
              14
            ],
            "original_language": "en",
            "character": "Louis de Pointe du Lac",
            "original_title": "Interview with the Vampire",
            "poster_path": "/t7NU8IcmcNBrlunCxiycX9JV7Rp.jpg",
            "id": 628,
            "backdrop_path": "/3fChciF2G1wXHsyTfJD9y7uN6Il.jpg",
            "overview": "A vampire relates his epic life story of love, betrayal, loneliness, and dark hunger to an over-curious reporter.",
            "credit_id": "52fe4260c3a36847f80199f9"
          },
          {
            "release_date": "2004-05-03",
            "adult": false,
            "vote_average": 7.1,
            "vote_count": 6814,
            "video": false,
            "title": "Troy",
            "popularity": 28.325,
            "genre_ids": [
              12,
              36
            ],
            "original_language": "en",
            "character": "Achilles",
            "original_title": "Troy",
            "poster_path": "/kWj4RJzZeJGeyGA3DVGQiNkUjkt.jpg",
            "id": 652,
            "backdrop_path": "/wEmexPKgF2sgYvvl6MxI5rTn2qM.jpg",
            "overview": "In year 1250 B.C. during the late Bronze age, two emerging nations begin to clash. Paris, the Trojan prince, convinces Helen, Queen of Sparta, to leave her husband Menelaus, and sail with him back to Troy. After Menelaus finds out that his wife was taken by the Trojans, he asks his brother Agamemnom to help him get her back. Agamemnon sees this as an opportunity for power. So they set off with 1,000 ships holding 50,000 Greeks to Troy. With the help of Achilles, the Greeks are able to fight the never before defeated Trojans.",
            "credit_id": "52fe4264c3a36847f801b083"
          },
          {
            "poster_path": "/6yoghtyTpznpBik8EngEmJskVUO.jpg",
            "adult": false,
            "backdrop_path": "/4U4q1zjIwCZTNkp6RKWkWPuC7uI.jpg",
            "vote_count": 13382,
            "video": false,
            "id": 807,
            "popularity": 53.437,
            "genre_ids": [
              80,
              9648,
              53
            ],
            "original_language": "en",
            "title": "Se7en",
            "original_title": "Se7en",
            "release_date": "1995-09-22",
            "character": "Detective David Mills",
            "vote_average": 8.3,
            "overview": "Two homicide detectives are on a desperate hunt for a serial killer whose crimes are based on the \\"seven deadly sins\\" in this dark and haunting film that takes viewers from the tortured remains of one victim to the next. The seasoned Det. Sommerset researches each sin in an effort to get inside the killer's mind, while his novice partner, Mills, scoffs at his efforts to unravel the case.",
            "credit_id": "52fe4279c3a36847f802178b"
          },
          {
            "release_date": "1997-09-12",
            "adult": false,
            "vote_average": 7.1,
            "vote_count": 1626,
            "video": false,
            "title": "Seven Years in Tibet",
            "popularity": 13.046,
            "genre_ids": [
              12,
              18,
              36
            ],
            "original_language": "en",
            "character": "Heinrich Harrer",
            "original_title": "Seven Years in Tibet",
            "poster_path": "/5euQXAgJ34TdUFl1t3O6Jw2lJAs.jpg",
            "id": 978,
            "backdrop_path": "/s90zsx8QQmgkXVhM6TJEYAaWy2I.jpg",
            "overview": "Austrian mountaineer, Heinrich Harrer journeys to the Himalayas without his family to head an expedition in 1939. But when World War II breaks out, the arrogant Harrer falls into Allied forces' hands as a prisoner of war. He escapes with a fellow detainee and makes his way to Llaso, Tibet, where he meets the 14-year-old Dalai Lama, whose friendship ultimately transforms his outlook on life.",
            "credit_id": "52fe4295c3a36847f802a10d"
          },
          {
            "poster_path": "/ocV89hUekPRPIjPxivNBZJXx7AN.jpg",
            "adult": false,
            "backdrop_path": "/9YoLdWeBSxAdR6BqQ5uS88d3FWO.jpg",
            "vote_count": 2403,
            "video": false,
            "id": 1164,
            "popularity": 19.014,
            "genre_ids": [
              18
            ],
            "original_language": "en",
            "title": "Babel",
            "original_title": "Babel",
            "release_date": "2006-09-08",
            "character": "Richard Jones",
            "vote_average": 7.1,
            "overview": "Tragedy strikes a married couple on vacation in the Moroccan desert, touching off an interlocking story involving four different families.",
            "credit_id": "52fe42e9c3a36847f802c221"
          },
          {
            "release_date": "1994-04-28",
            "adult": false,
            "vote_average": 7.4,
            "vote_count": 1458,
            "video": false,
            "title": "Legends of the Fall",
            "popularity": 18.564,
            "genre_ids": [
              12,
              18,
              10749,
              10752,
              37
            ],
            "original_language": "en",
            "character": "Tristan Ludlow",
            "original_title": "Legends of the Fall",
            "poster_path": "/t1KPGlW0UGd0m515LPQmk2F4nu1.jpg",
            "id": 4476,
            "backdrop_path": "/nlbvTH8B8vIFkgbDWUp0ZAQSTxv.jpg",
            "overview": "An epic tale of three brothers and their father living in the remote wilderness of 1900s USA and how their lives are affected by nature, history, war, and love.",
            "credit_id": "52fe43c4c3a36847f806e20d"
          },
          {
            "poster_path": "/2d1S6fJS80fvseg6mJE8eq5o7Kx.jpg",
            "adult": false,
            "backdrop_path": "/wxAprkYIwTwKiOSlPG0snUIwt6n.jpg",
            "vote_count": 1599,
            "video": false,
            "id": 4512,
            "popularity": 11.727,
            "genre_ids": [
              28,
              18,
              37
            ],
            "original_language": "en",
            "title": "The Assassination of Jesse James by the Coward Robert Ford",
            "original_title": "The Assassination of Jesse James by the Coward Robert Ford",
            "release_date": "2007-09-07",
            "character": "Jesse James",
            "vote_average": 7,
            "overview": "Outlaw Jesse James is rumored to be the 'fastest gun in the West'. An eager recruit into James' notorious gang, Robert Ford eventually grows jealous of the famed outlaw and, when Robert and his brother sense an opportunity to kill James, their murderous action elevates their target to near mythical status.",
            "credit_id": "52fe43c7c3a36847f806eed5"
          },
          {
            "release_date": "1993-06-24",
            "adult": false,
            "vote_average": 6.6,
            "vote_count": 454,
            "video": false,
            "title": "Kalifornia",
            "popularity": 9.611,
            "genre_ids": [
              53,
              80
            ],
            "original_language": "en",
            "character": "Early Grayce",
            "original_title": "Kalifornia",
            "poster_path": "/4E39RrmgXspAqGro2poDEdjvAnh.jpg",
            "id": 10909,
            "backdrop_path": "/dPRtllOftvPCDklPCYWI58xUzTl.jpg",
            "overview": "A journalist duo go on a tour of serial killer murder sites with two companions, unaware that one of them is a serial killer himself.",
            "credit_id": "52fe43ce9251416c7501ef13"
          },
          {
            "poster_path": "/5GqF6rVjUW6CVTuj7w1A2JE49AF.jpg",
            "adult": false,
            "backdrop_path": "/zxWpdqrb5eXKKN0Uv1mpD1M8wJm.jpg",
            "vote_count": 922,
            "video": false,
            "id": 6073,
            "popularity": 12.822,
            "genre_ids": [
              28,
              35,
              80,
              10749
            ],
            "original_language": "en",
            "title": "The Mexican",
            "original_title": "The Mexican",
            "release_date": "2001-03-01",
            "character": "Jerry Welbach",
            "vote_average": 5.8,
            "overview": "Jerry Welbach, a reluctant bagman, has been given two ultimatums: The first is from his mob boss to travel to Mexico and retrieve a priceless antique pistol, known as \\"the Mexican\\"... or suffer the consequences. The second is from his girlfriend Samantha to end his association with the mob. Jerry figures alive and in trouble with Samantha is better than the more permanent alternative, so he heads south of the border.",
            "credit_id": "52fe443bc3a36847f8089dd5"
          },
          {
            "poster_path": "/fd2wa02NYwbDJypkt4qLjjQODAM.jpg",
            "adult": false,
            "backdrop_path": "/pP4FZk5q835hiYW0da4BVBZzktU.jpg",
            "vote_count": 2094,
            "video": false,
            "id": 8967,
            "popularity": 13.165,
            "genre_ids": [
              18,
              14
            ],
            "original_language": "en",
            "title": "The Tree of Life",
            "original_title": "The Tree of Life",
            "release_date": "2011-05-18",
            "character": "Mr. O'Brien",
            "vote_average": 6.7,
            "overview": "The impressionistic story of a Texas family in the 1950s. The film follows the life journey of the eldest son, Jack, through the innocence of childhood to his disillusioned adult years as he tries to reconcile a complicated relationship with his father. Jack finds himself a lost soul in the modern world, seeking answers to the origins and meaning of life while questioning the existence of faith.",
            "credit_id": "52fe44ccc3a36847f80aa95b"
          },
          {
            "poster_path": "/bmjHurXL4pUJUOiVxFIRXLuHgGt.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 32,
            "video": false,
            "id": 26642,
            "popularity": 3.226,
            "genre_ids": [
              18,
              10749
            ],
            "original_language": "en",
            "title": "The Dark Side of the Sun",
            "original_title": "The Dark Side of the Sun",
            "release_date": "1988-12-21",
            "character": "Rick",
            "vote_average": 4.8,
            "overview": "Traveling in search of a cure for a rare skin disease, a man finds freedom and love along the way.",
            "credit_id": "52fe4510c3a368484e0467cb"
          },
          {
            "poster_path": "/yiW2L1fDiBT7AeWXrykhTNtPrr8.jpg",
            "adult": false,
            "backdrop_path": "/9seBrjaPfX08LqM1kQVVZ6Xd3Bp.jpg",
            "vote_count": 1225,
            "video": false,
            "id": 14411,
            "popularity": 19.987,
            "genre_ids": [
              28,
              12,
              16,
              35,
              14,
              10751
            ],
            "original_language": "en",
            "title": "Sinbad: Legend of the Seven Seas",
            "original_title": "Sinbad: Legend of the Seven Seas",
            "release_date": "2003-07-02",
            "character": "Sinbad (voice)",
            "vote_average": 6.8,
            "overview": "The sailor of legend is framed by the goddess Eris for the theft of the Book of Peace, and must travel to her realm at the end of the world to retrieve it and save the life of his childhood friend Prince Proteus.",
            "credit_id": "52fe45f09251416c75067ad5"
          },
          {
            "release_date": "2011-09-22",
            "adult": false,
            "vote_average": 7.2,
            "vote_count": 2923,
            "video": false,
            "title": "Moneyball",
            "popularity": 19.125,
            "genre_ids": [
              18
            ],
            "original_language": "en",
            "character": "Billy Beane",
            "original_title": "Moneyball",
            "poster_path": "/4yIQq1e6iOcaZ5rLDG3lZBP3j7a.jpg",
            "id": 60308,
            "backdrop_path": "/qbWrn6xaWK4nkzMRfP6oBBUW2cy.jpg",
            "overview": "The story of Oakland Athletics general manager Billy Beane's successful attempt to put together a baseball team on a budget, by employing computer-generated analysis to draft his players.",
            "credit_id": "52fe461fc3a368484e0800bd"
          },
          {
            "poster_path": "/snuBjisjRjmP1TZC2Q0wCtaxZ6o.jpg",
            "adult": false,
            "backdrop_path": "/fK0NyLXUxDbQyhUuK11qsBwquMH.jpg",
            "vote_count": 30,
            "video": false,
            "id": 45145,
            "popularity": 4.516,
            "genre_ids": [
              35,
              10749
            ],
            "original_language": "en",
            "title": "Johnny Suede",
            "original_title": "Johnny Suede",
            "release_date": "1991-08-18",
            "character": "Johnny Suede",
            "vote_average": 4.8,
            "overview": "A struggling young musician and devoted fan of Ricky Nelson wants to be just like his idol and become a rock star.",
            "credit_id": "52fe46b2c3a36847f810d153"
          },
          {
            "release_date": "2012-07-30",
            "adult": false,
            "vote_average": 6,
            "vote_count": 1365,
            "video": false,
            "title": "Killing Them Softly",
            "popularity": 13.864,
            "genre_ids": [
              80,
              53
            ],
            "original_language": "en",
            "character": "Jackie Cogan",
            "original_title": "Killing Them Softly",
            "poster_path": "/heaz45kpFa4Oa7iLis0OBas68ls.jpg",
            "id": 64689,
            "backdrop_path": "/1g0EZDJkJMXa0fJyIOJGiJegSUC.jpg",
            "overview": "Jackie Cogan is an enforcer hired to restore order after three dumb guys rob a Mob protected card game, causing the local criminal economy to collapse.",
            "credit_id": "52fe46e4c3a368484e0a9a51"
          },
          {
            "poster_path": "/pdtXZeVJ5QBrwJO7lXw5m2y0mKF.jpg",
            "adult": false,
            "backdrop_path": "/lIeC3L2crg1hkNLkAt38D9I6sRB.jpg",
            "vote_count": 26,
            "video": false,
            "id": 48448,
            "popularity": 5.174,
            "genre_ids": [
              18
            ],
            "original_language": "en",
            "title": "Across the Tracks",
            "original_title": "Across the Tracks",
            "release_date": "1991-02-14",
            "character": "Joe Maloney",
            "vote_average": 5.3,
            "overview": "When Billy returns from reform school he has to attend a different high school at the other side of town. He tries to start with a clean slate but his old rival doesn't make it easy on him and his buddy Louie tries to make him go astray again. His brother Joe, quite the opposite of Billy, is a good runner and determined to win a track scholarship. He suggests Billy to join his school's track team, which pits the two brothers against each other.",
            "credit_id": "52fe4766c3a36847f81338e5"
          },
          {
            "poster_path": "/aCnVdvExw6UWSeQfr0tUH3jr4qG.jpg",
            "adult": false,
            "backdrop_path": "/f5H5aLVCClEFnnTUrN0i2tXXLIz.jpg",
            "vote_count": 10966,
            "video": false,
            "id": 72190,
            "popularity": 30.519,
            "genre_ids": [
              28,
              18,
              27,
              878,
              53
            ],
            "original_language": "en",
            "title": "World War Z",
            "original_title": "World War Z",
            "release_date": "2013-06-20",
            "character": "Gerry Lane",
            "vote_average": 6.8,
            "overview": "Life for former United Nations investigator Gerry Lane and his family seems content. Suddenly, the world is plagued by a mysterious infection turning whole human populations into rampaging mindless zombies. After barely escaping the chaos, Lane is persuaded to go on a mission to investigate this disease. What follows is a perilous trek around the world where Lane must brave horrific dangers and long odds to find answers before human civilization falls.",
            "credit_id": "52fe485dc3a368484e0f5061"
          },
          {
            "poster_path": "/tWQGX4Gjq4TleqrCmam5tpoCBoi.jpg",
            "adult": false,
            "backdrop_path": "/1uKHoFWyYJn060dpIXUCU7Wbc15.jpg",
            "vote_count": 8172,
            "video": false,
            "id": 228150,
            "popularity": 49.717,
            "genre_ids": [
              28,
              18,
              10752
            ],
            "original_language": "en",
            "title": "Fury",
            "original_title": "Fury",
            "release_date": "2014-10-15",
            "character": "Don 'Wardaddy' Collier",
            "vote_average": 7.5,
            "overview": "In the last months of World War II, as the Allies make their final push in the European theatre, a battle-hardened U.S. Army sergeant named 'Wardaddy' commands a Sherman tank called 'Fury' and its five-man crew on a deadly mission behind enemy lines. Outnumbered and outgunned, Wardaddy and his men face overwhelming odds in their heroic attempts to strike at the heart of Nazi Germany.",
            "credit_id": "52fe4ec09251416c7516126f"
          },
          {
            "release_date": "2015-09-02",
            "adult": false,
            "vote_average": 7.8,
            "vote_count": 60,
            "video": false,
            "title": "Hitting the Apex",
            "popularity": 7.745,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "character": "Narrator (voice)",
            "original_title": "Hitting the Apex",
            "poster_path": "/oDfMkUVIjev0g2qq821NER6jgS7.jpg",
            "id": 357681,
            "backdrop_path": null,
            "overview": "'Hitting the Apex' is the inside story of six fighters – six of the fastest motorcycle racers of all time – and of the fates that awaited them at the peak of the sport. It’s the story of what is at stake for all of them: all that can be won, and all that can be lost, when you go chasing glory at over two hundred miles an hour – on a motorcycle.",
            "credit_id": "55e786c39251413e4500020a"
          },
          {
            "poster_path": "/7XIxdjhaoDIiv7slEiOhBEzMtqu.jpg",
            "adult": false,
            "backdrop_path": "/Bfsoyo6mai2KKhdL5tk85RIB8F.jpg",
            "vote_count": 658,
            "video": false,
            "id": 4477,
            "popularity": 12.874,
            "genre_ids": [
              80,
              18,
              53
            ],
            "original_language": "en",
            "title": "The Devil's Own",
            "original_title": "The Devil's Own",
            "release_date": "1997-03-12",
            "character": "Francis Austin McGuire, alias Rory Devaney",
            "vote_average": 6.1,
            "overview": "Frankie McGuire, one of the IRA's deadliest assassins, draws an American family into the crossfire of terrorism. But when he is sent to the U.S. to buy weapons, Frankie is housed with the family of Tom O'Meara, a New York cop who knows nothing about Frankie's real identity. Their surprising friendship, and Tom's growing suspicions, forces Frankie to choose between the promise of peace or a lifetime of murder.",
            "credit_id": "52fe43c4c3a36847f806e2b9"
          },
          {
            "poster_path": "/7sfbEnaARXDDhKm0CZ7D7uc2sbo.jpg",
            "adult": false,
            "backdrop_path": "/8pEnePgGyfUqj8Qa6d91OZQ6Aih.jpg",
            "vote_count": 15018,
            "video": false,
            "id": 16869,
            "popularity": 29.701,
            "genre_ids": [
              28,
              18,
              53,
              10752
            ],
            "original_language": "en",
            "title": "Inglourious Basterds",
            "original_title": "Inglourious Basterds",
            "release_date": "2009-08-18",
            "character": "First Lieutenant Aldo \\"The Apache\\" Raine",
            "vote_average": 8.2,
            "overview": "In Nazi-occupied France during World War II, a group of Jewish-American soldiers known as \\"The Basterds\\" are chosen specifically to spread fear throughout the Third Reich by scalping and brutally killing Nazis. The Basterds, lead by Lt. Aldo Raine soon cross paths with a French-Jewish teenage girl who runs a movie theater in Paris which is targeted by the soldiers.",
            "credit_id": "52fe46f29251416c75088c69"
          },
          {
            "poster_path": "/sV4lXM32quwminL3TP36nlNPp7Q.jpg",
            "adult": false,
            "backdrop_path": "/Acyjn5ITzMKX7o9hdOor6SE2IWZ.jpg",
            "vote_count": 3300,
            "video": false,
            "id": 369885,
            "popularity": 19.619,
            "genre_ids": [
              28,
              18,
              53,
              10749,
              10752
            ],
            "original_language": "en",
            "title": "Allied",
            "original_title": "Allied",
            "release_date": "2016-11-17",
            "character": "Max Vatan",
            "vote_average": 6.7,
            "overview": "In 1942, an intelligence officer in North Africa encounters a female French Resistance fighter on a deadly mission behind enemy lines. When they reunite in London, their relationship is tested by the pressures of war.",
            "credit_id": "5789f699c3a36841e3001936"
          },
          {
            "poster_path": "/zGlzlzms2vN5vSFVMWuknu7XGXP.jpg",
            "adult": false,
            "backdrop_path": "/eQsellX1IeGaIjv1w4JBzoOrvmf.jpg",
            "vote_count": 745,
            "video": false,
            "id": 354287,
            "popularity": 12.558,
            "genre_ids": [
              35,
              18,
              10752
            ],
            "original_language": "en",
            "title": "War Machine",
            "original_title": "War Machine",
            "release_date": "2017-05-26",
            "character": "Gen. Glen McMahon",
            "vote_average": 5.5,
            "overview": "A rock star general bent on winning the “impossible” war in Afghanistan takes us inside the complex machinery of modern war. Inspired by the true story of General Stanley McChrystal.",
            "credit_id": "55cc4e9b925141764800222d"
          },
          {
            "poster_path": "/1jwTB27ZNPtszKcayYwGnunhpAy.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 0,
            "video": false,
            "id": 615777,
            "popularity": 4.943,
            "genre_ids": [
              18
            ],
            "original_language": "en",
            "title": "Babylon",
            "original_title": "Babylon",
            "release_date": "2021-12-25",
            "character": "",
            "vote_average": 0,
            "overview": "Set in Hollywood during the transition from silent films to talkies, focusing on a mixture of historical and fictional characters. Plot unknown.",
            "credit_id": "5d44f4e42d1e40349abdf185"
          },
          {
            "poster_path": "/56mOJth6DJ6JhgoE2jtpilVqJO.jpg",
            "adult": false,
            "backdrop_path": "/1UnjPqG1d730s135O5tAALt2ted.jpg",
            "vote_count": 5857,
            "video": false,
            "id": 107,
            "popularity": 26.996,
            "genre_ids": [
              80,
              53
            ],
            "original_language": "en",
            "title": "Snatch",
            "original_title": "Snatch",
            "release_date": "2000-09-01",
            "character": "Mickey O'Neil",
            "vote_average": 7.8,
            "overview": "Unscrupulous boxing promoters, violent bookmakers, a Russian gangster, incompetent amateur robbers and supposedly Jewish jewelers fight to track down a priceless stolen diamond.",
            "credit_id": "52fe4218c3a36847f8003be5"
          },
          {
            "poster_path": "/v5D7K4EHuQHFSjveq8LGxdSfrGS.jpg",
            "adult": false,
            "backdrop_path": "/43BEez1EGdmNpg8rcPUFToujlii.jpg",
            "vote_count": 8021,
            "video": false,
            "id": 161,
            "popularity": 23.925,
            "genre_ids": [
              80,
              53
            ],
            "original_language": "en",
            "title": "Ocean's Eleven",
            "original_title": "Ocean's Eleven",
            "release_date": "2001-12-07",
            "character": "Rusty Ryan",
            "vote_average": 7.4,
            "overview": "Less than 24 hours into his parole, charismatic thief Danny Ocean is already rolling out his next plan: In one night, Danny's hand-picked crew of specialists will attempt to steal more than $150 million from three Las Vegas casinos. But to score the cash, Danny risks his chances of reconciling with ex-wife, Tess.",
            "credit_id": "52fe4220c3a36847f800616b"
          },
          {
            "poster_path": "/5Hjp3pOvvO4DBAId3dxUsuIpfEm.jpg",
            "adult": false,
            "backdrop_path": "/5ExqrHbEArqHAMAplGt95ttq5ps.jpg",
            "vote_count": 4302,
            "video": false,
            "id": 298,
            "popularity": 18.639,
            "genre_ids": [
              80,
              53
            ],
            "original_language": "en",
            "title": "Ocean's Thirteen",
            "original_title": "Ocean's Thirteen",
            "release_date": "2007-06-06",
            "character": "Rusty Ryan",
            "vote_average": 6.7,
            "overview": "Danny Ocean's team of criminals are back and composing a plan more personal than ever. When ruthless casino owner Willy Bank doublecrosses Reuben Tishkoff, causing a heart attack, Danny Ocean vows that he and his team will do anything to bring down Willy Bank along with everything he's got. Even if it means asking for help from an enemy.",
            "credit_id": "52fe4234c3a36847f800bf0f"
          },
          {
            "poster_path": "/bptfVGEQuv6vDTIMVCHjJ9Dz8PX.jpg",
            "adult": false,
            "backdrop_path": "/pCUdYAaarKqY2AAUtV6xXYO8UGY.jpg",
            "vote_count": 19612,
            "video": false,
            "id": 550,
            "popularity": 56.026,
            "genre_ids": [
              18
            ],
            "original_language": "en",
            "title": "Fight Club",
            "original_title": "Fight Club",
            "release_date": "1999-10-15",
            "character": "Tyler Durden",
            "vote_average": 8.4,
            "overview": "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \\"fight clubs\\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
            "credit_id": "52fe4250c3a36847f80149f7"
          },
          {
            "poster_path": "/eMftEiMCZPEtzzEFyYLjbNkgRQ5.jpg",
            "adult": false,
            "backdrop_path": "/2YJOXPl4QtCskixYA58ToyCXEW0.jpg",
            "vote_count": 7014,
            "video": false,
            "id": 787,
            "popularity": 25.007,
            "genre_ids": [
              28,
              35,
              18,
              53
            ],
            "original_language": "en",
            "title": "Mr. & Mrs. Smith",
            "original_title": "Mr. & Mrs. Smith",
            "release_date": "2005-06-07",
            "character": "John Smith",
            "vote_average": 6.6,
            "overview": "After five (or six) years of vanilla-wedded bliss, ordinary suburbanites John and Jane Smith are stuck in a huge rut. Unbeknownst to each other, they are both coolly lethal, highly-paid assassins working for rival organisations. When they discover they're each other's next target, their secret lives collide in a spicy, explosive mix of wicked comedy, pent-up passion, nonstop action and high-tech weaponry.",
            "credit_id": "52fe4276c3a36847f80208cb"
          },
          {
            "poster_path": "/urVlSfM8lVVKurnN5rWXx7t8Pz8.jpg",
            "adult": false,
            "backdrop_path": "/ihzoVuVzKaiellCtv9jOuHMYWXm.jpg",
            "vote_count": 1814,
            "video": false,
            "id": 819,
            "popularity": 14.738,
            "genre_ids": [
              80,
              18,
              53
            ],
            "original_language": "en",
            "title": "Sleepers",
            "original_title": "Sleepers",
            "release_date": "1996-10-18",
            "character": "Michael Sullivan",
            "vote_average": 7.5,
            "overview": "Two gangsters seek revenge on the state jail worker who during their stay at a youth prison sexually abused them. A sensational court hearing takes place to charge him for the crimes.",
            "credit_id": "52fe427bc3a36847f80222a7"
          },
          {
            "release_date": "2001-11-18",
            "adult": false,
            "vote_average": 6.9,
            "vote_count": 1246,
            "video": false,
            "title": "Spy Game",
            "popularity": 17.755,
            "genre_ids": [
              28,
              80,
              53
            ],
            "original_language": "en",
            "character": "Tom Bishop",
            "original_title": "Spy Game",
            "poster_path": "/6y8M1rxjKofQCRKKe6xeV91K2Fc.jpg",
            "id": 1535,
            "backdrop_path": "/nHnWAi55tEo822jVGwp50b3CH4D.jpg",
            "overview": "On the day of his retirement, a veteran CIA agent learns that his former protégé has been arrested in China, is sentenced to die the next morning in Beijing, and that the CIA is considering letting that happen to avoid an international scandal.",
            "credit_id": "52fe42fbc3a36847f8031727"
          },
          {
            "poster_path": "/3mDD62pgRhec4i8UP6TaoXQHkbm.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 49,
            "video": false,
            "id": 10917,
            "popularity": 5.383,
            "genre_ids": [
              80,
              18
            ],
            "original_language": "en",
            "title": "Too Young to Die?",
            "original_title": "Too Young to Die?",
            "release_date": "1990-02-26",
            "character": "Billy Canton",
            "vote_average": 5.4,
            "overview": "An abused 15 year old is charged with a murder that carries the death penalty in this fact-based story.",
            "credit_id": "52fe43d09251416c7501f331"
          },
          {
            "poster_path": "/9H2awZmNisMVJGp362Stv0bfUTs.jpg",
            "adult": false,
            "backdrop_path": "/dTHJPsThbySjaNXipIvt9qF3JLl.jpg",
            "vote_count": 8514,
            "video": false,
            "id": 4922,
            "popularity": 21.875,
            "genre_ids": [
              18,
              14,
              9648,
              53,
              10749
            ],
            "original_language": "en",
            "title": "The Curious Case of Benjamin Button",
            "original_title": "The Curious Case of Benjamin Button",
            "release_date": "2008-12-25",
            "character": "Benjamin Button",
            "vote_average": 7.5,
            "overview": "Born under unusual circumstances, Benjamin Button springs into being as an elderly man in a New Orleans nursing home and ages in reverse. Twelve years after his birth, he meets Daisy, a child who flits in and out of his life as she grows up to be a dancer. Though he has all sorts of unusual adventures over the course of his life, it is his relationship with Daisy, and the hope that they will come together at the right time, that drives Benjamin forward.",
            "credit_id": "52fe43e2c3a36847f807632f"
          },
          {
            "poster_path": "/ozecjGWL47TQ9mKrPg2Y3WTh2UJ.jpg",
            "adult": false,
            "backdrop_path": "/irpJXGiVr539uuspcQcNdkhS2lq.jpg",
            "vote_count": 4449,
            "video": false,
            "id": 38055,
            "popularity": 27.001,
            "genre_ids": [
              28,
              16,
              35,
              878,
              10751
            ],
            "original_language": "en",
            "title": "Megamind",
            "original_title": "Megamind",
            "release_date": "2010-10-28",
            "character": "Metro Man (voice)",
            "vote_average": 6.8,
            "overview": "Bumbling supervillain Megamind finally defeats his nemesis, the superhero Metro Man. But without a hero, he loses all purpose and must find new meaning to his life.",
            "credit_id": "52fe468e9251416c910583cd"
          },
          {
            "poster_path": "/2DVkCwOkTJDYgwc2WETXTcuFXVh.jpg",
            "adult": false,
            "backdrop_path": "/m6FQVpUBG69ZBzLcRLukIjGNz8p.jpg",
            "vote_count": 399,
            "video": false,
            "id": 314385,
            "popularity": 11.038,
            "genre_ids": [
              18,
              10749
            ],
            "original_language": "en",
            "title": "By the Sea",
            "original_title": "By the Sea",
            "release_date": "2015-11-12",
            "character": "Roland",
            "vote_average": 5.4,
            "overview": "Set in France during the mid-1970s, Vanessa, a former dancer, and her husband Roland, an American writer, travel the country together. They seem to be growing apart, but when they linger in one quiet, seaside town they begin to draw close to some of its more vibrant inhabitants, such as a local bar/café-keeper and a hotel owner.",
            "credit_id": "54a1c3c7c3a3680b2700ba58"
          },
          {
            "poster_path": "/iH5ZjHVbEt6bgeRsHnjzod8nKln.jpg",
            "adult": false,
            "backdrop_path": "/85TMMfCenRLPGJXdvFJHTwSaNeb.jpg",
            "vote_count": 42,
            "video": false,
            "id": 381690,
            "popularity": 3.17,
            "genre_ids": [],
            "original_language": "en",
            "title": "Sinbad and the Cyclops Island",
            "original_title": "Sinbad and the Cyclops Island",
            "release_date": "2003-11-18",
            "character": "Sinbad",
            "vote_average": 6,
            "overview": "Marina, Sinbad and his crew are resting on a small island. They soon find out they're not alone.",
            "credit_id": "56b82551c3a36806fc00e0f1"
          },
          {
            "poster_path": "/d1v5iJsEBQpu3KfOfr17n4olDOj.jpg",
            "adult": false,
            "backdrop_path": "/ndO3SRmmO3rgIKCXkspqt5bzH1E.jpg",
            "vote_count": 13,
            "video": false,
            "id": 373929,
            "popularity": 3.014,
            "genre_ids": [
              18,
              27
            ],
            "original_language": "en",
            "title": "Touch of Evil",
            "original_title": "Touch of Evil",
            "release_date": "2011-12-06",
            "character": "The Madman",
            "vote_average": 7,
            "overview": "Some of 2011's stand-out film actors appear in \\"a video gallery of cinematic villainy\\" for New York Times Magazine.",
            "credit_id": "567ae7ebc3a3684bcc0001be"
          },
          {
            "poster_path": "/6TzhA2MHCztJUGEqrVXcD3nWbl2.jpg",
            "adult": false,
            "backdrop_path": "/p04OwhvsoxgmdHQqflnDW8h3QBb.jpg",
            "vote_count": 13,
            "video": false,
            "id": 417198,
            "popularity": 2.436,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "title": "Voyage of Time: The IMAX Experience",
            "original_title": "Voyage of Time: The IMAX Experience",
            "release_date": "2016-10-07",
            "character": "Narrator (voice)",
            "vote_average": 6.7,
            "overview": "A celebration of the universe, displaying the whole of time, from its start to its final collapse. This film examines all that occurred to prepare the world that stands before us now: science and spirit, birth and death, the grand cosmos and the minute life systems of our planet. (Limited release IMAX version with narration by Brad Pitt.)",
            "credit_id": "57e2a101c3a3683a6c0002a5"
          },
          {
            "poster_path": "/wO8Mw2gXmTY1dKEVHUVNHvRgGN5.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 6,
            "video": false,
            "id": 213503,
            "popularity": 2.967,
            "genre_ids": [
              27,
              37,
              10752,
              10770
            ],
            "original_language": "en",
            "title": "Two-Fisted Tales",
            "original_title": "Two-Fisted Tales",
            "release_date": "1992-01-18",
            "character": "Billy (segment \\"King of the Road\\")",
            "vote_average": 4.1,
            "overview": "The foul-mouthed, wheelchair-bound Mr. Rush introduces three adventure tales based on the EC comics of the 1950's.  A 1992 star-studded made-for-tv film which was an attempt to launch a second series in the mold of Tales From The Crypt. When this failed to launch, the three tales were re-edited and shown as Crypt episodes.",
            "credit_id": "566b1da79251412dbc000476"
          },
          {
            "poster_path": "/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg",
            "adult": false,
            "backdrop_path": "/yB2hTgz9CTVYjlMWPSl3LPx5nWj.jpg",
            "vote_count": 6819,
            "video": false,
            "id": 466272,
            "popularity": 40.484,
            "genre_ids": [
              35,
              18,
              53
            ],
            "original_language": "en",
            "title": "Once Upon a Time… in Hollywood",
            "original_title": "Once Upon a Time… in Hollywood",
            "release_date": "2019-07-24",
            "character": "Cliff Booth",
            "vote_average": 7.5,
            "overview": "Los Angeles, 1969. TV star Rick Dalton, a struggling actor specializing in westerns, and stuntman Cliff Booth, his best friend, try to survive in a constantly changing movie industry. Dalton is the neighbor of the young and promising actress and model Sharon Tate, who has just married the prestigious Polish director Roman Polanski…",
            "credit_id": "5967b06392514132e1005850"
          },
          {
            "release_date": "",
            "adult": false,
            "vote_average": 0,
            "vote_count": 0,
            "video": false,
            "title": "He Wanted the Moon",
            "popularity": 0.84,
            "genre_ids": [
              18
            ],
            "original_language": "en",
            "character": "",
            "original_title": "He Wanted the Moon",
            "poster_path": null,
            "id": 384678,
            "backdrop_path": null,
            "overview": "In the 1920s, Dr. Perry Baird, who was born in Texas and educated at Harvard, begins his career ascent in the field of medicine.",
            "credit_id": "5b269d119251410d810129a3"
          },
          {
            "poster_path": "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
            "adult": false,
            "backdrop_path": "/AeDS2MKGFy6QcjgWbJBde0Ga6Hd.jpg",
            "vote_count": 3914,
            "video": false,
            "id": 419704,
            "popularity": 138.843,
            "genre_ids": [
              18,
              878
            ],
            "original_language": "en",
            "title": "Ad Astra",
            "original_title": "Ad Astra",
            "release_date": "2019-09-17",
            "character": "Roy McBride",
            "vote_average": 6.1,
            "overview": "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.",
            "credit_id": "5e93b22dd55e4d001a19f94a"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 0,
            "video": false,
            "id": 718930,
            "popularity": 0.6,
            "genre_ids": [
              28
            ],
            "original_language": "en",
            "title": "Bullet Train",
            "original_title": "Bullet Train",
            "release_date": "",
            "character": "",
            "vote_average": 0,
            "overview": "The film is based on the Japanese novel “Maria Beetle” by best-selling author Kotaro Isaka.",
            "credit_id": "5f03b34e5545ca0036d8294e"
          },
          {
            "release_date": "",
            "adult": false,
            "vote_average": 0,
            "vote_count": 0,
            "video": false,
            "title": "Softbank",
            "popularity": 0.84,
            "genre_ids": [],
            "original_language": "en",
            "character": "",
            "original_title": "Softbank",
            "poster_path": "/ordVEIgniFPVPcociHgiCEHVGGs.jpg",
            "id": 722753,
            "backdrop_path": null,
            "overview": "Wes Anderson directed this commerical for the Japanese cell phone company SoftBank",
            "credit_id": "5f05921bdbf144003509a6ea"
          },
          {
            "poster_path": "/2F9KcDGZbEdaQN5jV9ziyRZYY7u.jpg",
            "adult": false,
            "backdrop_path": "/cuVLwG51u6QPDN4GlGSdJBO1yJA.jpg",
            "vote_count": 5316,
            "video": false,
            "id": 63,
            "popularity": 28.582,
            "genre_ids": [
              9648,
              878,
              53
            ],
            "original_language": "en",
            "title": "Twelve Monkeys",
            "original_title": "Twelve Monkeys",
            "release_date": "1995-12-29",
            "character": "Jeffrey Goines",
            "vote_average": 7.6,
            "overview": "In the year 2035, convict James Cole reluctantly volunteers to be sent back in time to discover the origin of a deadly virus that wiped out nearly all of the earth's population and forced the survivors into underground communities. But when Cole is mistakenly sent to 1990 instead of 1996, he's arrested and locked up in a mental hospital. There he meets psychiatrist Dr. Kathryn Railly, and patient Jeffrey Goines, the son of a famous virus expert, who may hold the key to the mysterious rogue group, the Army of the 12 Monkeys, thought to be responsible for unleashing the killer disease.",
            "credit_id": "52fe4212c3a36847f8001b39"
          },
          {
            "release_date": "2008-09-05",
            "adult": false,
            "vote_average": 6.6,
            "vote_count": 2964,
            "video": false,
            "title": "Burn After Reading",
            "popularity": 18.986,
            "genre_ids": [
              35,
              18
            ],
            "original_language": "en",
            "character": "Chad Feldheimer",
            "original_title": "Burn After Reading",
            "poster_path": "/jdwSkQu3XirmX18MNj8CqFWsCk.jpg",
            "id": 4944,
            "backdrop_path": "/w2O9nM7dckWaUqmCbiWZSBHStpi.jpg",
            "overview": "When a disc containing memoirs of a former CIA analyst falls into the hands of gym employees, Linda and Chad, they see a chance to make enough money for Linda to have life-changing cosmetic surgery. Predictably, events whirl out of control for the duo, and those in their orbit.",
            "credit_id": "52fe43e6c3a36847f8076fe7"
          },
          {
            "poster_path": "/xoeX7DIHRU90KuSNNsDWoYqhrJL.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 14,
            "video": false,
            "id": 30565,
            "popularity": 4.603,
            "genre_ids": [
              99,
              878
            ],
            "original_language": "en",
            "title": "The Hamster Factor and Other Tales of Twelve Monkeys",
            "original_title": "The Hamster Factor and Other Tales of Twelve Monkeys",
            "release_date": "1996-11-05",
            "character": "Himself",
            "vote_average": 6.4,
            "overview": "A documentary following Terry Gilliam through the creation of \\"12 Monkeys\\"",
            "credit_id": "52fe44259251416c91006683"
          },
          {
            "release_date": "1989-07-01",
            "adult": false,
            "vote_average": 4.8,
            "vote_count": 42,
            "video": false,
            "title": "Cutting Class",
            "popularity": 4.603,
            "genre_ids": [
              27
            ],
            "original_language": "en",
            "character": "Dwight Ingalls",
            "original_title": "Cutting Class",
            "poster_path": "/o0PYYaN9JRrm66C42HhjdxwxNVM.jpg",
            "id": 21799,
            "backdrop_path": "/kLtAh588N91zZup6UIubGPQMisJ.jpg",
            "overview": "High school student Paula Carson's affections are being sought after by two of her classmates: Dwight, the \\"bad boy\\", and Brian, a disturbed young man who has just been released from a mental hospital where he was committed following the suspicious death of his father. Soon after being released, more murders start happening. Is Brian back to his old tricks, or is Dwight just trying to eliminate the competition?",
            "credit_id": "52fe4428c3a368484e012c37"
          },
          {
            "poster_path": "/mqzRUHNtFwmgJCmSnvq3JnX0xgZ.jpg",
            "adult": false,
            "backdrop_path": "/9ODXpqiiBCZPQGQt4kkO5fQjasI.jpg",
            "vote_count": 349,
            "video": false,
            "id": 14239,
            "popularity": 13.762,
            "genre_ids": [
              16,
              35,
              14
            ],
            "original_language": "en",
            "title": "Cool World",
            "original_title": "Cool World",
            "release_date": "1992-07-10",
            "character": "Detective Frank Harris",
            "vote_average": 5.1,
            "overview": "Jack Deebs is a cartoonist who is due to be released from jail. His comic book \\"Cool World\\" describes a zany world populated by \\"doodles\\" (cartoon characters) and \\"noids\\" (humanoids). What Jack didn't realize is that Cool World really does exist, and a \\"doodle\\" scientist has just perfected a machine which links Cool World with our world. Intrigued at seeing his creating come to life, Jack is nonetheless wary as he knows that not everything in Cool World is exactly friendly.",
            "credit_id": "52fe45dd9251416c75065151"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 54,
            "video": true,
            "id": 17171,
            "popularity": 4.025,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "title": "The Assassination of Jesse James: Death of an Outlaw",
            "original_title": "The Assassination of Jesse James: Death Of An Outlaw",
            "release_date": "2008-01-01",
            "character": "Himself",
            "vote_average": 6.6,
            "overview": "Explores the true story of the notorious Jesse James, how the myth developed during his lifetime, and how the legends have persisted over 100 years after his death at the hands of his former friend, Robert Ford.",
            "credit_id": "5591282992514175860008b2"
          },
          {
            "release_date": "2015-10-03",
            "adult": false,
            "vote_average": 6.4,
            "vote_count": 73,
            "video": false,
            "title": "The Audition",
            "popularity": 7.23,
            "genre_ids": [
              35
            ],
            "original_language": "en",
            "character": "Himself",
            "original_title": "The Audition",
            "poster_path": "/t1PDIeDpJGgI9JPqIRMuG7WDdId.jpg",
            "id": 365717,
            "backdrop_path": "/54tR3SVqtoH80szs9M4YKJuJfGT.jpg",
            "overview": "Robert De Niro and Leonardo DiCaprio must compete for the lead role in Martin Scorsese's next film.",
            "credit_id": "5630ca08c3a3681b4d011675"
          },
          {
            "poster_path": "/ofBcSUYZ4Qa5eqE2FRnOcNQqTIC.jpg",
            "adult": false,
            "backdrop_path": "/lICzBM3wHXwgHexbX5ogdznpGJJ.jpg",
            "vote_count": 19,
            "video": false,
            "id": 50463,
            "popularity": 4.185,
            "genre_ids": [
              35,
              10749
            ],
            "original_language": "en",
            "title": "The Favor",
            "original_title": "The Favor",
            "release_date": "1994-04-29",
            "character": "Elliott Fowler",
            "vote_average": 4.7,
            "overview": "Kathy is married to Peter. Now she can't help but wonder how things could have been if she got together with her old boyfriend, Tom. Being married prevents from doing that so she asks her friend, Emily to go to him and see if she can sleep with him then tell Kathy how it was. When Emily tells Kathy that things were awesome, their friendship suffers, at the same so does Kathy's marriage. Things get even more complicated when Emily learns she's pregnant, and she's not certain if it's Tom's or her boyfriend, Elliot.",
            "credit_id": "52fe47c8c3a36847f8147ff5"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 6,
            "video": false,
            "id": 244743,
            "popularity": 1.432,
            "genre_ids": [],
            "original_language": "en",
            "title": "Contact",
            "original_title": "Contact",
            "release_date": "1992-01-01",
            "character": "",
            "vote_average": 7.5,
            "overview": "An American soldier and an Arab soldier confront each other during wartime in the desert, each hoping to kill the other. But in order to survive, they must lay down their arms and cooperate.",
            "credit_id": "52fe4ef6c3a36847f82b3c95"
          },
          {
            "poster_path": "/isuQWbJPbjybBEWdcCaBUPmU0XO.jpg",
            "adult": false,
            "backdrop_path": "/cU7lZD7EMZ2ijHasEH7zjIpNU32.jpg",
            "vote_count": 5892,
            "video": false,
            "id": 318846,
            "popularity": 28.505,
            "genre_ids": [
              35,
              18
            ],
            "original_language": "en",
            "title": "The Big Short",
            "original_title": "The Big Short",
            "release_date": "2015-12-11",
            "character": "Ben Rickert",
            "vote_average": 7.3,
            "overview": "The men who made millions from a global economic meltdown.",
            "credit_id": "55187d59c3a36862f6004854"
          },
          {
            "release_date": "2002-05-31",
            "adult": false,
            "vote_average": 0,
            "vote_count": 0,
            "video": false,
            "title": "Jeff Buckley: Everybody Here Wants You",
            "popularity": 0.841,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "character": "Himself",
            "original_title": "Jeff Buckley: Everybody Here Wants You",
            "poster_path": "/4n9iuTzpvmxnwMqBtx7fEb1k6Gf.jpg",
            "id": 594392,
            "backdrop_path": null,
            "overview": "Retrospective look at the life and music of Jeff Buckley through the eyes of family, friends, and fans.",
            "credit_id": "5ccffa9592514104562d7863"
          },
          {
            "poster_path": "/unqjXZpTEl3rJhYPJncd0uWEZ1X.jpg",
            "adult": false,
            "backdrop_path": "/44TrrgjP77fRExGyuhp08g3W2WE.jpg",
            "vote_count": 1256,
            "video": false,
            "id": 109091,
            "popularity": 11.794,
            "genre_ids": [
              80,
              18,
              53
            ],
            "original_language": "en",
            "title": "The Counselor",
            "original_title": "The Counselor",
            "release_date": "2013-10-25",
            "character": "Westray",
            "vote_average": 5.1,
            "overview": "A lawyer finds himself in far over his head when he attempts to get involved in drug trafficking.",
            "credit_id": "52fe4aaac3a36847f81db47d"
          },
          {
            "poster_path": "/jF5lnDKsidNau5fM0dCsybnvE8V.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 0,
            "video": false,
            "id": 576131,
            "popularity": 0.878,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "title": "Voom Portraits",
            "original_title": "Voom Portraits",
            "release_date": "2007-01-17",
            "character": "",
            "vote_average": 0,
            "overview": "Iconic artist and theater director Robert Wilson has created a series of video portraits of celebrities, ordinary people and animals called \\"VOOM Portraits.\\" Known for his glacier-paced theatrical productions with Tom Waits and Lou Reed, Wilson's now bringing his aesthetic to a video format. The recent developments in HD technology have allowed Wilson to create something like a precise hybrid of still photography and motion pictures. Actors such as Brad Pitt (as a crazy person on the streets in the rain), Isabelle Huppert (as Greta Garbo), Steve Buscemi (as a mad butcher chewing gum on a variety show), Robert Downey Jr. (as a dreaming corpse in a Rembrandt painting), and Winona Ryder (as Winnie, the main female character in Samuel Beckett’s Happy Days, buried up to her neck in sand) were asked to “think of nothing\\" and move slowly and steadily to collaborate in Wilson's vision of who they might be.",
            "credit_id": "5c4220610e0a2655c494f3ed"
          },
          {
            "release_date": "2009-05-05",
            "adult": false,
            "vote_average": 6.3,
            "vote_count": 6,
            "video": false,
            "title": "The Curious Birth of Benjamin Button",
            "popularity": 3.005,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "character": "Himself",
            "original_title": "The Curious Birth of Benjamin Button",
            "poster_path": null,
            "id": 585240,
            "backdrop_path": null,
            "overview": "A documentary about the making of David Fincher's 2008 film THE CURIOUS CASE OF BENJAMIN BUTTON. Virtually every element in the evolution of the Fincher's film is documented here, from the project's attachment to numerous other directors during the 1990s, to its shoot in 2006 and 2007 in New Orleans, to its complex, CGI-intensive postproduction process.",
            "credit_id": "5c77489ec3a36842bd9072bb"
          },
          {
            "poster_path": "/cQaqpwN5Nq0GNNKE1hIgYLpLlca.jpg",
            "adult": false,
            "backdrop_path": "/1l3SDZas8FSceRA78Dvy2oQHq5u.jpg",
            "vote_count": 1915,
            "video": false,
            "id": 1541,
            "popularity": 17.131,
            "genre_ids": [
              12,
              80,
              18,
              53
            ],
            "original_language": "en",
            "title": "Thelma & Louise",
            "original_title": "Thelma & Louise",
            "release_date": "1991-05-24",
            "character": "J.D.",
            "vote_average": 7.5,
            "overview": "Whilst on a short weekend getaway, Louise shoots a man who had tried to rape Thelma. Due to the incriminating circumstances, they make a run for it and thus a cross country chase ensues for the two fugitives. Along the way, both women rediscover the strength of their friendship and surprising aspects of their personalities and self-strengths in the trying times.",
            "credit_id": "52fe42fbc3a36847f8031a6d"
          },
          {
            "poster_path": "/dgD5Up4F5j4G3K3cYdODyUZvOho.jpg",
            "adult": false,
            "backdrop_path": "/vrJlJD4fSFw79uZtGog6SFeNrzQ.jpg",
            "vote_count": 668,
            "video": false,
            "id": 4912,
            "popularity": 11.334,
            "genre_ids": [
              35,
              80,
              18,
              53,
              10749
            ],
            "original_language": "en",
            "title": "Confessions of a Dangerous Mind",
            "original_title": "Confessions of a Dangerous Mind",
            "release_date": "2002-12-30",
            "character": "Brad, 1st Bachelor",
            "vote_average": 6.8,
            "overview": "Television made him famous, but his biggest hits happened off screen. Television producer by day, CIA assassin by night, Chuck Barris was recruited by the CIA at the height of his TV career and trained to become a covert operative. Or so Barris said.",
            "credit_id": "52fe43e2c3a36847f807610f"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 4,
            "video": false,
            "id": 209340,
            "popularity": 3.459,
            "genre_ids": [
              80,
              18,
              53
            ],
            "original_language": "en",
            "title": "A Stoning in Fulham County",
            "original_title": "A Stoning in Fulham County",
            "release_date": "1988-10-24",
            "character": "Teddy Johnson",
            "vote_average": 6,
            "overview": "Religious beliefs clash with the law when an Amish infant is killed in a rural community.",
            "credit_id": "57f2dee39251410c280034d9"
          },
          {
            "poster_path": "/3ekqpIww56hYDSsVFU7GcNfoBGv.jpg",
            "adult": false,
            "backdrop_path": "/9SR8WDtMjU9pPF1hvRilYyck3Eb.jpg",
            "vote_count": 36,
            "video": false,
            "id": 55059,
            "popularity": 6.129,
            "genre_ids": [
              35,
              10749
            ],
            "original_language": "en",
            "title": "Happy Together",
            "original_title": "Happy Together",
            "release_date": "1989-05-04",
            "character": "Brian",
            "vote_average": 5.8,
            "overview": "Christopher is an ambitious college freshman, striving to become a writer. Through a computer fault he's assigned the same room as Alex, a real party freak and... a girl! He's annoyed and tries to get a different room as soon as possible, but when he learns to know her, he also starts to like her. She not only improves his sexual life, but also his writing skills",
            "credit_id": "52fe48b9c3a36847f81761cb"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 5,
            "video": true,
            "id": 357659,
            "popularity": 2.5,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "title": "Making 'Snatch'",
            "original_title": "Making 'Snatch'",
            "release_date": "2001-07-03",
            "character": "Himself",
            "vote_average": 5.8,
            "overview": "The making of Guy Ritchie's 'Snatch'.",
            "credit_id": "55e77bc99251413e450000fb"
          },
          {
            "poster_path": "/jBQtcaXXy6gtxHwOYmZ0Hpjnbpx.jpg",
            "adult": false,
            "backdrop_path": "/uvfYk8mwX1DrHoDcTyJLf83mFvl.jpg",
            "vote_count": 1604,
            "video": false,
            "id": 319,
            "popularity": 17.418,
            "genre_ids": [
              28,
              80,
              53,
              10749
            ],
            "original_language": "en",
            "title": "True Romance",
            "original_title": "True Romance",
            "release_date": "1993-09-09",
            "character": "Floyd",
            "vote_average": 7.5,
            "overview": "Clarence marries hooker Alabama, steals cocaine from her pimp, and tries to sell it in Hollywood, while the owners of the coke try to reclaim it.",
            "credit_id": "52fe4237c3a36847f800cdd3"
          },
          {
            "poster_path": "/2gWiQ4mn85jcXtREVePlVViupeV.jpg",
            "adult": false,
            "backdrop_path": "/jiY7dnAtkvM1UykifM0RJAhZLY6.jpg",
            "vote_count": 933,
            "video": false,
            "id": 65759,
            "popularity": 13.432,
            "genre_ids": [
              16,
              35,
              10751
            ],
            "original_language": "en",
            "title": "Happy Feet Two",
            "original_title": "Happy Feet Two",
            "release_date": "2011-11-17",
            "character": "Will (voice)",
            "vote_average": 6,
            "overview": "Mumble the penguin has a problem: his son Erik, who is reluctant to dance, encounters The Mighty Sven, a penguin who can fly! Things get worse for Mumble when the world is shaken by powerful forces, causing him to brings together the penguin nations and their allies to set things right.",
            "credit_id": "52fe4718c3a368484e0b4d23"
          },
          {
            "release_date": "2013-10-18",
            "adult": false,
            "vote_average": 8,
            "vote_count": 8079,
            "video": false,
            "title": "12 Years a Slave",
            "popularity": 21.475,
            "genre_ids": [
              18,
              36
            ],
            "original_language": "en",
            "character": "Samuel Bass",
            "original_title": "12 Years a Slave",
            "poster_path": "/xdANQijuNrJaw1HA61rDccME4Tm.jpg",
            "id": 76203,
            "backdrop_path": "/4Bb1kMIfrT2tYRZ9M6Jhqy6gkeF.jpg",
            "overview": "In the pre-Civil War United States, Solomon Northup, a free black man from upstate New York, is abducted and sold into slavery. Facing cruelty as well as unexpected kindnesses Solomon struggles not only to stay alive, but to retain his dignity. In the twelfth year of his unforgettable odyssey, Solomon’s chance meeting with a Canadian abolitionist will forever alter his life.",
            "credit_id": "52fe492cc3a368484e11dfa3"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 4,
            "video": false,
            "id": 109404,
            "popularity": 3.513,
            "genre_ids": [],
            "original_language": "en",
            "title": "8",
            "original_title": "8",
            "release_date": "2012-03-03",
            "character": "Chief Judge Vaughn R. Walker",
            "vote_average": 8.5,
            "overview": "\\"8\\"—a new play by Academy-award winning screenwriter Dustin Lance Black (Milk, J. Edgar)—demystifies the debate around marriage equality by chronicling the landmark trial of Perry v. Schwarzenegger. A one time show was done live on youtube with a superstar cast",
            "credit_id": "52fe4ab2c3a36847f81dcd13"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 6,
            "video": false,
            "id": 63472,
            "popularity": 4.935,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "title": "His Way",
            "original_title": "His Way",
            "release_date": "2011-03-04",
            "character": "Himself",
            "vote_average": 5.8,
            "overview": "A look at the professional, political and personal life of legendary movie producer Jerry Weintraub featuring interviews with friends, family and colleagues.",
            "credit_id": "5dd17177fd6fa100127f54c7"
          },
          {
            "release_date": "1990-01-27",
            "adult": false,
            "vote_average": 6,
            "vote_count": 2,
            "video": false,
            "title": "The Image",
            "popularity": 2.651,
            "genre_ids": [
              18
            ],
            "original_language": "en",
            "character": "Steve Black",
            "original_title": "The Image",
            "poster_path": "/vuD1urChmeSowIQdOFNmDwqeoND.jpg",
            "id": 75451,
            "backdrop_path": null,
            "overview": "Jason Cromwell, a TV-news anchorman, wrongly implicates a good friend in a savings-and-loan scandal.",
            "credit_id": "52fe4900c3a368484e115b63"
          },
          {
            "release_date": "2003-02-04",
            "adult": false,
            "vote_average": 8.6,
            "vote_count": 7,
            "video": false,
            "title": "Thelma & Louise: The Last Journey",
            "popularity": 4.32,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "character": "Himself",
            "original_title": "Thelma & Louise: The Last Journey",
            "poster_path": null,
            "id": 327962,
            "backdrop_path": null,
            "overview": "Nearly every major element of making the 1991 film Thelma & Louise is examined here from how the script was written to how Ridley Scott got involved, to how the big tanker explosion was pulled off. Some funny stories are shared and some great trivia as to what was improvised on set and actually left in the film.",
            "credit_id": "54f2c5d49251416b41003a02"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 3,
            "video": true,
            "id": 460224,
            "popularity": 3.341,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "title": "Truth of the Situation: Making 'The Counselor'",
            "original_title": "Truth of the Situation: Making 'The Counselor'",
            "release_date": "2014-02-11",
            "character": "Himself",
            "vote_average": 3.7,
            "overview": "A 13-segment documentary examining production aspects of \\"The Counselor\\" (2013):  Tragic Consequences  A Different Southwest  The Counselor  Pool Party  Reiner  Laura  Malkina  Polo Club  Lensing the Dark World  Westray  Downward Spiral  The Cheetahs  The Bolito",
            "credit_id": "593210729251417ddc002525"
          },
          {
            "poster_path": "/1GY0ZhAxOR2RgxGnOkeKoKb2mFM.jpg",
            "adult": false,
            "backdrop_path": "/9Ay480Yj5v3fj5zaUiA9cerPfm2.jpg",
            "vote_count": 165,
            "video": false,
            "id": 13703,
            "popularity": 7.937,
            "genre_ids": [
              80,
              18,
              10749
            ],
            "original_language": "en",
            "title": "Less than Zero",
            "original_title": "Less than Zero",
            "release_date": "1987-11-06",
            "character": "Partygoer / Preppie Kid at Fight (uncredited)",
            "vote_average": 6.4,
            "overview": "A college freshman returns to Los Angeles for the holidays at his ex-girlfriend's request, but discovers that his former best friend has an out-of-control drug habit.",
            "credit_id": "5953d01192514168bf00bf4b"
          },
          {
            "poster_path": "/kfgd0S4eKrfstZB2F8eOoyo6MFR.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 0,
            "video": false,
            "id": 319714,
            "popularity": 0.924,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "title": "His Highness Hollywood",
            "original_title": "His Highness Hollywood",
            "release_date": "2008-09-20",
            "character": "Himself",
            "vote_average": 0,
            "overview": "Ian Halperin poses as a gay wannabe actor and member of the Israeli royal family to get an inside look at the Hollywood industry in this companion film to his well-received book, Hollywood Undercover: Revealing the Sordid Secrets of Tinseltown. Along the way, he receives a promise from the Church of Scientology to cure his homosexuality and gets the inside scoop from numerous luminaries -- including Brad Pitt, Jay Leno and Leonardo DiCaprio.",
            "credit_id": "59e392f59251410b67000268"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 2,
            "video": false,
            "id": 292790,
            "popularity": 1.366,
            "genre_ids": [],
            "original_language": "en",
            "title": "Exploring The Tree of Life",
            "original_title": "Exploring The Tree of Life",
            "release_date": "2011-10-11",
            "character": "Himself",
            "vote_average": 6.5,
            "overview": "A documentary on Terrence Malick and the making of his film \\"The Tree of Life.\\"",
            "credit_id": "5b98b0680e0a263dc3006524"
          },
          {
            "poster_path": "/wsNqYCfkU9iaeq1AfEl39DhEwWQ.jpg",
            "adult": false,
            "backdrop_path": "/x7F61yJvPkIABmfXRNu6heEKkd3.jpg",
            "vote_count": 9,
            "video": false,
            "id": 32227,
            "popularity": 3.825,
            "genre_ids": [
              35,
              14
            ],
            "original_language": "en",
            "title": "Hunk",
            "original_title": "Hunk",
            "release_date": "1987-03-06",
            "character": "Guy at Beach with Drink",
            "vote_average": 4.6,
            "overview": "A \\"devilish\\" tale about an ordinary guy who is visited by a beautiful apparition promising him popularity and drop-dead good looks in exchange for his soul. Transformed overnight into a \\"hunk,\\" he soon discovers there may be hell to pay for his new lifestyle!",
            "credit_id": "555a3ee0c3a368777200cbe8"
          },
          {
            "poster_path": "/ywtQ9gZf4rpVAxyoiXlNKkI2HFz.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 54,
            "video": false,
            "id": 15186,
            "popularity": 8.111,
            "genre_ids": [
              35,
              18,
              10749
            ],
            "original_language": "en",
            "title": "Full Frontal",
            "original_title": "Full Frontal",
            "release_date": "2002-08-02",
            "character": "Himself",
            "vote_average": 4.9,
            "overview": "A contemporary comedy set in Los Angeles, Full Frontal traces the complicated relationship among seven friends as they deal with the fragile connections that bind them together. Full Frontal takes place during a twenty-four hour period - a day in the life of missed connections.",
            "credit_id": "557df105c3a36821a600046d"
          },
          {
            "poster_path": "/1wLr7yAt9atj7xDstmhXYVnd6Et.jpg",
            "adult": false,
            "backdrop_path": "/9F6zZuETJWUtkcSEnOc0JLqBHAK.jpg",
            "vote_count": 359,
            "video": false,
            "id": 10083,
            "popularity": 11.525,
            "genre_ids": [
              28,
              18,
              53
            ],
            "original_language": "en",
            "title": "No Way Out",
            "original_title": "No Way Out",
            "release_date": "1987-08-14",
            "character": "Party Guest",
            "vote_average": 7,
            "overview": "Navy Lt. Tom Farrell meets a young woman, Susan Atwell , and they share a passionate fling. Farrell then finds out that his superior, Defense Secretary David Brice, is also romantically involved with Atwell. When the young woman turns up dead, Farrell is put in charge of the murder investigation. He begins to uncover shocking clues about the case, but when details of his encounter with Susan surface, he becomes a suspect as well.",
            "credit_id": "5d449cc50f2fbd0011ed264c"
          },
          {
            "poster_path": "/to0spRl1CMDvyUbOnbb4fTk3VAd.jpg",
            "adult": false,
            "backdrop_path": "/3P52oz9HPQWxcwHOwxtyrVV1LKi.jpg",
            "vote_count": 11668,
            "video": false,
            "id": 383498,
            "popularity": 36.621,
            "genre_ids": [
              28,
              12,
              35
            ],
            "original_language": "en",
            "title": "Deadpool 2",
            "original_title": "Deadpool 2",
            "release_date": "2018-05-10",
            "character": "Telford Porter / Vanisher",
            "vote_average": 7.5,
            "overview": "Wisecracking mercenary Deadpool battles the evil and powerful Cable and other bad guys to save a boy's life.",
            "credit_id": "5afb5d1892514114ed00395d"
          },
          {
            "poster_path": "/8TcXwhS8HbXLXC1hadEvesf8wwb.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 0,
            "video": false,
            "id": 574379,
            "popularity": 2.102,
            "genre_ids": [
              99,
              10752
            ],
            "original_language": "en",
            "title": "Beyond All Boundaries",
            "original_title": "Beyond All Boundaries",
            "release_date": "2009-11-09",
            "character": "Sgt. Bill Mauldin",
            "vote_average": 0,
            "overview": "A visual, 4-D experience of the battles of World War II featuring stories, archival footage and advanced special effects.",
            "credit_id": "5c38adbfc3a368267e5d789a"
          },
          {
            "poster_path": "/l0JyMZsotk0AzulphEDEDusCg6f.jpg",
            "adult": false,
            "backdrop_path": "/dk1OPZcIUF9MEFdK13mS8lYYmmR.jpg",
            "vote_count": 48,
            "video": false,
            "id": 34379,
            "popularity": 7.185,
            "genre_ids": [
              28,
              80,
              18,
              53
            ],
            "original_language": "en",
            "title": "No Man's Land",
            "original_title": "No Man's Land",
            "release_date": "1987-10-23",
            "character": "Waiter (uncredited)",
            "vote_average": 6.1,
            "overview": "A rookie cop goes undercover to infiltrate a gang of car thieves led by smooth and charming Ted. The rookie becomes too involved and starts to enjoy the thrill and lifestyle of the game, and becomes romanticly involved with the leaders sister.",
            "credit_id": "58d4c1ea92514103d200fea2"
          },
          {
            "poster_path": "/5Ka49BWWyKMXr93YMbH5wLN7aAM.jpg",
            "adult": false,
            "backdrop_path": "/7RqpTZq0mPpTcEwZ6qqwRZAFoLe.jpg",
            "vote_count": 383,
            "video": false,
            "id": 567604,
            "popularity": 16.093,
            "genre_ids": [
              28,
              35
            ],
            "original_language": "en",
            "title": "Once Upon a Deadpool",
            "original_title": "Once Upon a Deadpool",
            "release_date": "2018-12-11",
            "character": "Telford Porter / Vanisher",
            "vote_average": 6.9,
            "overview": "A kidnapped Fred Savage is forced to endure Deadpool's PG-13 rendition of Deadpool 2 as a Princess Bride-esque story that's full of magic, wonder & zero F's.",
            "credit_id": "5c0e557f0e0a2638cc0c2766"
          },
          {
            "poster_path": "/zMGmnxe7Lap6Ek1ZxIzdAdbuJeJ.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 21,
            "video": true,
            "id": 68996,
            "popularity": 8.952,
            "genre_ids": [
              28,
              99
            ],
            "original_language": "en",
            "title": "Ultimate Fights from the Movies",
            "original_title": "Ultimate Fights from the Movies",
            "release_date": "2002-04-16",
            "character": "Mickey O'Neil (Snatch) (archive footage)",
            "vote_average": 4.8,
            "overview": "In their second film compilation following their 'Boogeymen:The Killer Compilation' series, FlixMix takes you into the history of action movies from Hollywood to Hong Kong cinema that spans a 20-year period. This one features action scenes from 16 action-packed movies featuring action gurus, Jet Li, Michelle Yeoh, Chow Yun-Fat, Jackie Chan, Jean-Claude Van Damme and many more.",
            "credit_id": "52fe47b4c3a368484e0d520b"
          },
          {
            "release_date": "2020-04-10",
            "adult": false,
            "vote_average": 7.1,
            "vote_count": 11,
            "video": false,
            "title": "Out of Shadows",
            "popularity": 7.173,
            "genre_ids": [
              99
            ],
            "original_language": "en",
            "character": "Self (archive footage)",
            "original_title": "Out of Shadows",
            "poster_path": "/gj3y9AAOYPmCJVArTSTKabNnNUd.jpg",
            "id": 691930,
            "backdrop_path": "/mFBka9jCU7x6xJEoUj0vTrkd1Q4.jpg",
            "overview": "\\"Out of Shadows\\" lifts the mask on how the mainstream media and Hollywood manipulate and control the masses by spreading propaganda throughout their content. Our goal is to wake up the general public by shedding light on how we all have been lied to and brainwashed by a hidden enemy with a sinister agenda. This project is the result of two years of blood, sweat, and tears by a team of woke professionals. It's been independently produced and funded and is available on many different platforms for free for anyone to watch.",
            "credit_id": "5e9cbbe51941860025d1b3a4"
          },
          {
            "poster_path": "/wfWSRcQRmEw3u5myacurSf57M8x.jpg",
            "adult": false,
            "backdrop_path": null,
            "vote_count": 0,
            "video": false,
            "id": 499117,
            "popularity": 1.055,
            "genre_ids": [
              35,
              18
            ],
            "original_language": "en",
            "title": "Abby Singer",
            "original_title": "Abby Singer",
            "release_date": "2003-10-28",
            "character": "Himself",
            "vote_average": 0,
            "overview": "Chronicles the life of Curtis Clemins, who is torn between the love of his life and accomplishing his dream. When hitting rock bottom during the Sundance Film Festival, Clemins' calls upon his old college chum, Kevin Prouse, giving the now drunken acting instructor in the throes of a divorce, the only clue that will salvage Clemins' rapidly deteriorating life.",
            "credit_id": "5a5e9594c3a368385e000177"
          },
          {
            "poster_path": null,
            "adult": false,
            "backdrop_path": null,
            "vote_count": 6,
            "video": false,
            "id": 40196,
            "popularity": 5.352,
            "genre_ids": [
              99,
              10402
            ],
            "original_language": "en",
            "title": "America: A Tribute to Heroes",
            "original_title": "America: A Tribute to Heroes",
            "release_date": "2001-09-21",
            "character": "",
            "vote_average": 6,
            "overview": "A benefit concert and telethon organized by George Clooney and broadcast uninterrupted and commercial-free by the four major television networks just 10 days after the September 11, 2001 attacks on the World Trade Center and The Pentagon to raise money for the victims and their families,",
            "credit_id": "5e9bd22337109700224795e8"
          },
          {
            "poster_path": "/oS3zTDxqHtyKDidHHvG66P7Mcg.jpg",
            "adult": false,
            "backdrop_path": "/2duvg8bPkSKq5pekqzBgwyCYAxI.jpg",
            "vote_count": 2664,
            "video": false,
            "id": 492,
            "popularity": 19.407,
            "genre_ids": [
              35,
              18,
              14
            ],
            "original_language": "en",
            "title": "Being John Malkovich",
            "original_title": "Being John Malkovich",
            "release_date": "1999-10-29",
            "character": "Himself (uncredited)",
            "vote_average": 7.4,
            "overview": "One day at work, unsuccessful puppeteer Craig finds a portal into the head of actor John Malkovich. The portal soon becomes a passion for anybody who enters its mad and controlling world of overtaking another human body.",
            "credit_id": "593e5891c3a3680f1402babb"
          }
        ],
        "crew": [
          {
            "id": 402970,
            "department": "Crew",
            "original_language": "en",
            "original_title": "Notes on an American Film Director at Work",
            "job": "Thanks",
            "overview": "Filmmaker Jonas Mekas follows his friend, film director Martin Scorsese, and his cast and crew, through various locations during the shooting of his film The Departed, released in 2006.",
            "genre_ids": [
              99
            ],
            "video": false,
            "credit_id": "5ebdf4f1bc8abc0022c2e548",
            "release_date": "2008-01-01",
            "popularity": 2.445,
            "vote_average": 0,
            "vote_count": 0,
            "title": "Notes on an American Film Director at Work",
            "adult": false,
            "backdrop_path": "/1Q0FrRbywFPjseam7mwt6MYKXe7.jpg",
            "poster_path": "/8Ah2goGOhoR1i7jwOOaie10reoS.jpg"
          },
          {
            "id": 1422,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Departed",
            "job": "Producer",
            "overview": "To take down South Boston's Irish Mafia, the police send in one of their own to infiltrate the underworld, not realizing the syndicate has done likewise. While an undercover cop curries favor with the mob kingpin, a career criminal rises through the police ranks. But both sides soon discover there's a mole among them.",
            "genre_ids": [
              18,
              53,
              80
            ],
            "video": false,
            "credit_id": "52fe42f5c3a36847f802ff41",
            "release_date": "2006-10-05",
            "popularity": 32.695,
            "vote_average": 8.1,
            "vote_count": 9879,
            "title": "The Departed",
            "adult": false,
            "backdrop_path": "/9RuC3UD6mNZ0p1J6RbfJDUkQ03i.jpg",
            "poster_path": "/p3tmqqwFPHFdu1oVpcgKGfcPCMZ.jpg"
          },
          {
            "id": 1988,
            "department": "Production",
            "original_language": "en",
            "original_title": "A Mighty Heart",
            "job": "Producer",
            "overview": "Based on Mariane Pearl's account of the terrifying and unforgettable story of her husband, Wall Street Journal reporter Danny Pearl's life and death.",
            "genre_ids": [
              18,
              53
            ],
            "video": false,
            "credit_id": "52fe4329c3a36847f803ee3b",
            "poster_path": "/z5f7KPg8vqqYXtaF0wUkSWryDIg.jpg",
            "popularity": 9.199,
            "backdrop_path": "/tHudxfTzy71dc0Z1zAd4EGwA7IA.jpg",
            "vote_count": 200,
            "title": "A Mighty Heart",
            "adult": false,
            "vote_average": 6.5,
            "release_date": "2007-06-22"
          },
          {
            "id": 4512,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Assassination of Jesse James by the Coward Robert Ford",
            "job": "Producer",
            "overview": "Outlaw Jesse James is rumored to be the 'fastest gun in the West'. An eager recruit into James' notorious gang, Robert Ford eventually grows jealous of the famed outlaw and, when Robert and his brother sense an opportunity to kill James, their murderous action elevates their target to near mythical status.",
            "genre_ids": [
              28,
              18,
              37
            ],
            "video": false,
            "credit_id": "52fe43c7c3a36847f806ef0b",
            "poster_path": "/2d1S6fJS80fvseg6mJE8eq5o7Kx.jpg",
            "popularity": 11.727,
            "backdrop_path": "/wxAprkYIwTwKiOSlPG0snUIwt6n.jpg",
            "vote_count": 1599,
            "title": "The Assassination of Jesse James by the Coward Robert Ford",
            "adult": false,
            "vote_average": 7,
            "release_date": "2007-09-07"
          },
          {
            "id": 23483,
            "department": "Production",
            "original_language": "en",
            "original_title": "Kick-Ass",
            "job": "Producer",
            "overview": "Dave Lizewski is an unnoticed high school student and comic book fan who one day decides to become a super-hero, even though he has no powers, training or meaningful reason to do so.",
            "genre_ids": [
              28,
              80
            ],
            "video": false,
            "credit_id": "52fe446ac3a368484e021e13",
            "release_date": "2010-03-22",
            "popularity": 26.713,
            "vote_average": 7.1,
            "vote_count": 8680,
            "title": "Kick-Ass",
            "adult": false,
            "backdrop_path": "/P4bGyJQF0shAcRku3I2perNUQR.jpg",
            "poster_path": "/GPiMXaDC2NdDIldLgtijHFTeKH.jpg"
          },
          {
            "id": 7510,
            "department": "Production",
            "original_language": "en",
            "original_title": "Running with Scissors",
            "job": "Producer",
            "overview": "Young Augusten Burroughs absorbs experiences that could make for a shocking memoir: the son of an alcoholic father and an unstable mother, he's handed off to his mother's therapist, Dr. Finch, and spends his adolescent years as a member of Finch's bizarre extended family.",
            "genre_ids": [
              35,
              18
            ],
            "video": false,
            "credit_id": "52fe4481c3a36847f809a065",
            "poster_path": "/sKvEhXJJtL0MItMmQsaUKqU58J7.jpg",
            "popularity": 9.67,
            "backdrop_path": "/mWzbDptOnVtVKQ6Z5jYR8Mhk2pG.jpg",
            "vote_count": 157,
            "title": "Running with Scissors",
            "adult": false,
            "vote_average": 5.9,
            "release_date": "2006-10-27"
          },
          {
            "id": 24420,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Time Traveler's Wife",
            "job": "Executive Producer",
            "overview": "Due to a genetic disorder, handsome librarian Henry DeTamble involuntarily zips through time, appearing at various moments in the life of his true love, the beautiful artist Clare Abshire.",
            "genre_ids": [
              18,
              10749,
              14
            ],
            "video": false,
            "credit_id": "52fe4495c3a368484e02af99",
            "release_date": "2009-08-14",
            "popularity": 11.699,
            "vote_average": 6.9,
            "vote_count": 1629,
            "title": "The Time Traveler's Wife",
            "adult": false,
            "backdrop_path": "/1IXxWN99959OCslOwgC8yqJ7cs.jpg",
            "poster_path": "/J3ewuzQwhFro0pDpdcbZ4j7MYy.jpg"
          },
          {
            "id": 38167,
            "department": "Production",
            "original_language": "en",
            "original_title": "Eat Pray Love",
            "job": "Executive Producer",
            "overview": "Liz Gilbert had everything a modern woman is supposed to dream of having – a husband, a house and a successful career – yet like so many others, she found herself lost, confused and searching for what she really wanted in life. Newly divorced and at a crossroads, Gilbert steps out of her comfort zone, risking everything to change her life, embarking on a journey around the world that becomes a quest for self-discovery. In her travels, she discovers the true pleasure of nourishment by eating in Italy, the power of prayer in India and, finally and unexpectedly, the inner peace and balance of true love in Bali.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "52fe469c9251416c91059ecf",
            "poster_path": "/9Hgiv1UEIjc8VwtOmFBCFzMs0er.jpg",
            "popularity": 15.011,
            "backdrop_path": "/qGbhTBOHq1OYBHSB1MqixtvQeir.jpg",
            "vote_count": 1574,
            "title": "Eat Pray Love",
            "adult": false,
            "vote_average": 6.1,
            "release_date": "2010-08-12"
          },
          {
            "id": 64689,
            "department": "Production",
            "original_language": "en",
            "original_title": "Killing Them Softly",
            "job": "Producer",
            "overview": "Jackie Cogan is an enforcer hired to restore order after three dumb guys rob a Mob protected card game, causing the local criminal economy to collapse.",
            "genre_ids": [
              80,
              53
            ],
            "video": false,
            "credit_id": "52fe46e4c3a368484e0a9aa7",
            "release_date": "2012-07-30",
            "popularity": 13.864,
            "vote_average": 6,
            "vote_count": 1365,
            "title": "Killing Them Softly",
            "adult": false,
            "backdrop_path": "/1g0EZDJkJMXa0fJyIOJGiJegSUC.jpg",
            "poster_path": "/heaz45kpFa4Oa7iLis0OBas68ls.jpg"
          },
          {
            "id": 72190,
            "department": "Production",
            "original_language": "en",
            "original_title": "World War Z",
            "job": "Producer",
            "overview": "Life for former United Nations investigator Gerry Lane and his family seems content. Suddenly, the world is plagued by a mysterious infection turning whole human populations into rampaging mindless zombies. After barely escaping the chaos, Lane is persuaded to go on a mission to investigate this disease. What follows is a perilous trek around the world where Lane must brave horrific dangers and long odds to find answers before human civilization falls.",
            "genre_ids": [
              28,
              18,
              27,
              878,
              53
            ],
            "video": false,
            "credit_id": "52fe485dc3a368484e0f50f9",
            "poster_path": "/aCnVdvExw6UWSeQfr0tUH3jr4qG.jpg",
            "popularity": 30.519,
            "backdrop_path": "/f5H5aLVCClEFnnTUrN0i2tXXLIz.jpg",
            "vote_count": 10966,
            "title": "World War Z",
            "adult": false,
            "vote_average": 6.8,
            "release_date": "2013-06-20"
          },
          {
            "id": 76203,
            "department": "Production",
            "original_language": "en",
            "original_title": "12 Years a Slave",
            "job": "Producer",
            "overview": "In the pre-Civil War United States, Solomon Northup, a free black man from upstate New York, is abducted and sold into slavery. Facing cruelty as well as unexpected kindnesses Solomon struggles not only to stay alive, but to retain his dignity. In the twelfth year of his unforgettable odyssey, Solomon’s chance meeting with a Canadian abolitionist will forever alter his life.",
            "genre_ids": [
              18,
              36
            ],
            "video": false,
            "credit_id": "52fe492cc3a368484e11dfe1",
            "release_date": "2013-10-18",
            "popularity": 21.475,
            "vote_average": 8,
            "vote_count": 8079,
            "title": "12 Years a Slave",
            "adult": false,
            "backdrop_path": "/4Bb1kMIfrT2tYRZ9M6Jhqy6gkeF.jpg",
            "poster_path": "/xdANQijuNrJaw1HA61rDccME4Tm.jpg"
          },
          {
            "id": 113833,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Normal Heart",
            "job": "Producer",
            "overview": "The story of the onset of the HIV-AIDS crisis in New York City in the early 1980s, taking an unflinching look at the nation's sexual politics as gay activists and their allies in the medical community fight to expose the truth about the burgeoning epidemic to a city and nation in denial.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "52fe4b3fc3a36847f81f9f89",
            "release_date": "2014-05-25",
            "popularity": 16.296,
            "vote_average": 7.9,
            "vote_count": 647,
            "title": "The Normal Heart",
            "adult": false,
            "backdrop_path": "/6GaZmTtYcQSV09BLtcSKCFhwlHk.jpg",
            "poster_path": "/qhugciu9LSc1g3FeS2FrR55wPi4.jpg"
          },
          {
            "id": 174349,
            "department": "Production",
            "original_language": "en",
            "original_title": "Big Men",
            "job": "Executive Producer",
            "overview": "For her latest industrial exposé, Rachel Boynton (Our Brand Is Crisis) gained unprecedented access to Africa's oil companies. The result is a gripping account of the costly personal tolls levied when American corporate interests pursue oil in places like Ghana and the Niger River Delta. Executive produced by Steven Shainberg and Brad Pitt, Big Men investigates the caustic blend of ambition, corruption and greed that threatens to exacerbate Africa’s resource curse.",
            "genre_ids": [
              99
            ],
            "video": false,
            "credit_id": "52fe4d49c3a36847f8258cf3",
            "release_date": "2014-03-14",
            "popularity": 4.338,
            "vote_average": 7.6,
            "vote_count": 13,
            "title": "Big Men",
            "adult": false,
            "backdrop_path": null,
            "poster_path": "/esSJSNDAJm8H0vpsKVU3R5gMFKp.jpg"
          },
          {
            "id": 60308,
            "department": "Production",
            "original_language": "en",
            "original_title": "Moneyball",
            "job": "Producer",
            "overview": "The story of Oakland Athletics general manager Billy Beane's successful attempt to put together a baseball team on a budget, by employing computer-generated analysis to draft his players.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "5383b2540e0a2624bd00d335",
            "release_date": "2011-09-22",
            "popularity": 19.125,
            "vote_average": 7.2,
            "vote_count": 2923,
            "title": "Moneyball",
            "adult": false,
            "backdrop_path": "/qbWrn6xaWK4nkzMRfP6oBBUW2cy.jpg",
            "poster_path": "/4yIQq1e6iOcaZ5rLDG3lZBP3j7a.jpg"
          },
          {
            "id": 301502,
            "department": "Production",
            "original_language": "en",
            "original_title": "Blonde",
            "job": "Producer",
            "overview": "A chronicle of the inner life of Marilyn Monroe.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "545c379ec3a368536b002903",
            "release_date": "2021-01-01",
            "popularity": 5.406,
            "vote_average": 0,
            "vote_count": 0,
            "title": "Blonde",
            "adult": false,
            "backdrop_path": null,
            "poster_path": null
          },
          {
            "id": 228150,
            "department": "Production",
            "original_language": "en",
            "original_title": "Fury",
            "job": "Executive Producer",
            "overview": "In the last months of World War II, as the Allies make their final push in the European theatre, a battle-hardened U.S. Army sergeant named 'Wardaddy' commands a Sherman tank called 'Fury' and its five-man crew on a deadly mission behind enemy lines. Outnumbered and outgunned, Wardaddy and his men face overwhelming odds in their heroic attempts to strike at the heart of Nazi Germany.",
            "genre_ids": [
              28,
              18,
              10752
            ],
            "video": false,
            "credit_id": "5477f63d92514103b80010c0",
            "poster_path": "/tWQGX4Gjq4TleqrCmam5tpoCBoi.jpg",
            "popularity": 49.717,
            "backdrop_path": "/1uKHoFWyYJn060dpIXUCU7Wbc15.jpg",
            "vote_count": 8172,
            "title": "Fury",
            "adult": false,
            "vote_average": 7.5,
            "release_date": "2014-10-15"
          },
          {
            "id": 273895,
            "department": "Production",
            "original_language": "en",
            "original_title": "Selma",
            "job": "Executive Producer",
            "overview": "\\"Selma,\\" as in Alabama, the place where segregation in the South was at its worst, leading to a march that ended in violence, forcing a famous statement by President Lyndon B. Johnson that ultimately led to the signing of the Voting Rights Act.",
            "genre_ids": [
              18,
              36
            ],
            "video": false,
            "credit_id": "54aeb6ac9251417aa7000998",
            "poster_path": "/iA5h4P1VIumIiqJaZy9i4BCN6xd.jpg",
            "popularity": 11.224,
            "backdrop_path": "/5i2XtRgiTyw0GxIllAPOX12ouSV.jpg",
            "vote_count": 1613,
            "title": "Selma",
            "adult": false,
            "vote_average": 7.5,
            "release_date": "2014-12-25"
          },
          {
            "id": 245706,
            "department": "Production",
            "original_language": "en",
            "original_title": "True Story",
            "job": "Executive Producer",
            "overview": "A drama centered around the relationship between journalist Michael Finkel and Christian Longo, an FBI Most Wanted List murderer who for years lived outside the U.S. under Finkel's name.",
            "genre_ids": [
              80,
              18,
              9648
            ],
            "video": false,
            "credit_id": "55a5c16a9251410996000596",
            "poster_path": "/ncP8XQ0bXP0xSpJmMsRt8mUcEXd.jpg",
            "popularity": 9.919,
            "backdrop_path": "/6Pq5k17JjKfBErKz42e7mkDlBZF.jpg",
            "vote_count": 1301,
            "title": "True Story",
            "adult": false,
            "vote_average": 6.3,
            "release_date": "2015-04-17"
          },
          {
            "id": 8967,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Tree of Life",
            "job": "Producer",
            "overview": "The impressionistic story of a Texas family in the 1950s. The film follows the life journey of the eldest son, Jack, through the innocence of childhood to his disillusioned adult years as he tries to reconcile a complicated relationship with his father. Jack finds himself a lost soul in the modern world, seeking answers to the origins and meaning of life while questioning the existence of faith.",
            "genre_ids": [
              18,
              14
            ],
            "video": false,
            "credit_id": "56392e8892514129fe0122e5",
            "poster_path": "/fd2wa02NYwbDJypkt4qLjjQODAM.jpg",
            "popularity": 13.165,
            "backdrop_path": "/pP4FZk5q835hiYW0da4BVBZzktU.jpg",
            "vote_count": 2094,
            "title": "The Tree of Life",
            "adult": false,
            "vote_average": 6.7,
            "release_date": "2011-05-18"
          },
          {
            "id": 318846,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Big Short",
            "job": "Producer",
            "overview": "The men who made millions from a global economic meltdown.",
            "genre_ids": [
              35,
              18
            ],
            "video": false,
            "credit_id": "568349e09251414f6300f7b7",
            "poster_path": "/isuQWbJPbjybBEWdcCaBUPmU0XO.jpg",
            "popularity": 28.505,
            "backdrop_path": "/cU7lZD7EMZ2ijHasEH7zjIpNU32.jpg",
            "vote_count": 5892,
            "title": "The Big Short",
            "adult": false,
            "vote_average": 7.3,
            "release_date": "2015-12-11"
          },
          {
            "id": 314385,
            "department": "Production",
            "original_language": "en",
            "original_title": "By the Sea",
            "job": "Producer",
            "overview": "Set in France during the mid-1970s, Vanessa, a former dancer, and her husband Roland, an American writer, travel the country together. They seem to be growing apart, but when they linger in one quiet, seaside town they begin to draw close to some of its more vibrant inhabitants, such as a local bar/café-keeper and a hotel owner.",
            "genre_ids": [
              18,
              10749
            ],
            "video": false,
            "credit_id": "56c309759251414b850017e4",
            "poster_path": "/2DVkCwOkTJDYgwc2WETXTcuFXVh.jpg",
            "popularity": 11.038,
            "backdrop_path": "/m6FQVpUBG69ZBzLcRLukIjGNz8p.jpg",
            "vote_count": 399,
            "title": "By the Sea",
            "adult": false,
            "vote_average": 5.4,
            "release_date": "2015-11-12"
          },
          {
            "id": 384678,
            "department": "Production",
            "original_language": "en",
            "original_title": "He Wanted the Moon",
            "job": "Producer",
            "overview": "In the 1920s, Dr. Perry Baird, who was born in Texas and educated at Harvard, begins his career ascent in the field of medicine.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "56d042d59251413e590059a3",
            "release_date": "",
            "popularity": 0.84,
            "vote_average": 0,
            "vote_count": 0,
            "title": "He Wanted the Moon",
            "adult": false,
            "backdrop_path": null,
            "poster_path": null
          },
          {
            "id": 387426,
            "department": "Production",
            "original_language": "en",
            "original_title": "Okja",
            "job": "Executive Producer",
            "overview": "A young girl named Mija risks everything to prevent a powerful, multi-national company from kidnapping her best friend - a massive animal named Okja.",
            "genre_ids": [
              28,
              12,
              18,
              878
            ],
            "video": false,
            "credit_id": "57cbb037c3a3685c250098f9",
            "poster_path": "/pHlRr2MfjK77VIIAO7p0R4jhsJI.jpg",
            "popularity": 12.447,
            "backdrop_path": "/1ycTOys6bzvt0XPnzSv8qYfrD0V.jpg",
            "vote_count": 2911,
            "title": "Okja",
            "adult": false,
            "vote_average": 7.5,
            "release_date": "2017-06-28"
          },
          {
            "id": 425980,
            "department": "Production",
            "original_language": "en",
            "original_title": "Brad's Status",
            "job": "Producer",
            "overview": "Although Brad has a satisfying career, a sweet wife and a comfortable life in suburban Sacramento, things aren't quite what he imagined during his college glory days. When he accompanies his musical prodigy son on a university tour, he can't help comparing his life with those of his four best college friends who seemingly have more wealthy and glamorous lives. But when circumstances force him to reconnect with his former friends, Brad begins to question whether he has really failed or if their lives are actually more flawed than they appear.",
            "genre_ids": [
              35,
              18
            ],
            "video": false,
            "credit_id": "58cf91c09251415a41032db7",
            "poster_path": "/uXiNpvig7EMq18VyNBUTlWrmN0q.jpg",
            "popularity": 8.288,
            "backdrop_path": "/eRfANc4xSRNaR8E9fUI9hdLkCWB.jpg",
            "vote_count": 217,
            "title": "Brad's Status",
            "adult": false,
            "vote_average": 6.1,
            "release_date": "2017-09-14"
          },
          {
            "id": 86822,
            "department": "Production",
            "original_language": "en",
            "original_title": "Voyage of Time: Life's Journey",
            "job": "Producer",
            "overview": "A celebration of the universe, displaying the whole of time, from its start to its final collapse. This film examines all that occurred to prepare the world that stands before us now: science and spirit, birth and death, the grand cosmos and the minute life systems of our planet. (Wide release version with narration by Cate Blanchett.)",
            "genre_ids": [
              99,
              18
            ],
            "video": false,
            "credit_id": "58cf933ac3a36811ce002515",
            "poster_path": "/by2hTbppbkyhQ2ddALHzXlUq8LM.jpg",
            "popularity": 9.526,
            "backdrop_path": "/69aWOSnh4cgorZwX6czYUTalKi4.jpg",
            "vote_count": 99,
            "title": "Voyage of Time: Life's Journey",
            "adult": false,
            "vote_average": 6.5,
            "release_date": "2017-03-10"
          },
          {
            "id": 376867,
            "department": "Production",
            "original_language": "en",
            "original_title": "Moonlight",
            "job": "Executive Producer",
            "overview": "The tender, heartbreaking story of a young man’s struggle to find himself, told across three defining chapters in his life as he experiences the ecstasy, pain, and beauty of falling in love, while grappling with his own sexuality.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "58cf93e19251415a74033ed4",
            "release_date": "2016-10-21",
            "popularity": 21.06,
            "vote_average": 7.4,
            "vote_count": 4995,
            "title": "Moonlight",
            "adult": false,
            "backdrop_path": "/A9KPbYTQvWsp51Lgz85ukVkFrKf.jpg",
            "poster_path": "/93NN95a71MsQ4tR2zSLv8BNK2qh.jpg"
          },
          {
            "id": 417198,
            "department": "Production",
            "original_language": "en",
            "original_title": "Voyage of Time: The IMAX Experience",
            "job": "Producer",
            "overview": "A celebration of the universe, displaying the whole of time, from its start to its final collapse. This film examines all that occurred to prepare the world that stands before us now: science and spirit, birth and death, the grand cosmos and the minute life systems of our planet. (Limited release IMAX version with narration by Brad Pitt.)",
            "genre_ids": [
              99
            ],
            "video": false,
            "credit_id": "58cf94f1c3a36851040304c9",
            "poster_path": "/6TzhA2MHCztJUGEqrVXcD3nWbl2.jpg",
            "popularity": 2.436,
            "backdrop_path": "/p04OwhvsoxgmdHQqflnDW8h3QBb.jpg",
            "vote_count": 13,
            "title": "Voyage of Time: The IMAX Experience",
            "adult": false,
            "vote_average": 6.7,
            "release_date": "2016-10-07"
          },
          {
            "id": 59859,
            "department": "Production",
            "original_language": "en",
            "original_title": "Kick-Ass 2",
            "job": "Producer",
            "overview": "After Kick-Ass’ insane bravery inspires a new wave of self-made masked crusaders, he joins a patrol led by the Colonel Stars and Stripes. When these amateur superheroes are hunted down by Red Mist — reborn as The Mother Fucker — only the blade-wielding Hit-Girl can prevent their annihilation.",
            "genre_ids": [
              28,
              12,
              80
            ],
            "video": false,
            "credit_id": "58cf95a0c3a368508c0317d5",
            "release_date": "2013-07-17",
            "popularity": 23.443,
            "vote_average": 6.4,
            "vote_count": 4440,
            "title": "Kick-Ass 2",
            "adult": false,
            "backdrop_path": "/AkBLdx5W9rqUgQwm3jwjuRdFact.jpg",
            "poster_path": "/4tRZenyexvIBpIDHTgLTjTEoA0i.jpg"
          },
          {
            "id": 357681,
            "department": "Production",
            "original_language": "en",
            "original_title": "Hitting the Apex",
            "job": "Producer",
            "overview": "'Hitting the Apex' is the inside story of six fighters – six of the fastest motorcycle racers of all time – and of the fates that awaited them at the peak of the sport. It’s the story of what is at stake for all of them: all that can be won, and all that can be lost, when you go chasing glory at over two hundred miles an hour – on a motorcycle.",
            "genre_ids": [
              99
            ],
            "video": false,
            "credit_id": "58cf95e19251415a8b033147",
            "release_date": "2015-09-02",
            "popularity": 7.745,
            "vote_average": 7.8,
            "vote_count": 60,
            "title": "Hitting the Apex",
            "adult": false,
            "backdrop_path": null,
            "poster_path": "/oDfMkUVIjev0g2qq821NER6jgS7.jpg"
          },
          {
            "id": 277662,
            "department": "Production",
            "original_language": "en",
            "original_title": "Nightingale",
            "job": "Executive Producer",
            "overview": "A dangerously unstable man addresses the unseen followers of his video log about his obsession with an old army buddy.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "58cf963fc3a36850fb030af7",
            "poster_path": "/yEHIs4uDaUGwYVSRbny1scet3UB.jpg",
            "popularity": 5.219,
            "backdrop_path": null,
            "vote_count": 28,
            "title": "Nightingale",
            "adult": false,
            "vote_average": 6.2,
            "release_date": "2014-06-17"
          },
          {
            "id": 84284,
            "department": "Production",
            "original_language": "en",
            "original_title": "The House I Live In",
            "job": "Executive Producer",
            "overview": "In the past 40 years, the War on Drugs has accounted for 45 million arrests, made America the world's largest jailer, and destroyed impoverished communities at home and abroad. Yet drugs are cheaper, purer, and more available today than ever. Where did we go wrong, and what can be done?",
            "genre_ids": [
              99
            ],
            "video": false,
            "credit_id": "58cf969bc3a36850c002c632",
            "poster_path": "/vD3eClzQZihxAb653BovKZPv9KV.jpg",
            "popularity": 7.889,
            "backdrop_path": "/pjwGDH0HCFW1a35FF5xT1RqbVfP.jpg",
            "vote_count": 49,
            "title": "The House I Live In",
            "adult": false,
            "vote_average": 7.8,
            "release_date": "2012-10-05"
          },
          {
            "id": 4475,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Private Lives of Pippa Lee",
            "job": "Executive Producer",
            "overview": "After her much older husband forces a move to a suburban retirement community, Pippa Lee engages in a period of reflection and finds herself heading toward a quiet nervous breakdown.",
            "genre_ids": [
              35,
              18,
              10749
            ],
            "video": false,
            "credit_id": "58d06c0592514159f6000ff0",
            "poster_path": "/dnyy1dUg27rntYEdr3CbA3rHuxn.jpg",
            "popularity": 7.825,
            "backdrop_path": "/m1635B33YpUiHSQHNYEO5blYgAV.jpg",
            "vote_count": 126,
            "title": "The Private Lives of Pippa Lee",
            "adult": false,
            "vote_average": 5.9,
            "release_date": "2009-07-07"
          },
          {
            "id": 13574,
            "department": "Production",
            "original_language": "en",
            "original_title": "Year of the Dog",
            "job": "Executive Producer",
            "overview": "A secretary's life changes in unexpected ways after her dog dies.",
            "genre_ids": [
              35,
              18,
              10749
            ],
            "video": false,
            "credit_id": "58d06caa92514159d6001183",
            "release_date": "2007-04-13",
            "popularity": 6.49,
            "vote_average": 5.3,
            "vote_count": 42,
            "title": "Year of the Dog",
            "adult": false,
            "backdrop_path": null,
            "poster_path": "/6K9ZWVMOpgQeYlq8mYGnreOViPW.jpg"
          },
          {
            "id": 15325,
            "department": "Production",
            "original_language": "en",
            "original_title": "God Grew Tired of Us",
            "job": "Executive Producer",
            "overview": "Filmmaker Christopher Quinn observes the ordeal of three Sudanese refugees -- Jon Bul Dau, Daniel Abul Pach and Panther Bior -- as they try to come to terms with the horrors they experienced in their homeland, while adjusting to their new lives in the United States.",
            "genre_ids": [
              99
            ],
            "video": false,
            "credit_id": "58d06e1f92514159d10013f3",
            "release_date": "2006-12-31",
            "popularity": 4.696,
            "vote_average": 7.3,
            "vote_count": 26,
            "title": "God Grew Tired of Us",
            "adult": false,
            "backdrop_path": "/VnkvK3lqGzuLV6F1Ng3GsiVFC4.jpg",
            "poster_path": "/mrUCcDeCPW3d0s2VCgyTRVoxyKa.jpg"
          },
          {
            "id": 429197,
            "department": "Production",
            "original_language": "en",
            "original_title": "Vice",
            "job": "Producer",
            "overview": "George W. Bush picks Dick Cheney, the CEO of Halliburton Co., to be his Republican running mate in the 2000 presidential election. No stranger to politics, Cheney's impressive résumé includes stints as White House chief of staff, House Minority Whip and defense secretary. When Bush wins by a narrow margin, Cheney begins to use his newfound power to help reshape the country and the world.",
            "genre_ids": [
              35,
              18,
              36
            ],
            "video": false,
            "credit_id": "5a55429b0e0a2607d4018878",
            "poster_path": "/1gCab6rNv1r6V64cwsU4oEr649Y.jpg",
            "popularity": 23.129,
            "backdrop_path": "/n49difnnZ8e0CZTvulnMRoURdQj.jpg",
            "vote_count": 2120,
            "title": "Vice",
            "adult": false,
            "vote_average": 7.1,
            "release_date": "2018-12-25"
          },
          {
            "id": 419704,
            "department": "Production",
            "original_language": "en",
            "original_title": "Ad Astra",
            "job": "Producer",
            "overview": "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond. While a mysterious phenomenon menaces to destroy life on planet Earth, astronaut Roy McBride undertakes a mission across the immensity of space and its many perils to uncover the truth about a lost expedition that decades before boldly faced emptiness and silence in search of the unknown.",
            "genre_ids": [
              18,
              878
            ],
            "video": false,
            "credit_id": "5a94d2699251413261001e84",
            "poster_path": "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg",
            "popularity": 138.843,
            "backdrop_path": "/AeDS2MKGFy6QcjgWbJBde0Ga6Hd.jpg",
            "vote_count": 3914,
            "title": "Ad Astra",
            "adult": false,
            "vote_average": 6.1,
            "release_date": "2019-09-17"
          },
          {
            "id": 451915,
            "department": "Production",
            "original_language": "en",
            "original_title": "Beautiful Boy",
            "job": "Producer",
            "overview": "After he and his first wife separate, journalist David Sheff struggles to help their teenage son, who goes from experimenting with drugs to becoming devastatingly addicted to methamphetamine.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "5ac93d5a0e0a26496504d5ad",
            "poster_path": "/i7gsLrNxpSf8NF5IZIrcOEfMyA3.jpg",
            "popularity": 11.13,
            "backdrop_path": "/sOhtC4cmaYPOlcjXCWxxrx2NKKn.jpg",
            "vote_count": 1133,
            "title": "Beautiful Boy",
            "adult": false,
            "vote_average": 7.5,
            "release_date": "2018-10-12"
          },
          {
            "id": 521666,
            "department": "Production",
            "original_language": "en",
            "original_title": "Untitled Harvey Weinstein Film",
            "job": "Producer",
            "overview": "Produced by Brad Pitt, this film will focus on Jodi Kantor and Megan Twohey, two of the women who did journalistic work to figure out who Weinstein really was.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "5ae85da69251410cec013f67",
            "release_date": "",
            "popularity": 1.09,
            "vote_average": 0,
            "vote_count": 0,
            "title": "Untitled Harvey Weinstein Film",
            "adult": false,
            "backdrop_path": null,
            "poster_path": null
          },
          {
            "id": 499466,
            "department": "Production",
            "original_language": "en",
            "original_title": "Wrong Answer",
            "job": "Producer",
            "overview": "A math teacher in Atlanta is scandalized when he looks to get funding for his school by altering his students' test scores.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "5b269bca9251416ced00612d",
            "release_date": "",
            "popularity": 1.27,
            "vote_average": 10,
            "vote_count": 2,
            "title": "Wrong Answer",
            "adult": false,
            "backdrop_path": null,
            "poster_path": null
          },
          {
            "id": 508578,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Black Hole",
            "job": "Producer",
            "overview": "A group of high school students are afflicted by an STD known as \\"teen plague\\" or \\"the bug.\\" Symptoms may include flaky skin, rash, growing a new limb, or turning into a new kind of creature.",
            "genre_ids": [
              27,
              14,
              53
            ],
            "video": false,
            "credit_id": "5b269e94c3a36841cf01402e",
            "release_date": "",
            "popularity": 0.84,
            "vote_average": 0,
            "vote_count": 0,
            "title": "The Black Hole",
            "adult": false,
            "backdrop_path": null,
            "poster_path": null
          },
          {
            "id": 354287,
            "department": "Production",
            "original_language": "en",
            "original_title": "War Machine",
            "job": "Producer",
            "overview": "A rock star general bent on winning the “impossible” war in Afghanistan takes us inside the complex machinery of modern war. Inspired by the true story of General Stanley McChrystal.",
            "genre_ids": [
              35,
              18,
              10752
            ],
            "video": false,
            "credit_id": "5b4a04770e0a26453b010d7e",
            "poster_path": "/zGlzlzms2vN5vSFVMWuknu7XGXP.jpg",
            "popularity": 12.558,
            "backdrop_path": "/eQsellX1IeGaIjv1w4JBzoOrvmf.jpg",
            "vote_count": 745,
            "title": "War Machine",
            "adult": false,
            "vote_average": 5.5,
            "release_date": "2017-05-26"
          },
          {
            "id": 465914,
            "department": "Production",
            "original_language": "en",
            "original_title": "If Beale Street Could Talk",
            "job": "Executive Producer",
            "overview": "After her fiance is falsely imprisoned, a pregnant African-American woman sets out to clear his name and prove his innocence.",
            "genre_ids": [
              18,
              10749
            ],
            "video": false,
            "credit_id": "5ba7e1f49251412f0402e33b",
            "poster_path": "/8tZx0OX7kxv6F2VNWZoPr2bWDgE.jpg",
            "popularity": 14.934,
            "backdrop_path": "/ooyvhMsLuwcWBB2HZa4gi4WQF7B.jpg",
            "vote_count": 695,
            "title": "If Beale Street Could Talk",
            "adult": false,
            "vote_average": 7.1,
            "release_date": "2018-12-14"
          },
          {
            "id": 314095,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Lost City of Z",
            "job": "Executive Producer",
            "overview": "A true-life drama in the 1920s, centering on British explorer Col. Percy Fawcett, who discovered evidence of a previously unknown, advanced civilization in the Amazon and disappeared whilst searching for it.",
            "genre_ids": [
              12,
              18,
              36
            ],
            "video": false,
            "credit_id": "5bd10124c3a3682f98000252",
            "release_date": "2016-10-15",
            "popularity": 11.173,
            "vote_average": 6.2,
            "vote_count": 1795,
            "title": "The Lost City of Z",
            "adult": false,
            "backdrop_path": "/qyAH7xkrgYCGPbaFV29C82Hngum.jpg",
            "poster_path": "/2FZqw7fP6r5BkPqo6LHzP4jwnHj.jpg"
          },
          {
            "id": 556696,
            "department": "Production",
            "original_language": "en",
            "original_title": "Tiger",
            "job": "Producer",
            "overview": "Based on John Vaillant’s book, telling the true story set in Siberia of a town being picked off by a nearby tiger as they encroach on his land.",
            "genre_ids": [],
            "video": false,
            "credit_id": "5bd2a162c3a3687437005f38",
            "release_date": "",
            "popularity": 1.37,
            "vote_average": 10,
            "vote_count": 1,
            "title": "Tiger",
            "adult": false,
            "backdrop_path": null,
            "poster_path": null
          },
          {
            "id": 522039,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Last Black Man in San Francisco",
            "job": "Executive Producer",
            "overview": "Jimmie Fails dreams of reclaiming the Victorian home his grandfather built in the heart of San Francisco. Joined on his quest by his best friend Mont, Jimmie searches for belonging in a rapidly changing city that seems to have left them behind.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "5c5751719251415448642b9c",
            "release_date": "2019-06-07",
            "popularity": 10.746,
            "vote_average": 7.3,
            "vote_count": 124,
            "title": "The Last Black Man in San Francisco",
            "adult": false,
            "backdrop_path": "/n0FzDpOvVhkj3uN7WHXXnAXOKFi.jpg",
            "poster_path": "/ow9zjibNrz5TYVZ6cqwmvCR1YX1.jpg"
          },
          {
            "id": 615643,
            "department": "Production",
            "original_language": "en",
            "original_title": "Minari",
            "job": "Producer",
            "overview": "It’s the 1980s, and David, a seven-year-old Korean American boy, is faced with new surroundings and a different way of life when his father, Jacob, moves their family from the West Coast to rural Arkansas. His mother, Monica, is aghast that they live in a mobile home in the middle of nowhere, and naughty little David and his sister are bored and aimless. When his equally mischievous grandmother arrives from Korea to live with them, her unfamiliar ways arouse David’s curiosity. Meanwhile, Jacob, hell-bent on creating a farm on untapped soil, throws their finances, his marriage, and the stability of the family into jeopardy.",
            "genre_ids": [
              18
            ],
            "video": false,
            "credit_id": "5d2c026ccaab6d4b3c9be314",
            "poster_path": "/1SPYHRRMjt3FSbAE1ByBOZwhpwS.jpg",
            "popularity": 4.757,
            "backdrop_path": "/4sBAphbkBMQ99PefVAYqC8ZIZMd.jpg",
            "vote_count": 3,
            "title": "Minari",
            "adult": false,
            "vote_average": 9.3,
            "release_date": "2020-01-26"
          },
          {
            "id": 631731,
            "department": "Production",
            "original_language": "en",
            "original_title": "The Curious Incident of the Dog in the Night-Time",
            "job": "Executive Producer",
            "overview": "An autistic 15-year-old replicates the methods of Sherlock Holmes to discover who killed his neighbor's dog with a garden tool.",
            "genre_ids": [
              12,
              9648
            ],
            "video": false,
            "credit_id": "5d7f9002f0647c0fd39bc323",
            "poster_path": null,
            "popularity": 2.691,
            "backdrop_path": null,
            "vote_count": 0,
            "title": "The Curious Incident of the Dog in the Night-Time",
            "adult": false,
            "vote_average": 0,
            "release_date": "2021-12-31"
          },
          {
            "id": 504949,
            "department": "Production",
            "original_language": "en",
            "original_title": "The King",
            "job": "Producer",
            "overview": "England, 15th century. Hal, a capricious prince who lives among the populace far from court, is forced by circumstances to reluctantly accept the throne and become Henry V.",
            "genre_ids": [
              18,
              36,
              10752
            ],
            "video": false,
            "credit_id": "5da08355e54d5d001182d82d",
            "poster_path": "/8u0QBGUbZcBW59VEAdmeFl9g98N.jpg",
            "popularity": 16.114,
            "backdrop_path": "/r0AWsZ9dBvC2No3kND9nxv3iRbb.jpg",
            "vote_count": 1524,
            "title": "The King",
            "adult": false,
            "vote_average": 7.2,
            "release_date": "2019-10-11"
          },
          {
            "id": 696506,
            "department": "Production",
            "original_language": "en",
            "original_title": "Mickey7",
            "job": "Producer",
            "overview": "Feature adaptation of the science fiction novel by Edward Ashton that will be published in 2021.The title character is an “expendable,” a person on missions who is sent on the most dangerous, even suicidal jobs. When an expendable dies, a new body is regenerated with most of the memories intact. Essentially, Mickey7 is the seventh iteration of an expendable who is undergoing an existential identity crisis while trying to keep his successor’s regeneration a secret and negotiating with the planet’s native species on a dangerous trip to colonize a new ice world.",
            "genre_ids": [
              878
            ],
            "video": false,
            "credit_id": "5ea23479c6006d001dfca7e4",
            "release_date": "",
            "popularity": 0.6,
            "vote_average": 0,
            "vote_count": 0,
            "title": "Mickey7",
            "adult": false,
            "backdrop_path": null,
            "poster_path": null
          },
          {
            "id": 595148,
            "department": "Production",
            "original_language": "en",
            "original_title": "Irresistible",
            "job": "Executive Producer",
            "overview": "A Democratic political consultant helps a retired Marine colonel run for mayor in a small, conservative Wisconsin town.",
            "genre_ids": [
              35,
              18
            ],
            "video": false,
            "credit_id": "5ef63552bfeb8b0037de24c2",
            "poster_path": "/izGiAbtC2lmGk3bbV5t3OowJhtP.jpg",
            "popularity": 23.664,
            "backdrop_path": "/eZ8eK0moqUo6Vwq08OK1POfyUF5.jpg",
            "vote_count": 46,
            "title": "Irresistible",
            "adult": false,
            "vote_average": 6.6,
            "release_date": "2020-06-26"
          },
          {
            "id": 541305,
            "department": "Production",
            "original_language": "en",
            "original_title": "Kajillionaire",
            "job": "Executive Producer",
            "overview": "A woman's life is turned upside down when her criminal parents invite an outsider to join them on a major heist they're planning.",
            "genre_ids": [],
            "video": false,
            "credit_id": "5f0748fe1d1bf40038662198",
            "release_date": "2020-09-18",
            "popularity": 30.56,
            "vote_average": 0,
            "vote_count": 0,
            "title": "Kajillionaire",
            "adult": false,
            "backdrop_path": "/aFBXcbacfXW2sZlb6w8YaSsAehh.jpg",
            "poster_path": "/vzIhsSq3WGtNcTIBUkQL2SflTaF.jpg"
          }
        ]
      },
      "homepage": null,
      "profile_path": "/cckcYc2v0yh1tc9QjRelptcOBko.jpg",
      "tv_credits": {
        "cast": [
          {
            "poster_path": "/k64lMNJScnkeXzOmQW9JVDTseaF.jpg",
            "original_name": "Growing Pains",
            "id": 54,
            "vote_count": 63,
            "vote_average": 6.8,
            "name": "Growing Pains",
            "first_air_date": "1985-09-24",
            "genre_ids": [
              35
            ],
            "popularity": 7.537,
            "character": "",
            "episode_count": 2,
            "original_language": "en",
            "credit_id": "525333fb19c295794002c720",
            "backdrop_path": "/qowDKrH3k5Ea04vg4kZimzP5jfq.jpg",
            "overview": "Growing Pains is an American television sitcom about an affluent family, residing in Huntington, Long Island, New York, with a working mother and a stay-at-home psychiatrist father raising three children together, which aired on ABC from September 24, 1985, to April 25, 1992.",
            "origin_country": [
              "US"
            ]
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "Jackass",
            "genre_ids": [
              35,
              99,
              10764
            ],
            "vote_count": 97,
            "backdrop_path": "/8R66KpvwSlvXPnDavrux6kxC1lF.jpg",
            "name": "Jackass",
            "first_air_date": "2000-04-12",
            "original_language": "en",
            "popularity": 12.745,
            "character": "",
            "episode_count": 2,
            "id": 1795,
            "credit_id": "5257157c760ee3776a132ba8",
            "vote_average": 6.1,
            "overview": "Jackass is an American reality series, originally shown on MTV from 2000 to 2002, featuring people performing various dangerous, crude self-injuring stunts and pranks. The show served as a launchpad for the television and acting careers of Bam Margera, Steve-O, and also Johnny Knoxville, who previously had only a few minor acting roles.\\n\\nSince 2002, three Jackass films have been produced and released by MTV corporate sibling Paramount Pictures, continuing the franchise after its run on television. The show sparked several spin-offs including Viva La Bam, Wildboyz, Homewrecker, Dr. Steve-O and Blastazoid.\\n\\nThe show placed #68 on Entertainment Weekly's \\"New TV Classics\\" list.",
            "poster_path": "/pBRXSkJdofmGqcDzN4diXzLBntC.jpg"
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "Live with Regis and Kathie Lee",
            "genre_ids": [],
            "vote_count": 7,
            "backdrop_path": null,
            "name": "Live with Regis and Kathie Lee",
            "first_air_date": "1983-04-04",
            "original_language": "en",
            "popularity": 23.551,
            "character": "",
            "episode_count": 1,
            "id": 1900,
            "credit_id": "52571af119c29571140d5eda",
            "vote_average": 5.2,
            "overview": "Live! with Kelly and Michael is an American syndicated morning talk show, hosted by Kelly Ripa and Michael Strahan. Executive-produced by Michael Gelman, the show has aired since 1983 locally on WABC-TV in New York City and 1988 nationwide. With roots in A.M. Los Angeles and A.M. New York, Live! began as The Morning Show, hosted by Regis Philbin and Cyndy Garvey; the show rose to national prominence as Live with Regis and Kathie Lee, which ran for 12 years and continuing as Live! with Regis and Kelly for another decade before Ripa, after hosting with guest co-hosts for nearly a year, was paired with former NFL defensive end Michael Strahan.\\n\\nThe franchise has had longstanding success and has won the Daytime Emmy Award for Outstanding Talk Show and Outstanding Talk Show Hosts.",
            "poster_path": null
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "King of the Hill",
            "genre_ids": [
              16,
              35,
              18
            ],
            "vote_count": 256,
            "backdrop_path": "/r2TbC6zlaJRPEcVO2WQAVgMFHXJ.jpg",
            "name": "King of the Hill",
            "first_air_date": "1997-01-12",
            "original_language": "en",
            "popularity": 46.843,
            "character": "",
            "episode_count": 1,
            "id": 2122,
            "credit_id": "52572302760ee3776a22dc59",
            "vote_average": 7.2,
            "overview": "Set in Texas, this animated series follows the life of propane salesman Hank Hill, who lives with his overly confident substitute Spanish teacher wife Peggy, wannabe comedian son Bobby, and naive niece Luanne. Hank has conservative views about God, family, and country, but his values and ethics are often challenged by the situations he, his family, and his beer-drinking neighbors/buddies find themselves in.",
            "poster_path": "/qEtk86ku1w4Jsc28sj8HyXQzABy.jpg"
          },
          {
            "poster_path": null,
            "original_name": "Pet Star",
            "id": 4325,
            "vote_count": 3,
            "vote_average": 9,
            "name": "Pet Star",
            "first_air_date": "2002-08-09",
            "genre_ids": [
              99
            ],
            "popularity": 5.152,
            "character": "",
            "episode_count": 1,
            "original_language": "en",
            "credit_id": "525763be760ee36aaa33f8e7",
            "backdrop_path": null,
            "overview": "Pet Star was a show on Animal Planet hosted by Mario Lopez. The show is a contest between owners and their trained pets who perform tricks. The tricks are graded by three celebrity judges on a scale of one to 10. In the end, the three pets with the highest score come out as finalists, and the audience votes on who is the episode's Pet Star. Then, at the end of the season, the winners compete to be the year's ULTIMATE PET STAR. The winner of a regular show gets $2,500, while the winner of the finals gets $25,000.\\n\\nThere were many celebrity judges, including Gena Lee Nolin, Virginia Madsen, Will Estes, Lindsay Wagner, Matt Gallant, Mackenzie Phillips, Billy West, James Avery, George Wallace, Melissa Peterman, Christopher Rich, John O'Hurley, Vanessa Lengies, Dom Irrera, Carol Leifer, Andy Kindler, Melissa Rivers, Meshach Taylor, Kaley Cuoco, Rosa Blasi, Jeff Cesario, Karri Turner, Peter Scolari, Bruce Jenner, Fred Willard, Shari Belafonte, Josh Meyers, Lori Petty, Ben Stein, Richard Jeni, Ken Howard, Paul Gilmartin, Maria Menounos, Tempestt Bledsoe, David Brenner and Amy Davidson.\\n\\nPet Star is based on the show Star Search. It is shown in the United Kingdom on Challenge.",
            "origin_country": [
              "US"
            ]
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "Freddy's Nightmares",
            "genre_ids": [
              18
            ],
            "vote_count": 14,
            "backdrop_path": null,
            "name": "Freddy's Nightmares",
            "first_air_date": "1988-10-08",
            "original_language": "en",
            "popularity": 9.222,
            "character": "",
            "episode_count": 1,
            "id": 4346,
            "credit_id": "525764f9760ee36aaa357d18",
            "vote_average": 5.6,
            "overview": "Freddy's Nightmares is an American horror anthology series, which aired in syndication from October 1988 until March 1990. A spin-off from the Nightmare on Elm Street series, each story was introduced by Freddy Krueger. This format is essentially the same as that employed by Alfred Hitchcock Presents, Tales from the Crypt, or The Twilight Zone. The pilot episode was directed by Tobe Hooper, and begins with Freddy Krueger's acquittal of the child-murdering charges due to his officer's lack of reviewing the Miranda warning at the time of Freddy's arrest. A mob of parents eventually corners Freddy in a power plant, leading to him being torched by the police officer, dying and gaining his familiar visage.\\n\\nThe series was produced by New Line Television, producers of the film series. It was originally distributed by Lorimar-Telepictures. However, Warner Bros. Television would assume syndication rights after acquiring Lorimar-Telepictures.",
            "poster_path": "/gcGlt8Eh8AJLDuaVV00UJlp6BaV.jpg"
          },
          {
            "poster_path": "/rz0QVhcZ01BjFomNXOHMTF8OyyP.jpg",
            "original_name": "Late Night with Conan O'Brien",
            "id": 4573,
            "vote_count": 73,
            "vote_average": 7.3,
            "name": "Late Night with Conan O'Brien",
            "first_air_date": "1993-09-13",
            "genre_ids": [
              35,
              10767
            ],
            "popularity": 23.607,
            "character": "",
            "episode_count": 1,
            "original_language": "en",
            "credit_id": "5257713f760ee36aaa496071",
            "backdrop_path": null,
            "overview": "Late Night with Conan O'Brien is an American late-night talk show hosted by Conan O'Brien that aired 2,725 episodes on NBC between 1993 and 2009. The show featured varied comedic material, celebrity interviews, and musical and comedy performances. Late Night aired weeknights at 12:37 am Eastern/11:37 pm Central and 12:37 am Mountain in the United States. From 1993 until 2000, Andy Richter served as O'Brien's sidekick; following his departure, O'Brien was the show's sole featured performer. The show's house musical act was The Max Weinberg 7, led by E Street Band drummer Max Weinberg.\\n\\nThe second incarnation of NBC's Late Night franchise, O'Brien's debuted in 1993 after David Letterman, who hosted the first incarnation of Late Night, moved to CBS to host Late Show opposite The Tonight Show. In 2004, as part of a deal to secure a new contract, NBC announced that O'Brien would leave Late Night in 2009 to succeed Jay Leno as the host of The Tonight Show. Jimmy Fallon began hosting his version of Late Night on March 2, 2009.",
            "origin_country": [
              "US"
            ]
          },
          {
            "poster_path": null,
            "original_name": "Intimate Portrait",
            "id": 9937,
            "vote_count": 1,
            "vote_average": 0.5,
            "name": "Intimate Portrait",
            "first_air_date": "1994-01-03",
            "genre_ids": [
              99
            ],
            "popularity": 11.804,
            "character": "",
            "episode_count": 1,
            "original_language": "en",
            "credit_id": "5257fa0319c29531db2ed3bb",
            "backdrop_path": null,
            "overview": "Intimate Portrait is a biographical television series on the Lifetime Television cable network focusing on different celebrities, which includes interviews with each subject.\\n\\nAmong the people profiled were Grace Kelly, Natalie Wood, Carly Simon, Jackie Kennedy, Katharine Hepburn, Carol Burnett, Tanya Tucker, and Marla Maples.",
            "origin_country": [
              "US"
            ]
          },
          {
            "origin_country": [
              "RU",
              "US"
            ],
            "original_name": "The Academy Awards",
            "genre_ids": [
              10764
            ],
            "vote_count": 35,
            "backdrop_path": null,
            "name": "The Academy Awards",
            "first_air_date": "1953-03-18",
            "original_language": "en",
            "popularity": 6.949,
            "character": "",
            "episode_count": 3,
            "id": 27023,
            "credit_id": "5258833a760ee346614043a6",
            "vote_average": 6.3,
            "overview": "The Academy Awards or The Oscars is an annual American awards ceremony honoring cinematic achievements in the film industry. The various category winners are awarded a copy of a statuette, officially the Academy Award of Merit, that is better known by its nickname Oscar. The awards, first presented in 1929 at the Hollywood Roosevelt Hotel, are overseen by the Academy of Motion Picture Arts and Sciences (AMPAS).\\n\\nThe awards ceremony began in 1929 and was first televised in 1953, making it the oldest entertainment awards ceremony.",
            "poster_path": "/wF43fJ8D85i79ZrLZsnUZ2JurbP.jpg"
          },
          {
            "poster_path": null,
            "original_name": "Glory Days",
            "id": 29999,
            "vote_count": 0,
            "vote_average": 0,
            "name": "Glory Days",
            "first_air_date": "1990-07-25",
            "genre_ids": [],
            "popularity": 1.254,
            "character": "Walker Lovejoy",
            "episode_count": 6,
            "original_language": "en",
            "credit_id": "525895bf760ee3466158aa8e",
            "backdrop_path": null,
            "overview": "Glory Days is an American drama television series that aired from July 25 until September 13, 1990.",
            "origin_country": [
              "US"
            ]
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "thirtysomething",
            "genre_ids": [
              35,
              18
            ],
            "vote_count": 10,
            "backdrop_path": null,
            "name": "thirtysomething",
            "first_air_date": "1987-09-29",
            "original_language": "en",
            "popularity": 17.868,
            "character": "Bernard",
            "episode_count": 1,
            "id": 1448,
            "credit_id": "525704eb760ee3776a008abe",
            "vote_average": 7.5,
            "overview": "Thirtysomething is an American television drama about a group of baby boomers in their late thirties. It was created by Marshall Herskovitz and Edward Zwick for MGM/UA Television Group and The Bedford Falls Company, and aired on ABC. It premiered in the U.S. on September 29, 1987. It lasted four seasons, with the last of its 85 episodes airing on May 28, 1991.\\n\\nThe title of the show was designed as thirtysomething by Kathie Broyles, who combined the words of the original title, Thirty Something.\\n\\nIn 1997, \\"The Go Between\\" and \\"Samurai Ad Man\\" were ranked #22 on TV Guide′s 100 Greatest Episodes of All Time.\\n\\nIn 2002, Thirtysomething was ranked #19 on TV Guide′s 50 Greatest TV Shows of All Time, and in 2013 TV Guide ranked it #10 in its list of The 60 Greatest Dramas of All Time.",
            "poster_path": "/zsg058wcuuye9EtlzmGi1a5JOxC.jpg"
          },
          {
            "poster_path": "/mX3bhC7gS7oAzvGOaFceR5f01IJ.jpg",
            "original_name": "21 Jump Street",
            "id": 1486,
            "vote_count": 49,
            "vote_average": 6.6,
            "name": "21 Jump Street",
            "first_air_date": "1987-04-12",
            "genre_ids": [
              80,
              9648,
              10759
            ],
            "popularity": 25.409,
            "character": "Peter",
            "episode_count": 1,
            "original_language": "en",
            "credit_id": "52570765760ee3776a03124d",
            "backdrop_path": "/1sPZtlIXmhTzVNugS9kj4XObXel.jpg",
            "overview": "21 Jump Street is an American police procedural crime drama television series that aired on the Fox Network and in first run syndication from April 12, 1987, to April 27, 1991, with a total of 103 episodes. The series focuses on a squad of youthful-looking undercover police officers investigating crimes in high schools, colleges, and other teenage venues. It was originally going to be titled Jump Street Chapel, after the deconsecrated church building in which the unit has its headquarters, but was changed at Fox's request so as not to mislead viewers into thinking it was a religious program.\\n\\nCreated by Patrick Hasburgh and Stephen J. Cannell, the series was produced by Patrick Hasburgh Productions and Stephen J. Cannell Productions in association with 20th Century Fox Television. Executive Producers included Hasburgh, Cannell, Steve Beers and Bill Nuss. The show was an early hit for the fledgling Fox Network, and was created to attract a younger audience. The final season aired in first-run syndication mainly on local Fox affiliates. It was later rerun on the FX cable network from 1996 to 1998.\\n\\nThe series provided a spark to Johnny Depp's nascent acting career, garnering him national recognition as a teen idol. Depp found this status irritating, but he continued on the series under his contract and was paid $45,000 per episode. Eventually he was released from his contract after the fourth season. A spin-off series, Booker, was produced for the character of Dennis Booker; it ran one season, from September 1989 to June 1990. A film adaptation starring Jonah Hill and Channing Tatum was released on March 16, 2012.",
            "origin_country": [
              "US",
              "CA"
            ]
          },
          {
            "poster_path": "/f496cm9enuEsZkSPzCwnTESEK5s.jpg",
            "original_name": "Friends",
            "id": 1668,
            "vote_count": 2724,
            "vote_average": 8.2,
            "name": "Friends",
            "first_air_date": "1994-09-22",
            "genre_ids": [
              35,
              18
            ],
            "popularity": 111.677,
            "character": "Will Colbert",
            "episode_count": 1,
            "original_language": "en",
            "credit_id": "5257107819c295731c02cf9b",
            "backdrop_path": "/l0qVZIpXtIo7km9u5Yqh0nKPOr5.jpg",
            "overview": "The misadventures of a group of friends as they navigate the pitfalls of work, life and love in Manhattan.",
            "origin_country": [
              "US"
            ]
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "Today",
            "genre_ids": [
              10763
            ],
            "vote_count": 9,
            "backdrop_path": null,
            "name": "Today",
            "first_air_date": "1952-01-14",
            "original_language": "en",
            "popularity": 13.945,
            "character": "",
            "episode_count": 1,
            "id": 1709,
            "credit_id": "525713d5760ee3776a113c77",
            "vote_average": 4,
            "overview": "Today is a daily American morning television show that airs on NBC. The program debuted on January 14, 1952. It was the first of its genre on American television and in the world, and is the fifth-longest running American television series. Originally a two-hour program on weekdays, it expanded to Sundays in 1987 and Saturdays in 1992. The weekday broadcast expanded to three hours in 2000, and to four hours in 2007.\\n\\nToday's dominance was virtually unchallenged by the other networks until the late 1980s, when it was overtaken by ABC's Good Morning America. Today retook the Nielsen ratings lead the week of December 11, 1995, and held onto that position for 852 consecutive weeks until the week of April 9, 2012, when it was beaten by Good Morning America yet again. In 2002, Today was ranked #17 on TV Guide's 50 Greatest TV Shows of All Time.",
            "poster_path": "/xlWdasY9oYg3OO5VTNqlPFftgya.jpg"
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "The Daily Show with Trevor Noah",
            "genre_ids": [
              35,
              10763
            ],
            "vote_count": 282,
            "backdrop_path": "/uyilhJ7MBLjiaQXboaEwe44Z0jA.jpg",
            "name": "The Daily Show with Trevor Noah",
            "first_air_date": "1996-07-22",
            "original_language": "en",
            "popularity": 59.859,
            "character": "",
            "episode_count": 1,
            "id": 2224,
            "credit_id": "52572b4e760ee3776a2d9c26",
            "vote_average": 6.4,
            "overview": "Trevor Noah and The World's Fakest News Team tackle the biggest stories in news, politics and pop culture.",
            "poster_path": "/qRjwk0yzkftRHgKJlonm8Gaj7n.jpg"
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "Tales from the Crypt",
            "genre_ids": [
              35,
              80,
              9648,
              10765
            ],
            "vote_count": 237,
            "backdrop_path": "/x79qEoAWb34kGCVkhBPS8oLqFb6.jpg",
            "name": "Tales from the Crypt",
            "first_air_date": "1989-06-10",
            "original_language": "en",
            "popularity": 19.439,
            "character": "Billy",
            "episode_count": 1,
            "id": 2391,
            "credit_id": "525734f6760ee3776a3977e7",
            "vote_average": 8,
            "overview": "Cadaverous scream legend the Crypt Keeper is your macabre host for these forays of fright and fun based on the classic E.C. Comics tales from back in the day. So shamble up to the bar and pick your poison. Will it be an insane Santa on a personal slay ride? Honeymooners out to fulfill the \\"til death do we part\\" vow ASAP?",
            "poster_path": "/rnhP5lzbLYevuMhdPdmShS1Uxzd.jpg"
          },
          {
            "poster_path": "/2fokK3Q98JcV2EkRMSkyiDlrssx.jpg",
            "original_name": "Head of the Class",
            "id": 2589,
            "vote_count": 18,
            "vote_average": 6.6,
            "name": "Head of the Class",
            "first_air_date": "1986-09-17",
            "genre_ids": [
              35
            ],
            "popularity": 15.106,
            "character": "",
            "episode_count": 1,
            "original_language": "en",
            "credit_id": "52573d96760ee36aaa047b7e",
            "backdrop_path": "/rLy3MQrbJO3eKMs0TsyKtLz15K7.jpg",
            "overview": "Head of the Class is an American sitcom that ran from 1986 to 1991 on the ABC television network.\\n\\nThe series follows a group of gifted students in the Individualized Honors Program at the fictional Monroe High School in Manhattan, and their history teacher Charlie Moore. The program was ostensibly a vehicle for Hesseman, best known for his role as radio DJ Dr. Johnny Fever in the sitcom WKRP in Cincinnati. Hesseman left Head of the Class in 1990 and was replaced by Billy Connolly as teacher Billy MacGregor for the final season. After the series ended, Connolly appeared in a short-lived spin-off titled Billy.\\n\\nThe series was created and executive produced by Rich Eustis and Michael Elias. Rich Eustis had previously worked as a New York City substitute teacher while hoping to become an actor.",
            "origin_country": [
              "US"
            ]
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "American Idol",
            "genre_ids": [
              10764
            ],
            "vote_count": 94,
            "backdrop_path": "/kIk6AJk9VBWB81XWW0t5K9fYnrD.jpg",
            "name": "American Idol",
            "first_air_date": "2002-06-11",
            "original_language": "en",
            "popularity": 57.944,
            "character": "",
            "episode_count": 1,
            "id": 3626,
            "credit_id": "525753c6760ee36aaa1f53c7",
            "vote_average": 5.1,
            "overview": "Each year, hopeful singers from all over the country audition to be part of one of the biggest shows in American television history. Who will become the new American Idol?",
            "poster_path": "/8zrIAq3IPuRHSNF3TRw1I5SZzmE.jpg"
          },
          {
            "poster_path": null,
            "original_name": "Celebrities Uncensored",
            "id": 10946,
            "vote_count": 3,
            "vote_average": 2.7,
            "name": "Celebrities Uncensored",
            "first_air_date": "2003-06-04",
            "genre_ids": [
              10763,
              99
            ],
            "popularity": 0.6,
            "character": "",
            "episode_count": 6,
            "original_language": "en",
            "credit_id": "5258094919c29531db3e2f4a",
            "backdrop_path": null,
            "overview": "Celebrities Uncensored is a TV program on the E! network that edited together amusing paparazzi footage of celebrities, usually in public places such as public sidewalks, restaurants, nightclubs, etc. The celebrities were often friendly, but sometimes their more unfriendly antics were featured in an amusing and entertaining way. It was very popular with stars on the rise and created a stir in the Hollywood community. Paris Hilton was first brought to the public's attention by this show.",
            "origin_country": [
              "US"
            ]
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "The Jim Jefferies Show",
            "genre_ids": [
              35,
              10767
            ],
            "vote_count": 23,
            "backdrop_path": "/huMTsX8WUSDgatoVVe9D6cD48bJ.jpg",
            "name": "The Jim Jefferies Show",
            "first_air_date": "2017-06-06",
            "original_language": "en",
            "popularity": 3.393,
            "character": "Ex-Weatherman",
            "episode_count": 1,
            "id": 72025,
            "credit_id": "594bbcec9251413111010eae",
            "vote_average": 6.2,
            "overview": "Each week, Jefferies tackles the week’s top stories from behind his desk and travels the globe to far-off locations to provide an eye opening look at hypocrisy around the world. Featuring interviews, international field pieces, and man on the ground investigations, Jim tackles the news of the day with no-bulls**t candor, piercing insight and a uniquely Aussie viewpoint.",
            "poster_path": "/oGBUMBbBFlzFH41TADyFpkZbPWw.jpg"
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "The Jim Jefferies Show",
            "genre_ids": [
              35,
              10767
            ],
            "vote_count": 23,
            "backdrop_path": "/huMTsX8WUSDgatoVVe9D6cD48bJ.jpg",
            "name": "The Jim Jefferies Show",
            "first_air_date": "2017-06-06",
            "original_language": "en",
            "popularity": 3.393,
            "character": "Weather Man",
            "episode_count": 3,
            "id": 72025,
            "credit_id": "59453334c3a36816a501091e",
            "vote_average": 6.2,
            "overview": "Each week, Jefferies tackles the week’s top stories from behind his desk and travels the globe to far-off locations to provide an eye opening look at hypocrisy around the world. Featuring interviews, international field pieces, and man on the ground investigations, Jim tackles the news of the day with no-bulls**t candor, piercing insight and a uniquely Aussie viewpoint.",
            "poster_path": "/oGBUMBbBFlzFH41TADyFpkZbPWw.jpg"
          },
          {
            "origin_country": [
              "RU",
              "US"
            ],
            "original_name": "The Academy Awards",
            "genre_ids": [
              10764
            ],
            "vote_count": 35,
            "backdrop_path": null,
            "name": "The Academy Awards",
            "first_air_date": "1953-03-18",
            "original_language": "en",
            "popularity": 6.949,
            "character": "Himself - Best Supporting Actor winner",
            "episode_count": 1,
            "id": 27023,
            "credit_id": "5e44cf739603310015f4aa70",
            "vote_average": 6.3,
            "overview": "The Academy Awards or The Oscars is an annual American awards ceremony honoring cinematic achievements in the film industry. The various category winners are awarded a copy of a statuette, officially the Academy Award of Merit, that is better known by its nickname Oscar. The awards, first presented in 1929 at the Hollywood Roosevelt Hotel, are overseen by the Academy of Motion Picture Arts and Sciences (AMPAS).\\n\\nThe awards ceremony began in 1929 and was first televised in 1953, making it the oldest entertainment awards ceremony.",
            "poster_path": "/wF43fJ8D85i79ZrLZsnUZ2JurbP.jpg"
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "Real Time with Bill Maher",
            "genre_ids": [
              35,
              10767
            ],
            "vote_count": 117,
            "backdrop_path": "/cs4wxElH1XPgRLFq1FOtIFpeKqz.jpg",
            "name": "Real Time with Bill Maher",
            "first_air_date": "2003-02-21",
            "original_language": "en",
            "popularity": 44.902,
            "character": "Himself",
            "episode_count": 1,
            "id": 4419,
            "credit_id": "5e5305bd35811d001557ae9a",
            "vote_average": 6.2,
            "overview": "Each week Bill Maher surrounds himself with a panel of guests which include politicians, actors, comedians, musicians and the like to discuss what's going on in the world.",
            "poster_path": "/c3EurMWJu1hXKUeJVvLIoJaN26j.jpg"
          },
          {
            "origin_country": [
              "US"
            ],
            "original_name": "Celebrity IOU",
            "genre_ids": [
              10764
            ],
            "vote_count": 0,
            "backdrop_path": "/xMKPodMG6o5fTwMylwUhlBl4yz.jpg",
            "name": "Celebrity IOU",
            "first_air_date": "2020-04-13",
            "original_language": "en",
            "popularity": 1.4,
            "character": "Himself",
            "episode_count": 1,
            "id": 100347,
            "credit_id": "5f0c8b0e5e12000038f37348",
            "vote_average": 0,
            "overview": "Twin brothers Drew and Jonathan Scott help Hollywood A-listers express their deep gratitude to the individuals who have had a major impact on their lives by surprising them with big, heartwarming home renovations that bring everyone to tears.",
            "poster_path": "/a4ICeFfS7rhR2tNTvV0LlfAgruf.jpg"
          }
        ],
        "crew": [
          {
            "id": 69851,
            "department": "Production",
            "original_language": "en",
            "episode_count": 8,
            "job": "Executive Producer",
            "overview": "Anthology series of famous feuds with the first season based on the legendary rivalry between Bette Davis and Joan Crawford which began early on their careers, climaxed on the set of \\"Whatever Happened to Baby Jane?\\" and evolved into an Oscar vendetta.",
            "origin_country": [
              "US"
            ],
            "original_name": "FEUD",
            "genre_ids": [
              18
            ],
            "name": "FEUD",
            "popularity": 9.541,
            "credit_id": "58d06d6e9251415a240011dc",
            "vote_average": 8.1,
            "first_air_date": "2017-03-05",
            "backdrop_path": "/kKSSvF4nLudxX907Qm75nRUOOHn.jpg",
            "vote_count": 99,
            "poster_path": "/obztijEwCVkKQutVK9eARn9jyNh.jpg"
          },
          {
            "id": 69061,
            "department": "Production",
            "original_language": "en",
            "episode_count": 16,
            "job": "Executive Producer",
            "overview": "Prairie Johnson, blind as a child, comes home to the community she grew up in with her sight restored. Some hail her a miracle, others a dangerous mystery, but Prairie won’t talk with the FBI or her parents about the seven years she went missing.",
            "origin_country": [
              "US"
            ],
            "original_name": "The OA",
            "vote_count": 513,
            "name": "The OA",
            "popularity": 17.726,
            "credit_id": "58cf92ae9251415a7d0339c3",
            "backdrop_path": "/tKKgBtSlz2AR9G407984fTOm7uh.jpg",
            "first_air_date": "2016-12-16",
            "vote_average": 7.5,
            "genre_ids": [
              18,
              9648,
              10765
            ],
            "poster_path": "/rueY4slMeKtTGitm0raFUJvgaa5.jpg"
          },
          {
            "id": 6860,
            "department": "Production",
            "original_language": "en",
            "episode_count": 1,
            "job": "Executive Producer",
            "overview": "A married gynecologist, father of two sons, slowly comes to terms with the fact that he wants to undergoes sexual reassignment surgery.",
            "origin_country": [
              "US"
            ],
            "original_name": "Pretty/Handsome",
            "vote_count": 0,
            "name": "Pretty/Handsome",
            "popularity": 1.859,
            "credit_id": "5a45e03a9251411fab090cc0",
            "backdrop_path": null,
            "first_air_date": "2007-11-30",
            "vote_average": 0,
            "genre_ids": [
              18
            ],
            "poster_path": "/2OLyDCHhpMWnP7fvskIScfJIH0U.jpg"
          },
          {
            "id": 80039,
            "department": "Production",
            "original_language": "en",
            "episode_count": 0,
            "job": "Executive Producer",
            "overview": "A young woman named Cora makes an amazing discovery during her attempt to break free from slavery in the deep south.",
            "origin_country": [
              "US"
            ],
            "original_name": "The Underground Railroad",
            "vote_count": 0,
            "name": "The Underground Railroad",
            "popularity": 0.676,
            "credit_id": "5b177cc9c3a3687412008e66",
            "backdrop_path": null,
            "first_air_date": "",
            "vote_average": 0,
            "genre_ids": [
              18
            ],
            "poster_path": null
          },
          {
            "id": 93565,
            "department": "Production",
            "original_language": "en",
            "episode_count": 1,
            "job": "Producer",
            "overview": "Two Nigerian teenagers, Ifemelu and Obinze, fall in love at a young age but get separated when Ifemelu goes to America for school and Obinze, in a post 9/11 world, gets stuck in London.",
            "origin_country": [],
            "original_name": "Americanah",
            "genre_ids": [
              18
            ],
            "name": "Americanah",
            "popularity": 0.84,
            "credit_id": "5e1e675666751d0011be4ffc",
            "vote_average": 0,
            "first_air_date": "",
            "backdrop_path": null,
            "vote_count": 0,
            "poster_path": null
          }
        ]
      },
      "deathday": null,
      "images": {
        "profiles": [
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66666666666667,
            "vote_count": 6,
            "height": 2400,
            "vote_average": 4.996,
            "file_path": "/fbvQc6utpq9wHojQ7wclzEVViEF.jpg",
            "width": 1600
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66603053435115,
            "vote_count": 27,
            "height": 1572,
            "vote_average": 5.26,
            "file_path": "/kU3B75TyRiCgE270EyZnHjfivoq.jpg",
            "width": 1047
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66666666666667,
            "vote_count": 12,
            "height": 1050,
            "vote_average": 5.034,
            "file_path": "/7WCsMdFaHLylKiv0x4vsR4Mh2rX.jpg",
            "width": 700
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.6675,
            "vote_count": 13,
            "height": 800,
            "vote_average": 5.1,
            "file_path": "/jNZ9OJj8vONbImwzDEOwAiKriGv.jpg",
            "width": 534
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66719492868463,
            "vote_count": 9,
            "height": 631,
            "vote_average": 5.206,
            "file_path": "/w1L55dXNi9UAmw2CURQjQI0DTf2.jpg",
            "width": 421
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66712898751734,
            "vote_count": 9,
            "height": 721,
            "vote_average": 5.206,
            "file_path": "/ajNaPmXVVMJFg9GWmu6MJzTaXdV.jpg",
            "width": 481
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66666666666667,
            "vote_count": 6,
            "height": 3000,
            "vote_average": 4.996,
            "file_path": "/iTzf3TBqo6lWMAit0i33SBtVVT7.jpg",
            "width": 2000
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.67083333333333,
            "vote_count": 2,
            "height": 1200,
            "vote_average": 5.246,
            "file_path": "/k36ZQ6RLAr49uzSTd93qoLvcRZR.jpg",
            "width": 805
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66666666666667,
            "vote_count": 2,
            "height": 750,
            "vote_average": 5.106,
            "file_path": "/ekwsWyFlT9zgbZXGuC70QUNjB2V.jpg",
            "width": 500
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66666666666667,
            "vote_count": 6,
            "height": 1920,
            "vote_average": 5.258,
            "file_path": "/wotDPQyhX7wJoA6HXGPzdg6EtGk.jpg",
            "width": 1280
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66666666666667,
            "vote_count": 8,
            "height": 1377,
            "vote_average": 5.264,
            "file_path": "/tJiSUYst4ddIaz1zge2LqCtu9tw.jpg",
            "width": 918
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66666666666667,
            "vote_count": 0,
            "height": 720,
            "vote_average": 0,
            "file_path": "/wrBcHV1MIac9gRga4GN0QzfMgTc.jpg",
            "width": 480
          },
          {
            "iso_639_1": null,
            "aspect_ratio": 0.66632653061224,
            "vote_count": 5,
            "height": 980,
            "vote_average": 5.322,
            "file_path": "/cckcYc2v0yh1tc9QjRelptcOBko.jpg",
            "width": 653
          }
        ]
      },
      "name": "Brad Pitt",
      "also_known_as": [
        "برد پیت",
        "Бред Пітт",
        "Брэд Питт",
        "畢·彼特",
        "ブラッド・ピット",
        "브래드 피트",
        "براد بيت",
        "แบรด พิตต์",
        "William Bradley \\"Brad\\" Pitt",
        "William Bradley Pitt",
        "Μπραντ Πιτ",
        "布拉德·皮特"
      ],
      "biography": "William Bradley \\"Brad\\" Pitt (born December 18, 1963) is an American actor and film producer. Pitt has received two Academy Award nominations and four Golden Globe Award nominations, winning one. He has been described as one of the world's most attractive men, a label for which he has received substantial media attention. Pitt began his acting career with television guest appearances, including a role on the CBS prime-time soap opera Dallas in 1987. He later gained recognition as the cowboy hitchhiker who seduces Geena Davis's character in the 1991 road movie Thelma & Louise. Pitt's first leading roles in big-budget productions came with A River Runs Through It (1992) and Interview with the Vampire (1994). He was cast opposite Anthony Hopkins in the 1994 drama Legends of the Fall, which earned him his first Golden Globe nomination. In 1995 he gave critically acclaimed performances in the crime thriller Seven and the science fiction film 12 Monkeys, the latter securing him a Golden Globe Award for Best Supporting Actor and an Academy Award nomination.\\n\\nFour years later, in 1999, Pitt starred in the cult hit Fight Club. He then starred in the major international hit as Rusty Ryan in Ocean's Eleven (2001) and its sequels, Ocean's Twelve (2004) and Ocean's Thirteen (2007). His greatest commercial successes have been Troy (2004) and Mr. & Mrs. Smith (2005).\\n\\nPitt received his second Academy Award nomination for his title role performance in the 2008 film The Curious Case of Benjamin Button. Following a high-profile relationship with actress Gwyneth Paltrow, Pitt was married to actress Jennifer Aniston for five years. Pitt lives with actress Angelina Jolie in a relationship that has generated wide publicity. He and Jolie have six children—Maddox, Pax, Zahara, Shiloh, Knox, and Vivienne.\\n\\nSince beginning his relationship with Jolie, he has become increasingly involved in social issues both in the United States and internationally. Pitt owns a production company named Plan B Entertainment, whose productions include the 2007 Academy Award winning Best Picture, The Departed.",
      "imdb_id": "nm0000093",
      "adult": false,
      "gender": 2,
      "place_of_birth": "Shawnee, Oklahoma, USA",
      "popularity": 19.793
    }
    """.utf8)
