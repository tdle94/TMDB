//
//  ServiceTests.swift
//  TMDBTests
//
//  Created by Tuyen Le on 07.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//


@testable import TMDB
import Quick
import Nimble
import Cuckoo

class TMDBServiceTests: XCTestCase {

    let session = MockTMDBSessionProtocol()
    let urlRequestBuilder = MockTMDBURLRequestBuilderProtocol()
    var services: TMDBServices!
    
    struct TrendingTimeMatchable: Matchable {
        var matcher: ParameterMatcher<TrendingTime>
        typealias MatchedType = TrendingTime
    }
    
    struct TrendingMediaMatchable: Matchable {
        var matcher: ParameterMatcher<TrendingMediaType>
        typealias MatchedType = TrendingMediaType
    }
    
    let todayTrending = ParameterMatcher<TrendingTime>(matchesFunction: { $0 == .today })
    let weekTrending = ParameterMatcher<TrendingTime>(matchesFunction: { $0 == .week })

    let allTrending = ParameterMatcher<TrendingMediaType>(matchesFunction: { $0 == .all })
    let movieTrending = ParameterMatcher<TrendingMediaType>(matchesFunction: { $0 == .movie })
    let tvTrending = ParameterMatcher<TrendingMediaType>(matchesFunction: { $0 == .tv })
    let personTrending = ParameterMatcher<TrendingMediaType>(matchesFunction: { $0 == .person })

    override func setUp() {
        services = TMDBServices(session: session, urlRequestBuilder: urlRequestBuilder)
    }

    // MARK: - popular

    func testGetPopularMovie() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1)
        
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: "en-US", region: isNil()).thenReturn(matchRequest)
        }

        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PopularMovieResult.Type.self), completion: anyClosure()).then { implementation in
                let popularMovieResult = PopularMovieResult()
                implementation.2(.success(popularMovieResult))
            }
        }

        services.getPopularMovie(page: 1) { result in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getPopularMovieURLRequest(page: 1, language: "en-US", region: isNil())
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(PopularMovieResult.Type.self), completion: anyClosure())
    }
    
    func testGetPopularPeople() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getPopularPeopleURLRequest(page: 1)
        
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: "en-US").thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PopularPeopleResult.Type.self), completion: anyClosure()).then { implementation in
                let popularPeopleResult = PopularPeopleResult()
                implementation.2(.success(popularPeopleResult))
            }
        }
        
        services.getPopularPeople(page: 1) { result in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getPopularPeopleURLRequest(page: 1, language: "en-US")
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(PopularPeopleResult.Type.self), completion: anyClosure())
    }
    
    func testGetPopularOnTV() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1)
        
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: "en-US").thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PopularOnTVResult.Type.self), completion: anyClosure()).then { implementation in
                let popularPeopleResult = PopularOnTVResult()
                implementation.2(.success(popularPeopleResult))
            }
        }
        
        services.getPopularOnTV(page: 1) { result in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getPopularTVURLRequest(page: 1, language: "en-US")
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(PopularOnTVResult.Type.self), completion: anyClosure())
    }
    
    // MARK: - detail
    func testGetMovieDetail() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3)
        
        stub(urlRequestBuilder) { stub in
            when(stub).getMovieDetailURLRequest(id: 3, language: "en-US").thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(MovieDetail.Type.self), completion: anyClosure()).then { implementation in
                let movieDetail = MovieDetail()
                implementation.2(.success(movieDetail))
            }
        }
        
        services.getMovieDetail(id: 3) { result in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getMovieDetailURLRequest(id: 3, language: "en-US")
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(MovieDetail.Type.self), completion: anyClosure())
    }
    
    // MARK: - trending
    
    func testAllTrendingToday() {
        self.trending(time: .today, type: .all)
    }
    
    func testMovieTrendingToday() {
        self.trending(time: .today, type: .movie)
    }
    
    func testTVTrendingToday() {
        self.trending(time: .today, type: .tv)
    }
    
    func testPersonTrendingToday() {
        self.trending(time: .today, type: .person)
    }
    
    func testAllTrendingThisWeek() {
        self.trending(time: .week, type: .all)
    }
    
    func testMovieTrendingThisWeek() {
        self.trending(time: .week, type: .movie)
    }
    
    func testTVTrendingThisWeek() {
        self.trending(time: .week, type: .tv)
    }
    
    func testPersonTrendingThisWeek() {
        self.trending(time: .week, type: .person)
    }
    
    private func trending(time: TrendingTime, type: TrendingMediaType) {
        let expectation = self.expectation(description: "")
        let trendingTime = TrendingTimeMatchable(matcher: time == .today ? self.todayTrending : self.weekTrending )
        let matchRequest: URLRequest
        let trendingType: TrendingMediaMatchable
        
        switch type {
        case .all:
            matchRequest = TMDBURLRequestBuilder().getTrendingURLRequest(time: time, type: .all)
            trendingType =  TrendingMediaMatchable(matcher: self.allTrending)
        case .movie:
            matchRequest = TMDBURLRequestBuilder().getTrendingURLRequest(time: time, type: .movie)
            trendingType = TrendingMediaMatchable(matcher: self.movieTrending)
        case .person:
            matchRequest = TMDBURLRequestBuilder().getTrendingURLRequest(time: time, type: .person)
            trendingType = TrendingMediaMatchable(matcher: self.personTrending)
        case .tv:
            matchRequest = TMDBURLRequestBuilder().getTrendingURLRequest(time: time, type: .tv)
            trendingType = TrendingMediaMatchable(matcher: self.tvTrending)
        }

        stub(urlRequestBuilder) { stub in
            when(stub).getTrendingURLRequest(time: trendingTime, type: trendingType).thenReturn(matchRequest)
        }

        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(TrendingResult.Type.self), completion: anyClosure()).then { implementation in
                let trending = TrendingResult()
                implementation.2(.success(trending))
            }
        }

        services.getTrending(time: time, type: type) { result in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getTrendingURLRequest(time: trendingTime, type: trendingType)
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(TrendingResult.Type.self), completion: anyClosure())
    }

    // MARK: - image

    func testFetchImageDataWithValidURL() {
        let expectation = self.expectation(description: "")
        let imageURL = "test.com"
        let urlMatcher = ParameterMatcher<URL>(matchesFunction: { $0.absoluteString == imageURL })

        stub(session) { stub in
            when(stub).send(url: urlMatcher, completion: anyClosure()).then { implementation in
                implementation.1(.success(Data()))
            }
        }

        services.getImageData(from: imageURL) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(url: urlMatcher, completion: anyClosure())
    }

    func testFetchImageDataWithInvalidURL() {
        let expectation = self.expectation(description: "")
        let imageURL = "why you valid"

        services.getImageData(from: imageURL) { result in
            do {
                let _ = try result.get()
            } catch let error {
                XCTAssertEqual(error.localizedDescription, TMDBSession.APIError.invalidURL.localizedDescription)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}
