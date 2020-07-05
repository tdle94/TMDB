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
            
            it("add pmovie") {
                // add
                expect(testRealm.objects(Movie.self).count).to(equal(0))
                let movie = Movie()
                localDataSource.saveMovie(movie)
                expect(testRealm.objects(Movie.self).count).to(equal(1))
            }

            it("add tv shows") {
                // add
                expect(testRealm.objects(TVShow.self).count).to(equal(0))
                let tvShow1 = TVShow()
                let tvShow2 = TVShow()
                let tvShow3 = TVShow()
                tvShow1.id = 1
                tvShow2.id = 2
                tvShow3.id = 3

                localDataSource.saveTVShow(tvShow1)
                localDataSource.saveTVShow(tvShow2)
                localDataSource.saveTVShow(tvShow3)
                expect(testRealm.objects(TVShow.self).count).to(equal(3))
                expect(localDataSource.getTVShow(id: 1)).to(equal(tvShow1))
            }
            
            it("add people") {
                // add
                expect(testRealm.objects(People.self).count).to(equal(0))
                let person1 = People()
                let person2 = People()
                person2.id = 1

                localDataSource.savePerson(person1)
                localDataSource.savePerson(person2)
                expect(testRealm.objects(People.self).count).to(equal(2))
                expect(localDataSource.getPerson(id: 1)).to(equal(person2))
            }
            
            it("save similar movie") {
                let result = MovieResult()
                let similarMovie = Movie()
                similarMovie.id = 3
                result.movies.append(similarMovie)
                
                let movieInRealm = Movie()
                movieInRealm.id = 2
                movieInRealm.similar = MovieResult()
                movieInRealm.similar?.movies.append(Movie())
                movieInRealm.similar?.totalPages = 2
                movieInRealm.similar?.totalResults = 2
                movieInRealm.similar?.page = 1
                
                localDataSource.saveMovie(movieInRealm)
                expect(localDataSource.getMovie(id: 2)).to(equal(movieInRealm))
                
                localDataSource.saveSimilarMovie(result.movies, to: movieInRealm)
                expect(localDataSource.getMovie(id: 2)?.similar?.movies.count).to(equal(2))
                expect(localDataSource.getMovie(id: 2)?.similar?.page).to(equal(2))
            }
            
            it("save recommend movie") {
                let result = MovieResult()
                let recommendMovie = Movie()
                recommendMovie.id = 3
                result.movies.append(recommendMovie)
                
                let movieInRealm = Movie()
                movieInRealm.id = 2
                movieInRealm.recommendations = MovieResult()
                movieInRealm.recommendations?.movies.append(Movie())
                movieInRealm.recommendations?.totalPages = 2
                movieInRealm.recommendations?.totalResults = 2
                movieInRealm.recommendations?.page = 1
                
                localDataSource.saveMovie(movieInRealm)
                expect(localDataSource.getMovie(id: 2)).to(equal(movieInRealm))
                
                localDataSource.saveRecommendMovie(result.movies, to: movieInRealm)
                expect(localDataSource.getMovie(id: 2)?.recommendations?.movies.count).to(equal(2))
                expect(localDataSource.getMovie(id: 2)?.recommendations?.page).to(equal(2))
            }
        }
    }
}
