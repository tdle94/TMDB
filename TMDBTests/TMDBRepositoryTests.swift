//
//  TMDBRepositoryTests.swift
//  TMDBTests
//
//  Created by Tuyen Le on 11.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import XCTest
import Cuckoo
import RealmSwift
@testable import TMDB

class TMDBRepositoryTests: XCTestCase {

    var repository: TMDBRepositoryProtocol!
    let session: MockTMDBSessionProtocol = MockTMDBSessionProtocol()
    let requestBuilder: MockTMDBURLRequestBuilderProtocol = MockTMDBURLRequestBuilderProtocol()
    let localDataSource: MockTMDBLocalDataSourceProtocol = MockTMDBLocalDataSourceProtocol()
    let userSetting: MockTMDBUserSettingProtocol = MockTMDBUserSettingProtocol()
    let userDefault: UserDefaults = UserDefaults(suiteName: #file)!
    
    override func setUp() {
        let service = TMDBServices(session: session, urlRequestBuilder: requestBuilder)
        repository = TMDBRepository(services: service, localDataSource: localDataSource, userSetting: userSetting)
        
        stub(userSetting) { stub in
            when(stub).userDefault.get.thenReturn(userDefault)
        }
    }

    override func tearDown() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
    }

    // MARK: - movie detail test

    // no movie detail in realm, get from calling service
    func testGetMovieDetailCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.success(Movie()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub.getMovie(id: 3)).thenReturn(nil)
            when(stub.saveMovie(any())).thenDoNothing()
        }

        /*WHEN*/
        repository.getMovieDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())
        verify(requestBuilder).getMovieDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)
        verify(localDataSource).saveMovie(any())
    }
    
    // movie detail in realm with same region and language. Get from realm
    func testGetMovieDetailCase2() {
        let expectation = self.expectation(description: "")
        let movie = Movie()
        movie.region = NSLocale.current.regionCode
        movie.language = NSLocale.preferredLanguages.first

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub.getMovie(id: 3)).thenReturn(movie)
            when(stub.saveMovie(any())).thenDoNothing()
        }
        
        /*WHEN*/
        repository.getMovieDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getMovie(id: 3)
    }
    
    // movie detail in realm with different region and language. get from calling service
    func testGetMovieDetailCase3() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let movie = Movie()
        movie.region = ""
        movie.language = ""

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub.getMovie(id: 3)).thenReturn(movie)
            when(stub.saveMovie(any())).thenDoNothing()
        }
        
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.success(Movie()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)).thenReturn(request)
        }
        
        /*WHEN*/
        repository.getMovieDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())
        verify(requestBuilder).getMovieDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)
        verify(localDataSource).getMovie(id: 3)
        verify(localDataSource).saveMovie(any())
    }

    // no movie detail in realm, get from calling service with invalid id, service error
    func testGetMovieDetailCase4() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 1, language: NSLocale.preferredLanguages.first)).thenReturn(request)
        }

        stub(localDataSource) { stub in
            when(stub.getMovie(id: 1)).thenReturn(nil)
        }

        /*WHEN*/
        repository.getMovieDetail(id: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())
        verify(requestBuilder).getMovieDetailURLRequest(id: 1, language: NSLocale.preferredLanguages.first)
    }

    // MARK: - popular movie
    
    // sucess
    func testPopularMovieCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1, language: NSLocale.preferredLanguages.first, region: NSLocale.current.regionCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: any(), region: any()).thenReturn(request)
        }

        /*WHEN*/
        repository.getPopularMovie(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularMovieURLRequest(page: 1, language: NSLocale.preferredLanguages.first, region: NSLocale.current.regionCode)
    }
    
    // failure
    func testPopularMovieCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1, language: NSLocale.preferredLanguages.first, region: NSLocale.current.regionCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: any(), region: any()).thenReturn(request)
        }

        /*WHEN*/
        repository.getPopularMovie(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularMovieURLRequest(page: 1, language: NSLocale.preferredLanguages.first, region: NSLocale.current.regionCode)
    }

    // MARK: - popular TV Shows
    
    // success
    func testPopularTVShowsCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }

        /*WHEN*/
        repository.getPopularOnTV(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularTVURLRequest(page: 1, language: NSLocale.preferredLanguages.first)
    }
    
    // failure
    func testPopularTVShowsCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }


        /*WHEN*/
        repository.getPopularOnTV(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularTVURLRequest(page: 1, language: NSLocale.preferredLanguages.first)
    }

    // MARK: - popular people

    // success
    func testPopularPeopleCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularPeopleURLRequest(page: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PeopleResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(PeopleResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }

        /*WHEN*/
        repository.getPopularPeople(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PeopleResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularPeopleURLRequest(page: 1, language: NSLocale.preferredLanguages.first)
    }

    // failure
    func testPopularPeopleCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularPeopleURLRequest(page: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PeopleResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }


        /*WHEN*/
        repository.getPopularPeople(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PeopleResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularPeopleURLRequest(page: 1, language: NSLocale.preferredLanguages.first)
    }

    // MARK: - trending
    private func setUpTrendingTest(time: TrendingTime, type: TrendingMediaType) {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTrendingURLRequest(time: time, type: type)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let trendingTimeMatcher = ParameterMatcher<TrendingTime>(matchesFunction: { $0 == time })
        let trendingTypeMatcher = ParameterMatcher<TrendingMediaType>(matchesFunction: { $0 == type })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TrendingResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TrendingResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getTrendingURLRequest(time: trendingTimeMatcher, type: trendingTypeMatcher).thenReturn(request)
        }

        /*WHEN*/
        repository.getTrending(time: time, type: type) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TrendingResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getTrendingURLRequest(time: trendingTimeMatcher, type: trendingTypeMatcher)
    }

    func testAllTrendingToday() {
        self.setUpTrendingTest(time: .today, type: .all)
    }

    func testMovieTrendingToday() {
        self.setUpTrendingTest(time: .today, type: .movie)
    }

    func testPersonTrendingToday() {
        self.setUpTrendingTest(time: .today, type: .person)
    }

    func testTVTrendingToday() {
        self.setUpTrendingTest(time: .today, type: .tv)
    }

    func testAllTrendingThisWeek() {
        self.setUpTrendingTest(time: .week, type: .all)
    }

    func testMovieTrendingThisWeek() {
        self.setUpTrendingTest(time: .week, type: .movie)
    }

    func testPersonTrendingThisWeek() {
        self.setUpTrendingTest(time: .week, type: .person)
    }

    func testTVTrendingThisWeek() {
        self.setUpTrendingTest(time: .week, type: .tv)
    }
    
    func testTrendingFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTrendingURLRequest(time: .today, type: .all)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let trendingTimeMatcher = ParameterMatcher<TrendingTime>(matchesFunction: { $0 == .today })
        let trendingTypeMatcher = ParameterMatcher<TrendingMediaType>(matchesFunction: { $0 == .all })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TrendingResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getTrendingURLRequest(time: trendingTimeMatcher, type: trendingTypeMatcher).thenReturn(request)
        }

        /*WHEN*/
        repository.getTrending(time: .today, type: .all) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TrendingResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getTrendingURLRequest(time: trendingTimeMatcher, type: trendingTypeMatcher)
    }

    // MARK: - test update config
    
    // no image config in user setting yet, make service call, success
    func testUpdateImageConfigCase0() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getImageConfigURLRequest()
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let imageConfig = ImageConfigResult()
        let matcher: ParameterMatcher<ImageConfigResult> = ParameterMatcher<ImageConfigResult>()

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageConfigResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(imageConfig))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getImageConfigURLRequest().thenReturn(request)
        }

        stub(userSetting) { stub in
            when(stub).imageConfig.get.thenReturn(ImageConfigResult())
            when(stub).imageConfig.set(matcher).thenDoNothing()
        }

        /*WHEN*/
        repository.updateImageConfig()
        expectation.fulfill()
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(ImageConfigResult.Type.self), completion: anyClosure())
        verify(userSetting).imageConfig.get()
        verify(requestBuilder).getImageConfigURLRequest()
    }
    
    // no image config in user setting yet, make service call, not success
    func testUpdateImageConfigCase1() {
        let request = TMDBURLRequestBuilder().getImageConfigURLRequest()
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageConfigResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getImageConfigURLRequest().thenReturn(request)
        }

        stub(userSetting) { stub in
            when(stub).imageConfig.get.thenReturn(ImageConfigResult())
        }

        /*WHEN*/
        repository.updateImageConfig()

        /*THEN*/
        verify(session).send(request: requestMatcher, responseType: any(ImageConfigResult.Type.self), completion: anyClosure())
        verify(userSetting).imageConfig.get()
        verify(requestBuilder).getImageConfigURLRequest()
    }
    
    // image config in user setting yet, don't make service call, less than 10 days
    func testUpdateImageConfigCase2() {
        /*GIVEN*/
        stub(userSetting) { stub in
            when(stub).imageConfig.get.then { implementation in
                let todayDate = Date()
                let fiveDaysAgo = Calendar.current.date(byAdding: .day, value: -5, to: todayDate)
                var imageConfig = ImageConfigResult()
                imageConfig.dateUpdate = fiveDaysAgo
                return imageConfig
            }
        }

        /*WHEN*/
        repository.updateImageConfig()
        
        /*THEN*/
        verify(userSetting).imageConfig.get()
    }
    
    // MARK: - similar movies
    
    // no movie in realm, service call, success
    func testSimilarMovieSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(nil)
        }

        /*WHEN*/
        repository.getSimilarMovies(from: 3, page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first)
        verify(localDataSource).getMovie(id: 3)
    }
    
    // no movie in realm, service call, fail
    func testSimilarMovieFailure() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(nil)
        }

        /*WHEN*/
        repository.getSimilarMovies(from: 3, page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first)
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testSimilarMovieInRealmOldPage() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let movieInRealm = Movie()

        let result = MovieResult()
        let newMovie = Movie()
        
        newMovie.id = 2
        result.movies.append(newMovie)
        
        movieInRealm.similar = MovieResult()
        movieInRealm.similar?.totalResults = 2
        movieInRealm.similar?.page = 1
        movieInRealm.similar?.totalPages = 2
        movieInRealm.similar?.movies.append(Movie())
        
        let newListMovieMatcher = ParameterMatcher<List<Movie>>(matchesFunction: { $0 == result.movies })
        let movieInRealmMatcher = ParameterMatcher<Movie>(matchesFunction: { $0 == movieInRealm })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(result))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
               
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movieInRealm)
            when(stub).saveSimilarMovie(newListMovieMatcher, to: movieInRealmMatcher).thenDoNothing()
        }

        /*WHEN*/
        repository.getSimilarMovies(from: 3, page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSimilarMovieInRealmNewPageSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getSimilarMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let movieInRealm = Movie()

        let result = MovieResult()
        let newMovie = Movie()
        
        newMovie.id = 2
        result.movies.append(newMovie)
        
        movieInRealm.similar = MovieResult()
        movieInRealm.similar?.totalResults = 2
        movieInRealm.similar?.page = 1
        movieInRealm.similar?.totalPages = 2
        movieInRealm.similar?.movies.append(Movie())
        
        let newListMovieMatcher = ParameterMatcher<List<Movie>>(matchesFunction: { $0 == result.movies })
        let movieInRealmMatcher = ParameterMatcher<Movie>(matchesFunction: { $0 == movieInRealm })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(result))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getSimilarMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
               
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movieInRealm)
            when(stub).saveSimilarMovie(newListMovieMatcher, to: movieInRealmMatcher).thenDoNothing()
        }

        /*WHEN*/
        repository.getSimilarMovies(from: 3, page: 2) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getSimilarMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first)
        verify(localDataSource).saveSimilarMovie(newListMovieMatcher, to: movieInRealmMatcher)
    }
    
    func testSimilarMovieInRealmNewPageFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getSimilarMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let movieInRealm = Movie()

        let result = MovieResult()
        let newMovie = Movie()
        
        newMovie.id = 2
        result.movies.append(newMovie)
        
        movieInRealm.similar = MovieResult()
        movieInRealm.similar?.totalResults = 2
        movieInRealm.similar?.page = 1
        movieInRealm.similar?.totalPages = 2
        movieInRealm.similar?.movies.append(Movie())
        
        let newListMovieMatcher = ParameterMatcher<List<Movie>>(matchesFunction: { $0 == result.movies })
        let movieInRealmMatcher = ParameterMatcher<Movie>(matchesFunction: { $0 == movieInRealm })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getSimilarMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
               
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movieInRealm)
            when(stub).saveSimilarMovie(newListMovieMatcher, to: movieInRealmMatcher).thenDoNothing()
        }

        /*WHEN*/
        repository.getSimilarMovies(from: 3, page: 2) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getSimilarMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first)
    }
    
    // MARK: - recommend movies
    
    // no movie in realm, service call, success
    func testRecommendMovieSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(nil)
        }

        /*WHEN*/
        repository.getRecommendMovies(from: 3, page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first)
    }
    
    // no movie in realm, service call, failure
    func testRecommendMovieFailure() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 400, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(nil)
        }

        /*WHEN*/
        repository.getRecommendMovies(from: 3, page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.preferredLanguages.first)
    }
    
    func testRecommendMovieNewPageSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getRecommendMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
            
        let movieInRealm = Movie()

        let result = MovieResult()
        let newMovie = Movie()
            
        newMovie.id = 2
        result.movies.append(newMovie)
            
        movieInRealm.recommendations = MovieResult()
        movieInRealm.recommendations?.totalResults = 2
        movieInRealm.recommendations?.page = 1
        movieInRealm.recommendations?.totalPages = 2
        movieInRealm.recommendations?.movies.append(Movie())
            
        let newListMovieMatcher = ParameterMatcher<List<Movie>>(matchesFunction: { $0 == result.movies })
        let movieInRealmMatcher = ParameterMatcher<Movie>(matchesFunction: { $0 == movieInRealm })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(result))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getRecommendMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
            
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movieInRealm)
            when(stub).saveRecommendMovie(newListMovieMatcher, to: movieInRealmMatcher).thenDoNothing()
        }

        /*WHEN*/
        repository.getRecommendMovies(from: 3, page: 2) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getRecommendMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first)
        verify(localDataSource).saveRecommendMovie(newListMovieMatcher, to: movieInRealmMatcher)
    }
    
    func testRecommendMovieNewPageFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getRecommendMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
            
        let movieInRealm = Movie()

        let result = MovieResult()
        let newMovie = Movie()
            
        newMovie.id = 2
        result.movies.append(newMovie)
            
        movieInRealm.recommendations = MovieResult()
        movieInRealm.recommendations?.totalResults = 2
        movieInRealm.recommendations?.page = 1
        movieInRealm.recommendations?.totalPages = 2
        movieInRealm.recommendations?.movies.append(Movie())
            
        let newListMovieMatcher = ParameterMatcher<List<Movie>>(matchesFunction: { $0 == result.movies })
        let movieInRealmMatcher = ParameterMatcher<Movie>(matchesFunction: { $0 == movieInRealm })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getRecommendMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
            
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movieInRealm)
            when(stub).saveRecommendMovie(newListMovieMatcher, to: movieInRealmMatcher).thenDoNothing()
        }

        /*WHEN*/
        repository.getRecommendMovies(from: 3, page: 2) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getRecommendMoviesURLRequest(from: 3, page: 2, language: NSLocale.preferredLanguages.first)
    }
    
    func testRecommendMovieOldPage() {
        let expectation = self.expectation(description: "")
        
        let movieInRealm = Movie()

        let result = MovieResult()
        let newMovie = Movie()
        
        newMovie.id = 2
        result.movies.append(newMovie)
        
        movieInRealm.recommendations = MovieResult()
        movieInRealm.recommendations?.totalResults = 2
        movieInRealm.recommendations?.page = 1
        movieInRealm.recommendations?.totalPages = 2
        movieInRealm.recommendations?.movies.append(Movie())
        
        let newListMovieMatcher = ParameterMatcher<List<Movie>>(matchesFunction: { $0 == result.movies })
        let movieInRealmMatcher = ParameterMatcher<Movie>(matchesFunction: { $0 == movieInRealm })

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movieInRealm)
            when(stub).saveRecommendMovie(newListMovieMatcher, to: movieInRealmMatcher).thenDoNothing()
        }

        /*WHEN*/
        repository.getRecommendMovies(from: 3, page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
    }

    // MARK - movie review

    // sucess
    func testGetMovieReviewInRealm() {
        let movieInRealm = Movie()
        let reviewResult = ReviewResult()
        reviewResult.reviews.append(Review())
        movieInRealm.id = 3
        movieInRealm.reviews = reviewResult

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movieInRealm)
        }
        
        /*WHEN*/
        let reviews = repository.getMovieReview(from: 3)
        XCTAssertTrue(reviews.count > 0)
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testGetMovieNilReview() {
        let movieInRealm = Movie()
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 0).thenReturn(movieInRealm)
        }
        
        /*WHEN*/
        let reviews = repository.getMovieReview(from: 0)
        XCTAssertTrue(reviews.count == 0)
        verify(localDataSource).getMovie(id: 0)
    }
    
    // MARK: - movie credit
    
    func testGetNonEmptyMovieCastFromRealm() {
        let movie = Movie()
        movie.id = 3
        movie.credits = CreditResult()
        movie.credits?.cast.append(Cast())
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        
        /*WHEN*/
        let _ = repository.getMovieCast(from: 3)
        
        /*THEN*/
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testGetNilMovieCastFromRealm() {
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(nil)
        }

        /*WHEN*/
        let _ = repository.getMovieCast(from: 3)

        /*THEN*/
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testGetNonEmptyMovieCrewFromRealm() {
        let movie = Movie()
        movie.id = 3
        movie.credits = CreditResult()
        movie.credits?.crew.append(Crew())

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }

        /*WHEN*/
        let _ = repository.getMovieCrew(from: 3)

        /*THEN*/
        verify(localDataSource).getMovie(id: 3)
    }

    func testGetNilMovieCrewFromRealm() {
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 4).thenReturn(nil)
        }

        /*WHEN*/
        let _ = repository.getMovieCrew(from: 4)

        /*THEN*/
        verify(localDataSource).getMovie(id: 4)
    }
    
    // MARK: - movie keyword
    func testGetKeywordFromMovieNotEmpty() {
        let movie = Movie()
        let keywordResult = KeywordResult()
        keywordResult.keywords.append(Keyword())
        movie.id = 3
        movie.keywords = keywordResult

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        
        /*WHEN*/
        let keywords = repository.getMovieKeywords(from: 3)
        XCTAssertEqual(keywords.count, 1)
        /*THEN*/
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testGetKeywordFromMovieEmpty() {
        let movie = Movie()
        movie.id = 3
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        
        /*WHEN*/
        let keywords = repository.getMovieKeywords(from: 3)
        XCTAssertEqual(keywords.count, 0)

        /*THEN*/
        verify(localDataSource).getMovie(id: 3)
    }
    
    // MARK: - multisearch
    func testGetMultiSearch() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMultiSearchURLRequest(query: "T", language: NSLocale.preferredLanguages.first, region: NSLocale.current.regionCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MultiSearchResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MultiSearchResult(page: 1, results: [], totalResults: 1, totalPages: 1)))
            }
        }
        
        stub(requestBuilder) { stub in
            when(stub).getMultiSearchURLRequest(query: "T", language: NSLocale.preferredLanguages.first, region: NSLocale.current.regionCode, page: 1).thenReturn(request)
        }
        
        /*WHEN*/
        repository.multiSearch(query: "T", page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MultiSearchResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getMultiSearchURLRequest(query: "T", language: NSLocale.preferredLanguages.first, region: NSLocale.current.regionCode, page: 1)
    }
    
    // MARK: - tv credits
    func testGetTVCredit() {
        let person = People()
        person.id = 1
        let tvCredits = TVCredit()
        tvCredits.cast.append(TVShow())
        person.tvCredits = tvCredits

        stub(localDataSource) { stub in
            when(stub).getPerson(id: 1).thenReturn(person)
        }

        XCTAssertEqual(repository.getTVCredits(from: 1), tvCredits)
    }

    // MARK: - movie credits
    func testGetMovieCredit() {
        let person = People()
        person.id = 1
        let movieCredits = MovieCredit()
        movieCredits.cast.append(Movie())
        person.movieCredits = movieCredits

        stub(localDataSource) { stub in
            when(stub).getPerson(id: 1).thenReturn(person)
        }

        XCTAssertEqual(repository.getMovieCredits(from: 1), movieCredits)
    }
    
    // MARK: - person detail
    
    // not in realm, service call, success
    func testGetPersonDetailNotInRealm() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPersonDetailURLRequest(id: 3, language: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let optionalLanguage: ParameterMatcher<String?> = ParameterMatcher(matchesFunction: { $0 == "en" })

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getPerson(id: 3).thenReturn(nil)
            when(stub).savePerson(any()).thenDoNothing()
        }

        stub(requestBuilder) { stub in
            when(stub).getPersonDetailURLRequest(id: 3, language: optionalLanguage).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(People.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(People()))
            }
        }
        
        /*WHEN*/
        repository.getPersonDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getPerson(id: 3)
        verify(localDataSource).savePerson(any())
        verify(requestBuilder).getPersonDetailURLRequest(id: 3, language: optionalLanguage)
        verify(session).send(request: requestMatcher, responseType: any(People.Type.self), completion: anyClosure())
    }
    
    // in realm, region and language are the same with user setting, no service call
    func testGetPersonDetailInRealm() {
        let expectation = self.expectation(description: "")
        let person = People()
        person.id = 3
        person.region = NSLocale.current.regionCode
        person.language = NSLocale.preferredLanguages.first

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getPerson(id: 3).thenReturn(person)
        }
        
        /*WHEN*/
        repository.getPersonDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getPerson(id: 3)
    }
    
    // in realm, region and language are different, service call
    func testGetPersonDetailInRealmServiceCall() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPersonDetailURLRequest(id: 3, language: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let optionalLanguage: ParameterMatcher<String?> = ParameterMatcher(matchesFunction: { $0 == "en" })
        let person = People()
        person.id = 3
        person.region = "GB"
        person.language = "de"
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getPerson(id: 3).thenReturn(person)
            when(stub).savePerson(any()).thenDoNothing()
        }
        
        stub(requestBuilder) { stub in
            when(stub).getPersonDetailURLRequest(id: 3, language: optionalLanguage).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(People.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(People()))
            }
        }
        
        /*WHEN*/
        repository.getPersonDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getPerson(id: 3)
        verify(localDataSource).savePerson(any())
        verify(requestBuilder).getPersonDetailURLRequest(id: 3, language: optionalLanguage)
        verify(session).send(request: requestMatcher, responseType: any(People.Type.self), completion: anyClosure())
    }
    
    // MARK: - movie images
    
    func testGetMovieImageNotInRealm() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieImages(from: 3)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let movieImageMatch: ParameterMatcher<MovieImages> = ParameterMatcher()

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(nil)
            when(stub).saveMovieImages(movieImageMatch, to: 3).thenDoNothing()
        }
        
        stub(requestBuilder) { stub in
            when(stub).getMovieImages(from: 3).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieImages.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieImages()))
            }
        }
        
        /*WHEN*/
        repository.getMovieImages(from: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
    
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getMovie(id: 3)
        verify(localDataSource).saveMovieImages(movieImageMatch, to: 3)
        verify(requestBuilder).getMovieImages(from: 3)
        verify(session).send(request: requestMatcher, responseType: any(MovieImages.Type.self), completion: anyClosure())
    }
    
    func testGetMovieImageInRealm() {
        let expectation = self.expectation(description: "")
        let movie = Movie()
        movie.id = 3
        movie.movieImages = MovieImages()

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        
        
        /*WHEN*/
        repository.getMovieImages(from: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        let movieImages = repository.getMovieImages(from: 3)
        XCTAssertNotNil(movieImages)
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource, times(2)).getMovie(id: 3)
    }

    // MARK: - person profile iamges
    func testGetPersonProfileImages() {
        let person = People()
        person.images = ImageProfile()
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getPerson(id: 3).thenReturn(person)
        }
        
        /*WHEN*/
        let images = repository.getPersonImageProfile(from: 3)
        XCTAssertNotNil(images)
        
        /*THEN*/
        verify(localDataSource).getPerson(id: 3)
    }
    
    // MARK: - complete release date
    func testGetCompleteMovieReleaseDates() {
        let movie = Movie()
        movie.releaseDates = ReleaseDateResults()

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        
        /*WHEN*/
        let releaseDates = repository.getMovieReleaseDates(from: 3)
        XCTAssertNotNil(releaseDates)
        
        /*THEN*/
        verify(localDataSource).getMovie(id: 3)
    }
    
    // MARK: - tv show detail
    func testGetTVShowNotInRealm() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let tvshow = TVShow()

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(nil)
            when(stub).saveTVShow(any()).thenDoNothing()
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShow.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(tvshow))
            }
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first).thenReturn(request)
        }
        /*WHEN*/
        repository.getTVShowDetail(from: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
        verify(session).send(request: requestMatcher, responseType: any(TVShow.Type.self), completion: anyClosure())
        verify(requestBuilder).getTVShowDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)
    }
    
    func testGetTVShowInRealm() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let tvshow = TVShow()
        tvshow.id = 3
        tvshow.region = "US"
        tvshow.language = "en"
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvshow)
        }
        
        /*WHEN*/
        repository.getTVShowDetail(from: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
        verify(session, never()).send(request: requestMatcher, responseType: any(TVShow.Type.self), completion: anyClosure())
        verify(requestBuilder, never()).getTVShowDetailURLRequest(id: 3, language: NSLocale.preferredLanguages.first)
    }
    
    // MARK: - tv show keywords
    func getExistingTVShowKeywords() {
        let tvShow = TVShow()
        let keywords = TVKeywordResult()
        keywords.results.append(Keyword())
        tvShow.keywords = keywords
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        XCTAssertNotEqual(repository.getTVShowKeywords(from: 3).count, 0)
        
        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }
}
