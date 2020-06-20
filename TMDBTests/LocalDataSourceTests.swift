//
//  LocalDataSourceTests.swift
//  TMDBTests
//
//  Created by Tuyen Le on 11.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
@testable import TMDB

class LocalDataSourceTests: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("TMDBLocalDataSource") {
            var testRealm: Realm!
            var localDataSource: TMDBLocalDataSource!

            beforeEach {
                testRealm = try! Realm(configuration: .init(inMemoryIdentifier: "TMDBLocalDataSource"))
                localDataSource = TMDBLocalDataSource(realm: testRealm)
            }
            
            afterEach {
                try? testRealm.write {
                    testRealm.deleteAll()
                }
            }

            it("can init") {
                localDataSource = TMDBLocalDataSource()
            }

            it("add movie detail, retrieve it from Realm and throw error for duplicate") {
                // add
                expect(testRealm.objects(Movie.self).count).to(equal(0))
                let movieDetail = Movie()
                localDataSource.saveMovie(movieDetail)
                expect(testRealm.objects(Movie.self).count).to(equal(1))
                
                // retrieve
                expect(localDataSource.getMovie(id: 0)).to(equal(movieDetail))
                
                // duplicate, throw error
                localDataSource.saveMovie(movieDetail)
                expect(testRealm.objects(Movie.self).count).to(equal(1))
            }
            
            it("add popular movie") {
                // add
                expect(testRealm.objects(Movie.self).count).to(equal(0))
                let popularMovies: List<Movie> = List()
                let movie = Movie()
                let data = Data()

                popularMovies.append(movie)
                localDataSource.saveMovies(popularMovies)
                expect(testRealm.objects(Movie.self).count).to(equal(1))
                
                // add data to poster
                localDataSource.saveMoviePosterImgData(movie, data)
                
                // retrieve poster image data
                expect(localDataSource.getMoviePosterImgData(movie)).to(equal(data))
            }

            it("add tv shows") {
                // add
                expect(testRealm.objects(TVShow.self).count).to(equal(0))
                let posterImgData = Data()
                let tvShows: List<TVShow> = List()
                let tvShow1 = TVShow()
                let tvShow2 = TVShow()
                tvShow2.id = 2

                tvShows.append(tvShow1)
                localDataSource.saveTVShows(tvShows)
                localDataSource.saveTVShow(tvShow2)
                expect(testRealm.objects(TVShow.self).count).to(equal(2))
                expect(localDataSource.getTVShow(id: 0)).to(equal(tvShow1))

                // add poster image data
                localDataSource.saveTVPosterImgData(tvShow1, posterImgData)

                // retrieve poster image data
                expect(localDataSource.getTVPosterImgData(tvShow1)).to(equal(posterImgData))
            }
            
            it("add people") {
                // add
                expect(testRealm.objects(People.self).count).to(equal(0))
                let profileImgData = Data()
                let people: List<People> = List()
                let person1 = People()
                let person2 = People()
                person2.id = 3

                people.append(person1)
                localDataSource.savePeople(people)
                localDataSource.savePerson(person1) // save duplicate
                localDataSource.savePerson(person2)
                expect(testRealm.objects(People.self).count).to(equal(2))
                
                // add profile image data
                localDataSource.savePersonProfileImgData(person1, profileImgData)
                
                // retrieve profile image data
                expect(localDataSource.getPersonProfileImgData(person1)).to(equal(profileImgData))
            }
            
            it("add trending") {
                // add
                let trendingResult = TrendingResult()
                let movie = Movie()
                let person = People()
                let tvShow = TVShow()
                let trending1 = Trending()
                let trending2 = Trending()
                let trending3 = Trending()
                trending1.people = person
                trending2.tv = tvShow
                trending3.movie = movie

                trendingResult.trending.append(trending1)
                trendingResult.trending.append(trending2)
                trendingResult.trending.append(trending3)
                
                localDataSource.saveTrendings(trendingResult.trending)
                
                expect(testRealm.objects(Movie.self).count).to(equal(1))
                expect(testRealm.objects(TVShow.self).count).to(equal(1))
                expect(testRealm.objects(People.self).count).to(equal(1))
            }
        }
    }
}
