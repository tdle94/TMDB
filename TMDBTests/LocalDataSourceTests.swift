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

        beforeSuite {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }
        
        beforeEach {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }
        
        describe("initialize MovieDetail") {
            it("initializes and assign properties correctly") {
                let movieDetail = MovieDetail(id: 1, adult: true, budget: 0, homepage: "", overview: "", popularity: 0, revenue: 0, runtime: 1, status: "", tagline: "", title: "", video: true, backdropPath: "", imdbId: "", originalLanguage: "", originalTitle: "", releaseDate: "", voteAverage: 0, voteCount: 0)
                expect(movieDetail.id) == 1
                expect(movieDetail.adult) == true
                expect(movieDetail.budget) == 0
                expect(movieDetail.homepage) == ""
                expect(movieDetail.overview) == ""
                expect(movieDetail.popularity) == 0
                expect(movieDetail.revenue) == 0
                expect(movieDetail.runtime) == 1
                expect(movieDetail.status) == ""
                expect(movieDetail.tagline) == ""
                expect(movieDetail.title) == ""
                expect(movieDetail.video) == true
                expect(movieDetail.backdropPath) == ""
                expect(movieDetail.imdbId) == ""
                expect(movieDetail.originalTitle) == ""
                expect(movieDetail.originalLanguage) == ""
                expect(movieDetail.releaseDate) == ""
                expect(movieDetail.voteAverage) == 0
                expect(movieDetail.voteCount) == 0
            }
        }
        
        describe("movie detail") {
            let id = 1
            let adult = true
            let budget = 0.0
            let homepage = ""
            let overview = ""
            let popularity = 0.0
            let revenue = 0.0
            let runtime = 1
            let status = ""
            let tagline = ""
            let title = ""
            let video = true
            let backdropPath = ""
            let imdbId = ""
            let originalLanguage = ""
            let originalTitle = ""
            let releaseDate = ""
            let voteAverage = 0.0
            let voteCount = 0

            it("save and retrieve movie to realm correctly") {
                let movieDetail = MovieDetail(id: id, adult: adult, budget: budget, homepage: homepage, overview: overview, popularity: popularity, revenue: revenue, runtime: runtime, status: status, tagline: tagline, title: title, video: video, backdropPath: backdropPath, imdbId: imdbId, originalLanguage: originalLanguage, originalTitle: originalTitle, releaseDate: releaseDate, voteAverage: voteAverage, voteCount: voteCount)
                
                let error = movieDetail.save()
                expect(error).to(beNil())
                
                let realm = try! Realm()
                let movieDetailFromRealm = realm.object(ofType: MovieDetail.self, forPrimaryKey: 1)

                expect(movieDetailFromRealm?.id) == id
                expect(movieDetailFromRealm?.adult) == adult
                expect(movieDetailFromRealm?.budget) == budget
                expect(movieDetailFromRealm?.homepage) == homepage
                expect(movieDetailFromRealm?.overview) == overview
                expect(movieDetailFromRealm?.popularity) == popularity
                expect(movieDetailFromRealm?.revenue) == revenue
                expect(movieDetailFromRealm?.runtime) == runtime
                expect(movieDetailFromRealm?.status) == status
                expect(movieDetailFromRealm?.tagline) == tagline
                expect(movieDetailFromRealm?.title) == title
                expect(movieDetailFromRealm?.video) == video
                expect(movieDetailFromRealm?.backdropPath) == backdropPath
                expect(movieDetailFromRealm?.imdbId) == imdbId
                expect(movieDetailFromRealm?.originalTitle) == originalTitle
                expect(movieDetailFromRealm?.originalLanguage) == originalLanguage
                expect(movieDetailFromRealm?.releaseDate) == releaseDate
                expect(movieDetailFromRealm?.voteAverage) == voteAverage
                expect(movieDetailFromRealm?.voteCount) == voteCount
            }
        }
    }
}
