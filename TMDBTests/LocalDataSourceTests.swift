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
            
            it("add movie") {
                // add movie
                expect(testRealm.objects(Movie.self).count).to(equal(0))
                let movie = Movie()
                movie.id = 3
                localDataSource.saveMovie(movie)
                expect(testRealm.objects(Movie.self).count).to(equal(1))
                
                // add movie with recommendation and similar
                let movie1 = Movie()
                let recommendResult = MovieResult()
                let similarResult = MovieResult()
                similarResult.movies.append(movie)
                recommendResult.movies.append(movie)
                movie1.id = 2
                movie1.recommendations = recommendResult
                movie1.similar = similarResult
                localDataSource.saveMovie(movie1)
                expect(testRealm.objects(Movie.self).count).to(equal(2))
                
                // add movie image
                let movieImage = ImageResult()
                localDataSource.saveMovieImages(movieImage, to: 3)
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

                localDataSource.saveTVShow(tvShow2)
                localDataSource.saveTVShow(tvShow3)
                
                // add similar tv show
                let similarTVShow = TVShowResult()
                similarTVShow.onTV.append(tvShow2)
                tvShow1.similar = similarTVShow
                
                // add recommend tv show
                let recommendTVShow = TVShowResult()
                recommendTVShow.onTV.append(tvShow3)
                tvShow1.recommendations = recommendTVShow
                
                localDataSource.saveTVShow(tvShow1)
                expect(testRealm.objects(TVShow.self).count).to(equal(3))
                expect(localDataSource.getTVShow(id: 1)).to(equal(tvShow1))
            }
            
            it("add people") {
                // add movie
                expect(testRealm.objects(Movie.self).count).to(equal(0))
                let movie = Movie()
                movie.id = 3
                localDataSource.saveMovie(movie)
                expect(testRealm.objects(Movie.self).count).to(equal(1))
                
                // add tv
                expect(testRealm.objects(TVShow.self).count).to(equal(0))
                let tvShow = TVShow()
                tvShow.id = 3
                localDataSource.saveTVShow(tvShow)
                expect(testRealm.objects(TVShow.self).count).to(equal(1))

                // add person with movie and tv credits
                expect(testRealm.objects(People.self).count).to(equal(0))
                let person1 = People()
                let person2 = People()
                person2.id = 1
                person1.tvCredits = TVCredit()
                person1.movieCredits = MovieCredit()
                person1.tvCredits?.cast.append(tvShow)
                person1.movieCredits?.cast.append(movie)

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
                
                localDataSource.saveSimilarMovie(result.movies, to: 2)
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
                
                localDataSource.saveRecommendMovie(result.movies, to: 2)
                expect(localDataSource.getMovie(id: 2)?.recommendations?.movies.count).to(equal(2))
                expect(localDataSource.getMovie(id: 2)?.recommendations?.page).to(equal(2))
            }

            it("save similar tvshow") {
                let result = TVShowResult()
                let similarTVShow = TVShow()
                similarTVShow.id = 3
                result.onTV.append(similarTVShow)
                
                let tvShowInRealm = TVShow()
                tvShowInRealm.id = 2
                tvShowInRealm.similar = TVShowResult()
                tvShowInRealm.similar?.onTV.append(TVShow())
                tvShowInRealm.similar?.totalPages = 2
                tvShowInRealm.similar?.totalResults = 2
                tvShowInRealm.similar?.page = 1
                
                localDataSource.saveTVShow(tvShowInRealm)
                expect(localDataSource.getTVShow(id: 2)).to(equal(tvShowInRealm))
                
                localDataSource.saveSimilarTVShow(result.onTV, to: 2)
                expect(localDataSource.getTVShow(id: 2)?.similar?.onTV.count).to(equal(2))
                expect(localDataSource.getTVShow(id: 2)?.similar?.page).to(equal(2))
            }
            
            it("save recommend tvshow") {
                let result = TVShowResult()
                let recomendTVShow = TVShow()
                recomendTVShow.id = 3
                result.onTV.append(recomendTVShow)
                
                let tvShowInRealm = TVShow()
                tvShowInRealm.id = 2
                tvShowInRealm.recommendations = TVShowResult()
                tvShowInRealm.recommendations?.onTV.append(TVShow())
                tvShowInRealm.recommendations?.totalPages = 2
                tvShowInRealm.recommendations?.totalResults = 2
                tvShowInRealm.recommendations?.page = 1
                
                localDataSource.saveTVShow(tvShowInRealm)
                expect(localDataSource.getTVShow(id: 2)).to(equal(tvShowInRealm))
                
                localDataSource.saveRecommendTVShow(result.onTV, to: 2)
                expect(localDataSource.getTVShow(id: 2)?.recommendations?.onTV.count).to(equal(2))
                expect(localDataSource.getTVShow(id: 2)?.recommendations?.page).to(equal(2))
            }

            it("save tv show season") {
                let tvShowInRealm = TVShow()
                let season = Season()
                season.id = 3
                tvShowInRealm.id = 2
                tvShowInRealm.seasons.append(Season())
                
                localDataSource.saveTVShow(tvShowInRealm)
                expect(localDataSource.getTVShow(id: 2)).to(equal(tvShowInRealm))
                
                season.episodes.append(Episode())
                localDataSource.saveTVShowSeason(season, to: 3)
            }
            
            it("save tv show image") {
                let tvShowInRealm = TVShow()
                let imageResult = ImageResult()
                tvShowInRealm.id = 2
                
                localDataSource.saveTVShow(tvShowInRealm)
                expect(localDataSource.getTVShow(id: 2)?.images).to(beNil())
                
                localDataSource.saveTVShowImages(imageResult, to: 2)
                expect(localDataSource.getTVShow(id: 2)?.images).toNot(beNil())
            }
            
            it("save movie image") {
                let movieInRealm = Movie()
                let imageResult = ImageResult()
                movieInRealm.id = 2

                localDataSource.saveMovie(movieInRealm)
                expect(localDataSource.getMovie(id: 2)?.images).to(beNil())
                
                localDataSource.saveMovieImages(imageResult, to: 2)
                expect(localDataSource.getMovie(id: 2)?.images).toNot(beNil())
            }

            it("save tv show episode") {
                let tvShow = TVShow()
                let season = Season()
                let episode = Episode()
                season.number = 1
                episode.episodeNumber = 1
                tvShow.id = 1
                season.episodes.append(episode)
                tvShow.seasons.append(season)

                localDataSource.saveTVShow(tvShow)
                expect(localDataSource.getTVShow(id: 1)?.credits).to(beNil())
                expect(localDataSource.getTVShow(id: 1)?.videos).to(beNil())

                testRealm.beginWrite()
                episode.credits = CreditResult()
                episode.videos = VideoResult()
                try? testRealm.commitWrite()
                localDataSource.saveTVShowEpisode(tvShowId: 1, seasonNumber: 1, episode: episode)
                expect(localDataSource.getTVShowEpisode(from: 1, seasonNumber: 1, episodeNumber: 1)?.credits).toNot(beNil())
                expect(localDataSource.getTVShowEpisode(from: 1, seasonNumber: 1, episodeNumber: 1)?.videos).toNot(beNil())
            }
        }
    }
}
