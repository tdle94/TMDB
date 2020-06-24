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
    let userSetting = MockTMDBUserSettingProtocol()
    let userDefault: UserDefaults = UserDefaults(suiteName: #file)!
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
        services = TMDBServices(session: session, urlRequestBuilder: urlRequestBuilder, userSetting: userSetting)
        stub(userSetting) { stub in
            when(stub).userDefault.get.thenReturn(userDefault)
        }
    }

    override func tearDown() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
    }

    // MARK: - popular

    func testGetPopularMovie() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1)

        /*GIVEN*/
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: "en-US", region: "US").thenReturn(matchRequest)
        }

        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PopularMovie.Type.self), completion: anyClosure()).then { implementation in
                let popularMovieResult = PopularMovie()
                implementation.2(.success(popularMovieResult))
            }
        }

        /*WHEN*/
        services.getPopularMovie(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getPopularMovieURLRequest(page: 1, language: "en-US", region: "US")
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(PopularMovie.Type.self), completion: anyClosure())
    }
    
    func testGetPopularPeople() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getPopularPeopleURLRequest(page: 1)
        /*GIVEN*/
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: "en-US").thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PopularPeopleResult.Type.self), completion: anyClosure()).then { implementation in
                let popularPeopleResult = PopularPeopleResult()
                implementation.2(.success(popularPeopleResult))
            }
        }

        /*WHEN*/
        services.getPopularPeople(page: 1) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getPopularPeopleURLRequest(page: 1, language: "en-US")
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(PopularPeopleResult.Type.self), completion: anyClosure())
    }
    
    func testGetPopularOnTV() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1)
        
        /*GIVEN*/
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: "en-US").thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PopularOnTVResult.Type.self), completion: anyClosure()).then { implementation in
                let popularPeopleResult = PopularOnTVResult()
                implementation.2(.success(popularPeopleResult))
            }
        }
        
        /*WHEN*/
        services.getPopularOnTV(page: 1) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
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
            when(stub).send(request: any(), responseType: any(Movie.Type.self), completion: anyClosure()).then { implementation in
                let movieDetail = Movie()
                implementation.2(.success(movieDetail))
            }
        }
        
        services.getMovieDetail(id: 3) { result in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getMovieDetailURLRequest(id: 3, language: "en-US")
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(Movie.Type.self), completion: anyClosure())
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

    // MARK: - update image config
    func testUpdateImageConfig() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getImageConfigURLRequest()
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /**GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageConfigResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(ImageConfigResult()))
            }
        }

        stub(urlRequestBuilder) { stub in
            when(stub).getImageConfigURLRequest().thenReturn(request)
        }

        /**WHEN*/
        services.updateImageConfig { _ in
            expectation.fulfill()
        }

        /**THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getImageConfigURLRequest()
        verify(session).send(request: requestMatcher, responseType: any(ImageConfigResult.Type.self), completion: anyClosure())
    }
}
