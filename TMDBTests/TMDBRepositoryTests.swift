//
//  TMDBRepositoryTests.swift
//  TMDBTests
//
//  Created by Tuyen Le on 11.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import XCTest
import Cuckoo
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
            when(stub.send(request: requestMatcher, responseType: any(MovieDetail.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.success(MovieDetail()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 3, language: "en-US")).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub.getMovieDetail(id: 3)).thenReturn(nil)
            when(stub.saveMovie(any())).thenDoNothing()
        }

        /*WHEN*/
        repository.getMovieDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getMovieDetail(id: 3)
        verify(session).send(request: requestMatcher, responseType: any(MovieDetail.Type.self), completion: anyClosure())
        verify(requestBuilder).getMovieDetailURLRequest(id: 3, language: "en-US")
    }

    // no movie detail in realm, get from calling service with valid id, save error
    func testGetMovieDetailCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(MovieDetail.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.success(MovieDetail()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 3, language: "en-US")).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub.getMovieDetail(id: 3)).thenReturn(nil)
            when(stub.saveMovie(any())).thenDoNothing()
        }

        /*WHEN*/
        repository.getMovieDetail(id: 3) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getMovieDetail(id: 3)
        verify(session).send(request: requestMatcher, responseType: any(MovieDetail.Type.self), completion: anyClosure())
        verify(requestBuilder).getMovieDetailURLRequest(id: 3, language: "en-US")
    }

    // no movie detail in realm, get from calling service with invalid id, service error
    func testGetMovieDetailCase3() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 1)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(MovieDetail.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 1, language: "en-US")).thenReturn(request)
        }

        stub(localDataSource) { stub in
            when(stub.getMovieDetail(id: 1)).thenReturn(nil)
        }

        /*WHEN*/
        repository.getMovieDetail(id: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getMovieDetail(id: 1)
        verify(session).send(request: requestMatcher, responseType: any(MovieDetail.Type.self), completion: anyClosure())
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
            when(stub.getMovieDetail(id: 3)).thenReturn(MovieDetail())
        }

        /*WHEN*/
        repository.getMovieDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getMovieDetail(id: 3)
    }

    // MARK: - popular movie
    
    // sucess
    func testPopularMovieCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1, language: "en-US")
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let noRegion = ParameterMatcher<String?>()
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularMovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(PopularMovieResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: "en-US", region: noRegion).thenReturn(request)
        }

        stub(localDataSource) { stub in
            when(stub).savePopularMovies(any()).thenDoNothing()
        }

        /*WHEN*/
        repository.getPopularMovie(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularMovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularMovieURLRequest(page: 1, language: "en-US", region: noRegion)
    }
    
    // failure
    func testPopularMovieCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1, language: "en-US")
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let noRegion = ParameterMatcher<String?>()
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularMovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: "en-US", region: noRegion).thenReturn(request)
        }

        stub(localDataSource) { stub in
            when(stub).savePopularMovies(any()).thenDoNothing()
        }

        /*WHEN*/
        repository.getPopularMovie(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularMovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularMovieURLRequest(page: 1, language: "en-US", region: noRegion)
    }

    // MARK: - popular TV Shows
    func testPopularTVShows() {
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

    // MARK: - popular people
    func testPopularPeople() {
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

        /*WHEN*/
        repository.getPopularPeople(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
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

    // MARK: - test url image data
    
    // no poster data, service call, success, save in realm
    func testPosterImageDataCase1() {
        let expectation = self.expectation(description: "")
        let urlMatcher: ParameterMatcher<URL> = ParameterMatcher()
        let request = TMDBURLRequestBuilder().getImageConfigURLRequest()
        let popularMovie = PopularMovie()
        let dataMatcher: ParameterMatcher<Data> = ParameterMatcher(matchesFunction: { $0 == Data() })
        let movieMatcher: ParameterMatcher<PopularMovie> = ParameterMatcher(matchesFunction: { $0 == popularMovie })
        popularMovie.posterPath = "/jfeijsodifoi.jpg"

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(url: urlMatcher, completion: anyClosure()).then { implementation in
                implementation.1(.success(Data()))
            }
        }

        stub(userSetting) { stub in
            when(stub).imageConfig.get.thenReturn(ImageConfigResult())
        }

        stub(requestBuilder) { stub in
            when(stub).getImageConfigURLRequest().thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getPopularMoviePosterImgData(movieMatcher).thenReturn(nil)
            when(stub).savePopularMoviePosterImgData(movieMatcher, dataMatcher).thenDoNothing()
        }

        /*WHEN*/

        repository.getPosterImageData(from: popularMovie) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(url: urlMatcher, completion: anyClosure())
        verify(userSetting, times(2)).imageConfig.get()
        verify(localDataSource).getPopularMoviePosterImgData(movieMatcher)
    }
    
    // no poster data, service call, failure
    func testPosterImageDataCase2() {
        let expectation = self.expectation(description: "")
        let urlMatcher: ParameterMatcher<URL> = ParameterMatcher()
        let popularMovie = PopularMovie()
        let movieMatcher: ParameterMatcher<PopularMovie> = ParameterMatcher(matchesFunction: { $0 == popularMovie })
        popularMovie.posterPath = "/jfeijsodifoi.jpg"

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(url: urlMatcher, completion: anyClosure()).then { implementation in
                implementation.1(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(userSetting) { stub in
            when(stub).imageConfig.get.thenReturn(ImageConfigResult())
        }
        
        stub(localDataSource) { stub in
            when(stub).getPopularMoviePosterImgData(movieMatcher).thenReturn(nil)
        }

        /*WHEN*/

        repository.getPosterImageData(from: popularMovie) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(url: urlMatcher, completion: anyClosure())
        verify(userSetting, times(2)).imageConfig.get()
        verify(localDataSource).getPopularMoviePosterImgData(movieMatcher)
    }
    
    // poster data in realm, no service call
    func testPosterImageDataCase3() {
        let expectation = self.expectation(description: "")
        let popularMovie = PopularMovie()
        let movieMatcher: ParameterMatcher<PopularMovie> = ParameterMatcher(matchesFunction: { $0 == popularMovie })
        popularMovie.posterPath = "/jfeijsodifoi.jpg"

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getPopularMoviePosterImgData(movieMatcher).thenReturn(Data())
        }

        /*WHEN*/
        repository.getPosterImageData(from: popularMovie) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getPopularMoviePosterImgData(movieMatcher)
    }
    
    // no poster path, no service call, return error
    func testPosterImageDataCase4() {
        let popularMovie = PopularMovie()

        /*WHEN*/
        repository.getPosterImageData(from: popularMovie) { _ in }
    }
    
    // invalid poster path, service call, return error
    func testPosterImageDataCase5() {
        let expectation = self.expectation(description: "")
        let popularMovie = PopularMovie()
        let movieMatcher: ParameterMatcher<PopularMovie> = ParameterMatcher(matchesFunction: { $0 == popularMovie })
        popularMovie.posterPath = "why invalid"

        /*GIVEN*/
        stub(userSetting) { stub in
            when(stub).imageConfig.get.thenReturn(ImageConfigResult())
        }

        stub(localDataSource) { stub in
            when(stub).getPopularMoviePosterImgData(movieMatcher).thenReturn(nil)
        }

        /*WHEN*/

        repository.getPosterImageData(from: popularMovie) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getPopularMoviePosterImgData(movieMatcher)
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
