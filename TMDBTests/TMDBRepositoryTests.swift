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
        let service = TMDBServices(session: session, urlRequestBuilder: requestBuilder, userSetting: userSetting)
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
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.success(Movie()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 3, language: "en-US")).thenReturn(request)
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
        verify(localDataSource).getMovie(id: 3)
        verify(session).send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())
        verify(requestBuilder).getMovieDetailURLRequest(id: 3, language: "en-US")
        verify(localDataSource).saveMovie(any())
    }

    // no movie detail in realm, get from calling service with invalid id, service error
    func testGetMovieDetailCase3() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 1)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 1, language: "en-US")).thenReturn(request)
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
        verify(localDataSource).getMovie(id: 1)
        verify(session).send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())
        verify(requestBuilder).getMovieDetailURLRequest(id: 1, language: "en-US")
    }

    // get movie detail in realm
    func testGetMovieDetailCase4() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3)

        /*GIVEN*/
        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 3, language: "en-US")).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub.getMovie(id: 3)).thenReturn(Movie())
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

    // MARK: - popular movie
    
    // sucess
    func testPopularMovieCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1, language: "en-US")
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let noRegion = ParameterMatcher<String?>()
        let movieSaveMatcher: ParameterMatcher<List<Movie>> = ParameterMatcher()

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularMovie.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(PopularMovie()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: "en-US", region: noRegion).thenReturn(request)
        }

        stub(localDataSource) { stub in
            when(stub).saveMovies(movieSaveMatcher).thenDoNothing()
        }


        /*WHEN*/
        repository.getPopularMovie(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularMovie.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularMovieURLRequest(page: 1, language: "en-US", region: noRegion)
        verify(localDataSource).saveMovies(movieSaveMatcher)
    }
    
    // failure
    func testPopularMovieCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1, language: "en-US")
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let noRegion = ParameterMatcher<String?>()
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularMovie.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: "en-US", region: noRegion).thenReturn(request)
        }

        /*WHEN*/
        repository.getPopularMovie(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularMovie.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularMovieURLRequest(page: 1, language: "en-US", region: noRegion)
    }

    // MARK: - popular TV Shows
    
    // success
    func testPopularTVShowsCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularOnTVResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(PopularOnTVResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: "en-US").thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).saveTVShows(any()).thenDoNothing()
        }

        /*WHEN*/
        repository.getPopularOnTV(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularOnTVResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularTVURLRequest(page: 1, language: "en-US")
    }
    
    // failure
    func testPopularTVShowsCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularOnTVResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: "en-US").thenReturn(request)
        }


        /*WHEN*/
        repository.getPopularOnTV(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularOnTVResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularTVURLRequest(page: 1, language: "en-US")
    }

    // MARK: - popular people

    // success
    func testPopularPeopleCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularPeopleURLRequest(page: 1)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularPeopleResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(PopularPeopleResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: "en-US").thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).savePeople(any()).thenDoNothing()
        }

        /*WHEN*/
        repository.getPopularPeople(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularPeopleResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularPeopleURLRequest(page: 1, language: "en-US")
        verify(localDataSource).savePeople(any())
    }

    // failure
    func testPopularPeopleCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularPeopleURLRequest(page: 1)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularPeopleResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: "en-US").thenReturn(request)
        }


        /*WHEN*/
        repository.getPopularPeople(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularPeopleResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularPeopleURLRequest(page: 1, language: "en-US")
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
        
        stub(localDataSource) { stub in
            when(stub).saveTrendings(any()).thenDoNothing()
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
        verify(localDataSource).saveTrendings(any())
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
}
