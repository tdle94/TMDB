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

    var repository: TMDBRepository!
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
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.success(Movie()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)).thenReturn(request)
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
        verify(requestBuilder).getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        verify(localDataSource).saveMovie(any())
    }
    
    // movie detail in realm with same region and language. Get from realm
    func testGetMovieDetailCase2() {
        let expectation = self.expectation(description: "")
        let movie = Movie()
        movie.region = NSLocale.current.regionCode
        movie.language = NSLocale.current.languageCode

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
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
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
            when(stub.getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)).thenReturn(request)
        }
        
        /*WHEN*/
        repository.getMovieDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())
        verify(requestBuilder).getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        verify(localDataSource).getMovie(id: 3)
        verify(localDataSource).saveMovie(any())
    }

    // no movie detail in realm, get from calling service with invalid id, service error
    func testGetMovieDetailCase4() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 1, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 1, language: NSLocale.current.languageCode)).thenReturn(request)
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
        verify(requestBuilder).getMovieDetailURLRequest(id: 1, language: NSLocale.current.languageCode)
    }

    // MARK: - popular movie
    
    // sucess
    func testPopularMovieCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
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
        verify(requestBuilder).getPopularMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
    }
    
    // failure
    func testPopularMovieCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
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
        verify(requestBuilder).getPopularMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
    }

    // MARK: - popular TV Shows
    
    // success
    func testPopularTVShowsCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }

        /*WHEN*/
        repository.getPopularOnTV(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularTVURLRequest(page: 1, language: NSLocale.current.languageCode)
    }
    
    // failure
    func testPopularTVShowsCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }


        /*WHEN*/
        repository.getPopularOnTV(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularTVURLRequest(page: 1, language: NSLocale.current.languageCode)
    }

    // MARK: - popular people

    // success
    func testPopularPeopleCase1() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularPeopleURLRequest(page: 1, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PeopleResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(PeopleResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }

        /*WHEN*/
        repository.getPopularPeople(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PeopleResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularPeopleURLRequest(page: 1, language: NSLocale.current.languageCode)
    }

    // failure
    func testPopularPeopleCase2() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularPeopleURLRequest(page: 1, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PeopleResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }


        /*WHEN*/
        repository.getPopularPeople(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PeopleResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularPeopleURLRequest(page: 1, language: NSLocale.current.languageCode)
    }

    // MARK: - trending
    private func setUpTrendingTest(time: TrendingTime, type: MediaType) {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTrendingURLRequest(page: 1, time: time, type: type)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let trendingTimeMatcher = ParameterMatcher<TrendingTime>(matchesFunction: { $0 == time })
        let trendingTypeMatcher = ParameterMatcher<MediaType>(matchesFunction: { $0 == type })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TrendingResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TrendingResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getTrendingURLRequest(page: 1, time: trendingTimeMatcher, type: trendingTypeMatcher).thenReturn(request)
        }

        /*WHEN*/
        repository.getTrending(page: 1, time: time, type: type) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TrendingResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getTrendingURLRequest(page: 1, time: trendingTimeMatcher, type: trendingTypeMatcher)
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
        let request = TMDBURLRequestBuilder().getTrendingURLRequest(page: 1, time: .today, type: .all)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let trendingTimeMatcher = ParameterMatcher<TrendingTime>(matchesFunction: { $0 == .today })
        let trendingTypeMatcher = ParameterMatcher<MediaType>(matchesFunction: { $0 == .all })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TrendingResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getTrendingURLRequest(page: 1, time: trendingTimeMatcher, type: trendingTypeMatcher).thenReturn(request)
        }

        /*WHEN*/
        repository.getTrending(page: 1, time: .today, type: .all) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TrendingResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getTrendingURLRequest(page: 1, time: trendingTimeMatcher, type: trendingTypeMatcher)
    }

    // MARK: - similar movies

    func testGetSimilarMovieInRealm() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let movie = Movie()
        let similarMovie = MovieResult()
        similarMovie.movies.append(Movie())
        similarMovie.totalResults = 2
        similarMovie.page = 1
        similarMovie.totalPages = 2
        movie.id = 3
        movie.similar = similarMovie

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }

        /*WHEN*/
        repository.getSimilarMovies(from: 3, page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session, never()).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder, never()).getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testGetNonExistMovie() {
        let similarExpectation = self.expectation(description: "")
        let recommendExpectation = self.expectation(description: "")
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(nil)
        }
        
        /*WHEN*/
        repository.getSimilarMovies(from: 3, page: 1) { result in
            similarExpectation.fulfill()
        }
        
        repository.getRecommendMovies(from: 3, page: 1) { result in
            recommendExpectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(localDataSource, times(2)).getMovie(id: 3)
    }

    func testGetNonExistSimilarMovie() {
        let expectation = self.expectation(description: "")
        let movie = Movie()
        movie.id = 3
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        
        /*WHEN*/
        repository.getSimilarMovies(from: 3, page: 1) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testGetSimilarMovieNewPage() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getSimilarMoviesURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let movie = Movie()
        let similarMovie = MovieResult()
        similarMovie.movies.append(Movie())
        similarMovie.totalResults = 2
        similarMovie.page = 1
        similarMovie.totalPages = 2
        movie.id = 3
        movie.similar = similarMovie

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getSimilarMoviesURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
            when(stub).saveSimilarMovie(any(), to: any()).thenDoNothing()
        }

        /*WHEN*/
        repository.getSimilarMovies(from: 3, page: 2) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getSimilarMoviesURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode)
        verify(localDataSource).getMovie(id: 3)
        verify(localDataSource).saveSimilarMovie(any(), to: any())
    }
    
    // MARK: - recommend movies
    
    // no movie in realm, service call, success
    func testGetRecommendMovieInRealm() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
        let movie = Movie()
        let recommendation = MovieResult()
        movie.id = 3
        recommendation.page = 1
        recommendation.totalPages = 2
        recommendation.totalResults = 2
        recommendation.movies.append(Movie())
        movie.recommendations = recommendation

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }

        /*WHEN*/
        repository.getRecommendMovies(from: 3, page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session, never()).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder, never()).getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
        verify(localDataSource).getMovie(id: 3)
    }

    func testGetNonExistRecommendMovie() {
        let expectation = self.expectation(description: "")
        let movie = Movie()
        movie.id = 3
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        
        /*WHEN*/
        repository.getRecommendMovies(from: 3, page: 1) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testRecommendMovieNewPage() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getRecommendMoviesURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })
            
        let movieInRealm = Movie()

        let newMovieResult = MovieResult()
        let newMovie = Movie()
        newMovie.id = 10
        newMovieResult.movies.append(newMovie)

        movieInRealm.id = 3
        movieInRealm.recommendations = MovieResult()
        movieInRealm.recommendations?.totalResults = 2
        movieInRealm.recommendations?.page = 1
        movieInRealm.recommendations?.totalPages = 2
        movieInRealm.recommendations?.movies.append(Movie())
            
        let newListMovieMatcher = ParameterMatcher<List<Movie>>(matchesFunction: { $0 == newMovieResult.movies })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(newMovieResult))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getRecommendMoviesURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode).thenReturn(request)
        }
            
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movieInRealm)
            when(stub).saveRecommendMovie(newListMovieMatcher, to: 3).thenDoNothing()
        }

        /*WHEN*/
        repository.getRecommendMovies(from: 3, page: 2) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getRecommendMoviesURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode)
        verify(localDataSource).getMovie(id: 3)
        verify(localDataSource).saveRecommendMovie(any(), to: any())
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
        XCTAssertEqual(repository.getMovieKeywords(from: 3).count, 1)
        
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
        XCTAssertEqual(repository.getMovieKeywords(from: 3).count, 0)

        /*THEN*/
        verify(localDataSource).getMovie(id: 3)
    }
    
    // MARK: - movie genre
    func testGetValidGenreMoviey() {
        let movie = Movie()
        movie.id = 3
        movie.genres.append(Genre())
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        
        /*WHEN*/
        XCTAssertEqual(repository.getMovieGenre(from: 3).count, 1)

        /*THEN*/
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testGetInvalidGenreFromMovie() {
        let movie = Movie()
        movie.id = 3

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        
        /*WHEN*/
        XCTAssertEqual(repository.getMovieGenre(from: 3).count, 0)
        
        /*THEN*/
        verify(localDataSource).getMovie(id: 3)
    }
    
    // MARK: - multisearch
    func testGetMultiSearch() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMultiSearchURLRequest(query: "T", language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MultiSearchResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MultiSearchResult(page: 1, results: [], totalResults: 1, totalPages: 1)))
            }
        }
        
        stub(requestBuilder) { stub in
            when(stub).getMultiSearchURLRequest(query: "T", language: NSLocale.current.languageCode, region: NSLocale.current.regionCode, page: 1).thenReturn(request)
        }
        
        /*WHEN*/
        repository.multiSearch(query: "T", page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(MultiSearchResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getMultiSearchURLRequest(query: "T", language: NSLocale.current.languageCode, region: NSLocale.current.regionCode, page: 1)
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

        XCTAssertEqual(repository.getTVCredits(from: 1), Array(tvCredits.cast))
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

        XCTAssertEqual(repository.getMovieCredits(from: 1), Array(movieCredits.cast))
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
        person.language = NSLocale.current.languageCode

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
        let request = TMDBURLRequestBuilder().getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
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
            when(stub).getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode).thenReturn(request)
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
        verify(requestBuilder).getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
    }
    
    func testGetTVShowInRealm() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
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
        verify(requestBuilder, never()).getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
    }
    
    // MARK: - tv show keywords
    func testGetExistingTVShowKeywords() {
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
    
    func testGetNonExistingTVShowKeywords() {
        let tvShow = TVShow()

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        XCTAssertEqual(repository.getTVShowKeywords(from: 3).count, 0)
        
        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }
    
    // MARK: - tv show genre
    func testGetExisingTVShowGenre() {
        let tvShow = TVShow()
        tvShow.genres.append(Genre())
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        XCTAssertEqual(repository.getTVShowGenres(from: 3).count, 1)
        
        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }
    
    func testGetNonExisitingTVShowGenre() {
        let tvShow = TVShow()
        tvShow.id = 3
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        XCTAssertEqual(repository.getTVShowGenres(from: 3).count, 0)
        
        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }
    
    // MARK: - similar tv show
    func testGetSimilarTVShowInRealm() {
        let expectaion = self.expectation(description: "")
        let tvShow = TVShow()
        let similarTVShow = TVShowResult()
        similarTVShow.onTV.append(TVShow())
        similarTVShow.page = 1
        similarTVShow.totalResults = 2
        similarTVShow.totalPages = 2
        tvShow.id = 3
        tvShow.similar = similarTVShow

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        repository.getSimilarTVShows(from: 3, page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectaion.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
    }
    
    func testGetNonExistSimilarTVShow() {
        let expectaion = self.expectation(description: "")
        let tvShow = TVShow()
        tvShow.id = 3

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        repository.getSimilarTVShows(from: 3, page: 4) { result in
            expectaion.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
    }
    
    func testGetSimilarTVShowNewPage() {
        let expectaion = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getSimilarTVShowsURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let similarTVShow = TVShowResult()
        let tvShow = TVShow()
        similarTVShow.onTV.append(TVShow())
        similarTVShow.page = 1
        similarTVShow.totalPages = 2
        similarTVShow.totalResults = 2
        tvShow.similar = similarTVShow
        tvShow.id = 3

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
            when(stub).saveSimilarTVShow(any(), to: 3).thenDoNothing()
        }

        stub(requestBuilder) { stub in
            when(stub).getSimilarTVShowsURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode).thenReturn(request)
        }

        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }

        /*WHEN*/
        repository.getSimilarTVShows(from: 3, page: 2) { result in
            XCTAssertNoThrow(try! result.get())
            expectaion.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
        verify(localDataSource).saveSimilarTVShow(any(), to: 3)
        verify(requestBuilder).getSimilarTVShowsURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode)
    }
    
    // MARK: - get recommend tv show
    func testGetRecommendTVShowInRealm() {
        let expectaion = self.expectation(description: "")
        let tvShow = TVShow()
        let recommendTVShow = TVShowResult()
        recommendTVShow.onTV.append(TVShow())
        recommendTVShow.page = 1
        recommendTVShow.totalResults = 2
        recommendTVShow.totalPages = 2
        tvShow.id = 3
        tvShow.recommendations = recommendTVShow
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        repository.getRecommendTVShows(from: 3, page: 1) { result in
            XCTAssertNoThrow({try result.get()})
            expectaion.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
    }
    
    func testGetNonExistTVShow() {
        let similarExpectation = self.expectation(description: "")
        let recommendExpectation = self.expectation(description: "")

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(nil)
        }
        
        /*WHEN*/
        repository.getRecommendTVShows(from: 3, page: 1) { result in
            similarExpectation.fulfill()
        }
        
        repository.getSimilarTVShows(from: 3, page: 1) { result in
            recommendExpectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource, times(2)).getTVShow(id: 3)
    }
    
    func testGetNonExistTVShowRecommendation() {
        let expectaion = self.expectation(description: "")
        let tvShow = TVShow()
        tvShow.id = 3
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        repository.getRecommendTVShows(from: 3, page: 1) { result in
            expectaion.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
    }
    
    func testGetRecommendTVShowNewPage() {
        let expectaion = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getRecommendTVShowURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let tvShow = TVShow()
        let recommendTVShow = TVShowResult()
        recommendTVShow.onTV.append(TVShow())
        recommendTVShow.page = 1
        recommendTVShow.totalResults = 2
        recommendTVShow.totalPages = 2
        tvShow.id = 3
        tvShow.recommendations = recommendTVShow
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
            when(stub).saveRecommendTVShow(any(), to: 3).thenDoNothing()
        }
        
        stub(requestBuilder) { stub in
            when(stub).getRecommendTVShowURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }
        
        /*WHEN*/
        repository.getRecommendTVShows(from: 3, page: 2) { result in
            expectaion.fulfill()
        }
        
        /*GIVEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
        verify(localDataSource).saveRecommendTVShow(any(), to: 3)
        verify(requestBuilder).getRecommendTVShowURLRequest(from: 3, page: 2, language: NSLocale.current.languageCode)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }

    // MARK: - tv show cast
    func testGetExistTVShowCast() {
        let tvShow = TVShow()
        tvShow.credits = CreditResult()
        tvShow.credits?.cast.append(Cast())

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }

        /*WHEN*/
        XCTAssertEqual(repository.getTVShowCast(from: 3).count, 1)
        
        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }

    func testGetEmptyTVShowCast() {
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(nil)
        }

        /*WHEN*/
        XCTAssertEqual(repository.getTVShowCast(from: 3).count, 0)
        
        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }

    // MARK: - tv show crew
    func testGetExistTVShowCrew() {
        let tvShow = TVShow()
        tvShow.credits = CreditResult()
        tvShow.credits?.crew.append(Crew())

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }

        /*WHEN*/
        XCTAssertEqual(repository.getTVShowCrew(from: 3).count, 1)

        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }

    func testGetEmptyTVShowCrew() {
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(nil)
        }

        /*WHEN*/
        XCTAssertEqual(repository.getTVShowCrew(from: 3).count, 0)

        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }

    // MARK: - tv show reviews
    func testGetExistTVShowReview() {
        let tvShow = TVShow()
        let reviewResult = ReviewResult()
        reviewResult.reviews.append(Review())
        tvShow.id = 3
        tvShow.reviews = reviewResult
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        XCTAssertEqual(repository.getTVShowReviews(from: 3).count, 1)
        
        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }
    
    func testGetEmptyTVShowReview() {
        let tvShow = TVShow()
        tvShow.id = 3
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        XCTAssertEqual(repository.getTVShowReviews(from: 3).count, 0)
        
        /*THEN*/
        verify(localDataSource).getTVShow(id: 3)
    }
    
    // MARK: - tv show season
    func testGetTVShowSeasonInRealm() {
        let expectation = self.expectation(description: "")
        let tvShow = TVShow()
        let season = Season()
        let request = TMDBURLRequestBuilder().getTVShowSeasonDetailURLRequest(tvShowId: 3, seasonNumber: 1, language: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let seasonMatcher: ParameterMatcher<Season> = ParameterMatcher<Season>(matchesFunction: { $0 == season })
        season.number = 1
        season.episodes.append(Episode())
        season.videos = VideoResult()
        season.images = ImageResult()
        season.credits = CreditResult()
        tvShow.id = 3
        tvShow.seasons.append(season)
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowSeason(tvShowId: 3, seasonNumber: 1).thenReturn(season)
            when(stub).saveTVShowSeason(seasonMatcher, to: 3).thenDoNothing()
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(Season.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(season))
            }
        }
        /*WHEN*/
        
        repository.getTVShowSeasonDetail(from: 3, seasonNumber: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowSeason(tvShowId: 3, seasonNumber: 1)
        verify(localDataSource, never()).saveTVShowSeason(seasonMatcher, to: 1)
        verify(session, never()).send(request: requestMatcher, responseType: any(Season.Type.self), completion: anyClosure())
    }
    
    func testGetTVShowSeasonRemoteSuccess() {
        let expectation = self.expectation(description: "")
        let tvShow = TVShow()
        let request = TMDBURLRequestBuilder().getTVShowSeasonDetailURLRequest(tvShowId: 3, seasonNumber: 1, language: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        tvShow.id = 3

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowSeason(tvShowId: 3, seasonNumber: 1).thenReturn(nil)
            when(stub).saveTVShowSeason(any(), to: 3).thenDoNothing()
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(Season.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(Season()))
            }
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowSeasonDetailURLRequest(tvShowId: 3, seasonNumber: 1, language: any()).thenReturn(request)
        }
        /*WHEN*/
        
        repository.getTVShowSeasonDetail(from: 3, seasonNumber: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowSeason(tvShowId: 3, seasonNumber: 1)
        verify(localDataSource).saveTVShowSeason(any(), to: 3)
        verify(requestBuilder).getTVShowSeasonDetailURLRequest(tvShowId: 3, seasonNumber: 1, language: any())
        verify(session).send(request: requestMatcher, responseType: any(Season.Type.self), completion: anyClosure())
    }
    
    func testGetTVShowSeasonRemoteFail() {
        let expectation = self.expectation(description: "")
        let tvShow = TVShow()
        let request = TMDBURLRequestBuilder().getTVShowSeasonDetailURLRequest(tvShowId: 4, seasonNumber: 2, language: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        tvShow.id = 4

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowSeason(tvShowId: 4, seasonNumber: 2).thenReturn(nil)
            when(stub).saveTVShowSeason(any(), to: 4).thenDoNothing()
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(Season.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowSeasonDetailURLRequest(tvShowId: 4, seasonNumber: 2, language: any()).thenReturn(request)
        }
        /*WHEN*/
        
        repository.getTVShowSeasonDetail(from: 4, seasonNumber: 2) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowSeason(tvShowId: 4, seasonNumber: 2)
        verify(requestBuilder).getTVShowSeasonDetailURLRequest(tvShowId: 4, seasonNumber: 2, language: any())
        verify(localDataSource, never()).saveTVShowSeason(any(), to: 4)
        verify(session).send(request: requestMatcher, responseType: any(Season.Type.self), completion: anyClosure())
    }
    
    // MARK: - tv show image
    func testGetTVShowImageInRealm() {
        let expectation = self.expectation(description: "")
        let tvShow = TVShow()
        tvShow.images = ImageResult()
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
        }
        
        /*WHEN*/
        repository.getTVShowImages(from: 3) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
    }
    
    func testGetTVShowRemoteImageSuccess() {
        let expectation = self.expectation(description: "")
        let tvShow = TVShow()
        let request = TMDBURLRequestBuilder().getTVShowImagesURLRequest(from: 3)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(ImageResult()))
            }
        }
        
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
            when(stub).saveTVShowImages(any(), to: 3).thenDoNothing()
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowImagesURLRequest(from: 3).thenReturn(request)
        }
        /*WHEN*/
        repository.getTVShowImages(from: 3) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShow(id: 3)
        verify(requestBuilder).getTVShowImagesURLRequest(from: 3)
        verify(localDataSource).saveTVShowImages(any(), to: 3)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: any())
    }

    func testGetTVShowRemoteImageFail() {
        let expectation = self.expectation(description: "")
        let tvShow = TVShow()
        let request = TMDBURLRequestBuilder().getTVShowImagesURLRequest(from: 3)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }
        
        stub(localDataSource) { stub in
            when(stub).getTVShow(id: 3).thenReturn(tvShow)
            when(stub).saveTVShowImages(any(), to: 3).thenDoNothing()
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowImagesURLRequest(from: 3).thenReturn(request)
        }

        /*WHEN*/
        repository.getTVShowImages(from: 3) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getTVShowImagesURLRequest(from: 3)
        verify(localDataSource).getTVShow(id: 3)
        verify(localDataSource, never()).saveTVShowImages(any(), to: 3)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: any())
    }
    
    // MARK: - get movie images
    func testGetMovieImagesFromRealm() {
        let expectation = self.expectation(description: "")
        let movie = Movie()
        movie.images = ImageResult()
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
        }
        /*WHEN*/
        repository.getMovieImages(from: 3) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getMovie(id: 3)
    }
    
    func testGetMovieRemoteImageSuccess() {
        let expectation = self.expectation(description: "")
        let movie = Movie()
        let request = TMDBURLRequestBuilder().getMovieImagesURLRequest(from: 3)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(ImageResult()))
            }
        }
        
        stub(localDataSource) { stub in
            when(stub).getMovie(id: 3).thenReturn(movie)
            when(stub).saveMovieImages(any(), to: 3).thenDoNothing()
        }

        stub(requestBuilder) { stub in
            when(stub).getMovieImagesURLRequest(from: 3).thenReturn(request)
        }

        /*WHEN*/
        repository.getMovieImages(from: 3) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getMovie(id: 3)
        verify(requestBuilder).getMovieImagesURLRequest(from: 3)
        verify(localDataSource).saveMovieImages(any(), to: 3)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: any())
    }
    
    func testGetMovieRemoteImageFail() {
        let expectation = self.expectation(description: "")
        let tvShow = Movie()
        let request = TMDBURLRequestBuilder().getMovieImagesURLRequest(from: 1)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }

        stub(localDataSource) { stub in
            when(stub).getMovie(id: 1).thenReturn(tvShow)
            when(stub).saveMovieImages(any(), to: 1).thenDoNothing()
        }
        
        stub(requestBuilder) { stub in
            when(stub).getMovieImagesURLRequest(from: 1).thenReturn(request)
        }

        /*WHEN*/
        repository.getMovieImages(from: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getMovieImagesURLRequest(from: 1)
        verify(localDataSource).getMovie(id: 1)
        verify(localDataSource, never()).saveMovieImages(any(), to: 1)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: any())
    }

    // MARK: - refresh movie detail
    func testRefreshMovieDetail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(Movie()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode).thenReturn(request)
        }

        stub(localDataSource) { stub in
            when(stub).saveMovie(any()).thenDoNothing()
        }

        /*WHEN*/
        repository.refreshMovie(id: 3) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).saveMovie(any())
        verify(requestBuilder).getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        verify(session).send(request: requestMatcher, responseType: any(Movie.Type.self), completion: anyClosure())
    }

    // MARK: - refresh tv show
    func testRefreshTVShowDetail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShow.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShow()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode).thenReturn(request)
        }

        stub(localDataSource) { stub in
            when(stub).saveTVShow(any()).thenDoNothing()
        }

        /*WHEN*/
        repository.refreshTVShow(id: 3) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).saveTVShow(any())
        verify(requestBuilder).getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        verify(session).send(request: requestMatcher, responseType: any(TVShow.Type.self), completion: anyClosure())
    }
    
    // MARK: - tv show episode
    func testGetTVShowEpisodeInRealm() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowEpisodeURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let episode = Episode()
        episode.credits = CreditResult()
        episode.videos = VideoResult()
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(Episode.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(Episode()))
            }
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowEpisodeURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 1).thenReturn(episode)
            when(stub).saveTVShowEpisode(tvShowId: 3, seasonNumber: 1, episode: any()).thenDoNothing()
        }
        
        /*WHEN*/
        repository.getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 1) { _ in
            expectation.fulfill()
        }
        
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 1)
        verify(localDataSource, never()).saveTVShowEpisode(tvShowId: 3, seasonNumber: 1, episode: any())
        verify(session, never()).send(request: requestMatcher, responseType: any(Episode.Type.self), completion: anyClosure())
        verify(requestBuilder, never()).getTVShowEpisodeURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1, language: NSLocale.current.languageCode)
    }

    func testGetTVShowEpisodeNotInRealmSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowEpisodeURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(Episode.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(Episode()))
            }
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowEpisodeURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 1).thenReturn(nil)
            when(stub).saveTVShowEpisode(tvShowId: 3, seasonNumber: 1, episode: any()).thenDoNothing()
        }
        
        /*WHEN*/
        repository.getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 1) { _ in
            expectation.fulfill()
        }
        
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 1)
        verify(localDataSource).saveTVShowEpisode(tvShowId: 3, seasonNumber: 1, episode: any())
        verify(session).send(request: requestMatcher, responseType: any(Episode.Type.self), completion: anyClosure())
        verify(requestBuilder).getTVShowEpisodeURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1, language: NSLocale.current.languageCode)
    }
    
    func testGetTVShowNotInRealmFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowEpisodeURLRequest(from: 1, seasonNumber: 2, episodeNumber: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(Episode.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowEpisodeURLRequest(from: 1, seasonNumber: 2, episodeNumber: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        stub(localDataSource) { stub in
            when(stub).getTVShowEpisode(from: 1, seasonNumber: 2, episodeNumber: 1).thenReturn(nil)
            when(stub).saveTVShowEpisode(tvShowId: 1, seasonNumber: 2, episode: any()).thenDoNothing()
        }
        
        /*WHEN*/
        repository.getTVShowEpisode(from: 1, seasonNumber: 2, episodeNumber: 1) { _ in
            expectation.fulfill()
        }
        
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowEpisode(from: 1, seasonNumber: 2, episodeNumber: 1)
        verify(localDataSource, never()).saveTVShowEpisode(tvShowId: 1, seasonNumber: 2, episode: any())
        verify(session).send(request: requestMatcher, responseType: any(Episode.Type.self), completion: anyClosure())
        verify(requestBuilder).getTVShowEpisodeURLRequest(from: 1, seasonNumber: 2, episodeNumber: 1, language: NSLocale.current.languageCode)
    }
    
    // MARK: - tv show episode cast
    func testGetTVShowEpisodeCastInRealm() {
        let tvShow = TVShow()
        let season = Season()
        let episode = Episode()
        let credit = CreditResult()
        credit.cast.append(Cast())
        tvShow.id = 3
        episode.id = 3
        episode.episodeNumber = 3
        episode.seasonNumber = 1
        episode.credits = CreditResult()
        episode.credits?.cast.append(Cast())
        season.number = 1
        season.episodes.append(episode)
        tvShow.seasons.append(season)

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 3).thenReturn(episode)
        }
        /*WHEN*/
        let casts = repository.getTVShowEpisodeCast(from: 3, seasonNumber: 1, episodeNumber: 3)
        XCTAssertEqual(casts.count, 1)

        /*THEN*/
        verify(localDataSource).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 3)
    }

    // MARK: - tv show episode crew
    func testGetTVShowEpisodeCrewInRealm() {
        let tvShow = TVShow()
        let season = Season()
        let episode = Episode()
        let credit = CreditResult()
        credit.cast.append(Cast())
        credit.crew.append(Crew())
        tvShow.id = 3
        episode.id = 3
        episode.episodeNumber = 3
        episode.seasonNumber = 1
        episode.credits = CreditResult()
        episode.credits?.crew.append(Crew())
        season.number = 1
        season.episodes.append(episode)
        tvShow.seasons.append(season)

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 3).thenReturn(episode)
        }
        /*WHEN*/
        let crews = repository.getTVShowEpisodeCrew(from: 3, seasonNumber: 1, episodeNumber: 3)
        XCTAssertEqual(crews.count, 1)
        
        /*THEN*/
        verify(localDataSource).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 3)
    }

    // MARK: - tv show episode guest star
    func testGetTVShowEpisodeGuestStarInRealm() {
        let tvShow = TVShow()
        let season = Season()
        let episode = Episode()
        episode.guestStars.append(Cast())
        tvShow.id = 3
        episode.id = 3
        episode.episodeNumber = 3
        episode.seasonNumber = 1
        episode.credits = CreditResult()
        season.number = 1
        season.episodes.append(episode)
        tvShow.seasons.append(season)

        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 3).thenReturn(episode)
        }
        /*WHEN*/
        let guestStars = repository.getTVShowEpisodeGuestStar(from: 3, seasonNumber: 1, episodeNumber: 3)
        XCTAssertEqual(guestStars.count, 1)

        /*THEN*/
        verify(localDataSource).getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 3)
    }
    
    // MARK: - tv show season image
    func testGetTVShowSeasonImageInRealm() {
        let expectation = self.expectation(description: "")
        let season = Season()
        season.id = 1
        season.images = ImageResult()
        season.number = 1
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowSeason(tvShowId: 1, seasonNumber: 1).thenReturn(season)
        }
        /*WHEN*/
        repository.getTVShowSeasonImage(from: 1, seasonNumber: 1) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowSeason(tvShowId: 1, seasonNumber: 1)
    }
    
    func testGetTVShowSeasonImageRemote() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowSeasonImageURLRequest(from: 1, seasonNumber: 1)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let season = Season()
        season.id = 1
        season.number = 1
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowSeason(tvShowId: 1, seasonNumber: 1).thenReturn(season)
            when(stub).saveTVShowSeasonImage(any(), to: 1, seasonNumber: 1).thenDoNothing()
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowSeasonImageURLRequest(from: 1, seasonNumber: 1).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(ImageResult()))
            }
        }
        /*WHEN*/
        repository.getTVShowSeasonImage(from: 1, seasonNumber: 1) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowSeason(tvShowId: 1, seasonNumber: 1)
        verify(localDataSource).saveTVShowSeasonImage(any(), to: 1, seasonNumber: 1)
        verify(requestBuilder).getTVShowSeasonImageURLRequest(from: 1, seasonNumber: 1)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure())
    }
    
    // tv show episode image
    func testGetTVShowEpisodeImageInrealm() {
        let expectation = self.expectation(description: "")
        let episode = Episode()
        episode.images = ImageResult()
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowEpisode(from: 1, seasonNumber: 1, episodeNumber: 1).thenReturn(episode)
        }
        /*WHEN*/
        repository.getTVShowEpisodeImage(from: 1, seasonNumber: 1, episodeNumber: 1) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowEpisode(from: 1, seasonNumber: 1, episodeNumber: 1)
    }
    
    func testGetTVShowEpisodeImageRemote() {
        let expectation = self.expectation(description: "")
        let episode = Episode()
        let request = TMDBURLRequestBuilder().getTVShowEpisodeImageURLRequest(from: 1, seasonNumber: 1, episodeNumber: 1)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(localDataSource) { stub in
            when(stub).getTVShowEpisode(from: 1, seasonNumber: 1, episodeNumber: 1).thenReturn(episode)
            when(stub).saveTVShowEpisodeImage(any(), to: 1, seasonNumber: 1, episodeNumber: 1).thenDoNothing()
        }
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowEpisodeImageURLRequest(from: 1, seasonNumber: 1, episodeNumber: 1).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(ImageResult()))
            }
        }
        /*WHEN*/
        repository.getTVShowEpisodeImage(from: 1, seasonNumber: 1, episodeNumber: 1) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getTVShowEpisode(from: 1, seasonNumber: 1, episodeNumber: 1)
        verify(localDataSource).saveTVShowEpisodeImage(any(), to: 1, seasonNumber: 1, episodeNumber: 1)
        verify(requestBuilder).getTVShowEpisodeImageURLRequest(from: 1, seasonNumber: 1, episodeNumber: 1)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure())
    }
    
    // MARK: - now playing movie
    func testGetNowPlayingMovieSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getNowPlayingMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getNowPlayingMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }
        
        /*WHEN*/
        repository.getNowPlayingMovie(page: 1) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getNowPlayingMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }
    
    func testGetNowPlayingMovieFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getNowPlayingMovieURLRequest(page: 3, language: nil, region: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getNowPlayingMovieURLRequest(page: 3, language: any(), region: any()).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }
        
        /*WHEN*/
        repository.getNowPlayingMovie(page: 3) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getNowPlayingMovieURLRequest(page: 3, language: any(), region: any())
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }
    
    // MARK: - top rated movie
    func testGetTopRateMovieSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTopRateMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getTopRateMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }
        
        /*WHEN*/
        repository.getTopRateMovie(page: 1) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getTopRateMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }
    
    func testGetTopRateMovieFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTopRateMovieURLRequest(page: 3, language: nil, region: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getTopRateMovieURLRequest(page: 3, language: any(), region: any()).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }
        
        /*WHEN*/
        repository.getTopRateMovie(page: 3) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getTopRateMovieURLRequest(page: 3, language: any(), region: any())
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }
    
    // MARK: - upcoming movie
    func testGetUpcomingMovieSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getUpcomingMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getUpcomingMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }
        
        /*WHEN*/
        repository.getUpcomingMovie(page: 1) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getUpcomingMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }

    func testGetUpcomingMovieFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getUpcomingMovieURLRequest(page: 3, language: nil, region: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getUpcomingMovieURLRequest(page: 3, language: any(), region: any()).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }
        
        /*WHEN*/
        repository.getUpcomingMovie(page: 3) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getUpcomingMovieURLRequest(page: 3, language: any(), region: any())
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }
    
    // MARK: - tv show on the air
    func testGetTVShowOnTheAirSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowOnTheAirURLRequest(page: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowOnTheAirURLRequest(page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }
        
        /*WHEN*/
        repository.getTVShowOnTheAir(page: 1) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getTVShowOnTheAirURLRequest(page: 1, language: NSLocale.current.languageCode)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }
    
    func testGetTVShowOnTheAirFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowOnTheAirURLRequest(page: 3, language: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowOnTheAirURLRequest(page: 3, language: any()).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }
        
        /*WHEN*/
        repository.getTVShowOnTheAir(page: 3) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getTVShowOnTheAirURLRequest(page: 3, language: any())
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }
    
    // MARK: - top rated tv show
    func testGetTopRatedTVShowSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTopRatedTVShowURLRequest(page: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getTopRatedTVShowURLRequest(page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }

        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }
        
        /*WHEN*/
        repository.getTopRatedTVShow(page: 1) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getTopRatedTVShowURLRequest(page: 1, language: NSLocale.current.languageCode)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }
    
    func testGetTopRatedTVShowFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTopRatedTVShowURLRequest(page: 3, language: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getTopRatedTVShowURLRequest(page: 3, language: any()).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }
        
        /*WHEN*/
        repository.getTopRatedTVShow(page: 3) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getTopRatedTVShowURLRequest(page: 3, language: any())
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }
    
    // MARK: - tv show airing today
    func testGetTVShowAiringTodaySuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowAiringTodayURLRequest(page: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getTVShowAiringTodayURLRequest(page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }
        
        /*WHEN*/
        repository.getTVShowAiringToday(page: 1) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getTVShowAiringTodayURLRequest(page: 1, language: NSLocale.current.languageCode)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }
    
    func testGetTVShowAiringTodayFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowAiringTodayURLRequest(page: 3, language: nil)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /*GIVEN*/

        stub(requestBuilder) { stub in
            when(stub).getTVShowAiringTodayURLRequest(page: 3, language: any()).thenReturn(request)
        }

        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }

        /*WHEN*/
        repository.getTVShowAiringToday(page: 3) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getTVShowAiringTodayURLRequest(page: 3, language: any())
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }

    // MARK: - all movies
    func testGetAllMovieSuccess() {
        let expectation = self.expectation(description: "")
        var movieQuery = DiscoverQuery(type: .movie)
        movieQuery.primaryReleaseYear = 2019
        movieQuery.keywords = [Keyword(name: "lsdkjfdls", id: 3243)]
        movieQuery.withOriginalLanguage = "532"
        movieQuery.withGenres = "32"
        let queryMatcher: ParameterMatcher<DiscoverQuery> = ParameterMatcher()
        let request = TMDBURLRequestBuilder().getAllMovieURLRequest(query: movieQuery)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        
        stub(requestBuilder) { stub in
            when(stub).getAllMovieURLRequest(query: queryMatcher).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(MovieResult()))
            }
        }
        
        /*WHEN*/
        repository.getAllMovie(query: movieQuery) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getAllMovieURLRequest(query: queryMatcher)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }

    func testGetAllMovieFail() {
        let movieQuery = DiscoverQuery(type: .movie)
        let queryMatcher: ParameterMatcher<DiscoverQuery> = ParameterMatcher()
        let request = TMDBURLRequestBuilder().getAllMovieURLRequest(query: movieQuery)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let expectation = self.expectation(description: "")

        /*GIVEN*/
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }

        stub(requestBuilder) { stub in
            when(stub).getAllMovieURLRequest(query: queryMatcher).thenReturn(request)
        }
        
        /*WHEN*/
        repository.getAllMovie(query: movieQuery) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getAllMovieURLRequest(query: queryMatcher)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }

    // MARK: - all tv shows
    func testGetAllTVShowSuccess() {
        let expectation = self.expectation(description: "")
        var tvQuery = DiscoverQuery(type: .tv)
        tvQuery.primaryReleaseYear = 2019
        tvQuery.keywords = [Keyword(name: "dslfjdsl", id: 3243)]
        tvQuery.withOriginalLanguage = "532"
        tvQuery.withGenres = "32"
        let queryMatcher: ParameterMatcher<DiscoverQuery> = ParameterMatcher()
        let request = TMDBURLRequestBuilder().getAllTVShowURLRequest(query: tvQuery)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(requestBuilder) { stub in
            when(stub).getAllTVShowURLRequest(query: queryMatcher).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }
        
        /*WHEN*/
        repository.getAllTVShow(query: tvQuery) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getAllTVShowURLRequest(query: queryMatcher)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }
    
    func testGetAllTVShowFail() {
        let expectation = self.expectation(description: "")
        let movieQuery = DiscoverQuery(type: .tv)
        let queryMatcher: ParameterMatcher<DiscoverQuery> = ParameterMatcher()
        let request = TMDBURLRequestBuilder().getAllTVShowURLRequest(query: movieQuery)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/

        stub(requestBuilder) { stub in
            when(stub).getAllTVShowURLRequest(query: queryMatcher).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError()))
            }
        }
        
        /*WHEN*/
        repository.getAllTVShow(query: movieQuery) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getAllTVShowURLRequest(query: queryMatcher)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }

    // MARK: - guest session
    func testGetGuestSessionRemotelySuccess() {
        let request = TMDBURLRequestBuilder().getGuestSessionURLRequest()
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        let guestSession = GuestSession(success: true, id: "hello", expiration: "")
        
        /*GIVEN*/
        stub(requestBuilder) { stub in
            when(stub).getGuestSessionURLRequest().thenReturn(request)
        }
        
        stub(userSetting) { stub in
            when(stub).guestSession.get.thenReturn(nil)
            when(stub).guestSession.set(any()).thenDoNothing()
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(GuestSession.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(guestSession))
            }
        }
        
        /*WHEN*/
        
        repository.getGuestSession()
        
        /*THEN*/
        verify(requestBuilder).getGuestSessionURLRequest()
        verify(session).send(request: requestMatcher, responseType: any(GuestSession.Type.self), completion: anyClosure())
        verify(userSetting).guestSession.get()
    }
    
    func testGetGuestSessionRemotelyfail() {
        let request = TMDBURLRequestBuilder().getGuestSessionURLRequest()
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(requestBuilder) { stub in
            when(stub).getGuestSessionURLRequest().thenReturn(request)
        }
        
        stub(userSetting) { stub in
            when(stub).guestSession.get.thenReturn(nil)
            when(stub).guestSession.set(any()).thenDoNothing()
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(GuestSession.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }
        
        /*WHEN*/
        
        repository.getGuestSession()
        
        /*THEN*/
        verify(requestBuilder).getGuestSessionURLRequest()
        verify(session).send(request: requestMatcher, responseType: any(GuestSession.Type.self), completion: anyClosure())
        verify(userSetting).guestSession.get()
    }
    
    // MARK: - rating
    func testPostMovieRatingSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPostMovieRatingURLRequest(movieId: 1, rate: 2)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(requestBuilder) { stub in
            when(stub).getPostMovieRatingURLRequest(movieId: 1, rate: 2).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(RatingResponse.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(RatingResponse(status: 200, message: "")))
            }
        }
        
        /*WHEN*/
        repository.postMovieRating(movieId: 1, rate: 2) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getPostMovieRatingURLRequest(movieId: 1, rate: 2)
        verify(session).send(request: requestMatcher, responseType: any(RatingResponse.Type.self), completion: anyClosure())
    }
    
    func testPostMovieRatingFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPostMovieRatingURLRequest(movieId: 1, rate: 2)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(requestBuilder) { stub in
            when(stub).getPostMovieRatingURLRequest(movieId: 1, rate: 2).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(RatingResponse.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 500, userInfo: nil)))
            }
        }
        
        /*WHEN*/
        repository.postMovieRating(movieId: 1, rate: 2) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getPostMovieRatingURLRequest(movieId: 1, rate: 2)
        verify(session).send(request: requestMatcher, responseType: any(RatingResponse.Type.self), completion: anyClosure())
    }
    
    func testPostTVShowRatingSuccess() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPostTVShowRatingURLRequest(tvId: 1, rate: 2)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(requestBuilder) { stub in
            when(stub).getPostTVShowRatingURLRequest(tvId: 1, rate: 2).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(RatingResponse.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(RatingResponse(status: 200, message: "")))
            }
        }
        
        /*WHEN*/
        repository.postTVShowRating(tvId: 1, rate: 2) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getPostTVShowRatingURLRequest(tvId: 1, rate: 2)
        verify(session).send(request: requestMatcher, responseType: any(RatingResponse.Type.self), completion: anyClosure())
    }
    
    func testPostTVShowRatingFail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPostTVShowRatingURLRequest(tvId: 1, rate: 2)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(requestBuilder) { stub in
            when(stub).getPostTVShowRatingURLRequest(tvId: 1, rate: 2).thenReturn(request)
        }
        
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(RatingResponse.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.failure(NSError(domain: "", code: 200, userInfo: nil)))
            }
        }
        
        /*WHEN*/
        repository.postTVShowRating(tvId: 1, rate: 2) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(requestBuilder).getPostTVShowRatingURLRequest(tvId: 1, rate: 2)
        verify(session).send(request: requestMatcher, responseType: any(RatingResponse.Type.self), completion: anyClosure())
    }
}
