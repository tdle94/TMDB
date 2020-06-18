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
                expect(testRealm.objects(MovieDetail.self).count).to(equal(0))
                let movieDetail = MovieDetail()
                localDataSource.saveMovie(movieDetail)
                expect(testRealm.objects(MovieDetail.self).count).to(equal(1))
                
                // retrieve
                expect(localDataSource.getMovieDetail(id: 0)).to(equal(movieDetail))
                
                // duplicate, throw error
                localDataSource.saveMovie(movieDetail)
                expect(testRealm.objects(MovieDetail.self).count).to(equal(1))
            }
            
            it ("add popular movie") {
                // add
                expect(testRealm.objects(PopularMovie.self).count).to(equal(0))
                let popularMovies: List<PopularMovie> = List()
                let movie = PopularMovie()
                let data = Data()

                popularMovies.append(movie)
                localDataSource.savePopularMovies(popularMovies)
                expect(testRealm.objects(PopularMovie.self).count).to(equal(1))
                
                // add data to poster
                localDataSource.savePopularMoviePosterImgData(movie, data)
                
                // retrieve poster image data
                expect(localDataSource.getPopularMoviePosterImgData(movie)).to(equal(data))
            }
        }
    }
}
