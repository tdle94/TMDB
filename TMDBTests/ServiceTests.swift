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

class ServiceTests: XCTestCase {

    let session = MockSessionProtocol()
    let urlRequestBuilder = MockURLRequestBuilderProtocol()
    var services: Services!
    
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
        services = Services(session: session, urlRequestBuilder: urlRequestBuilder)
    }

    // MARK: - popular

    func testGetPopularMovie() {
        let expectation = self.expectation(description: "")
        let matchRequest = URLRequestBuilder().getPopularMovieURLRequest(page: 1)
        
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: "en-US", region: isNil()).thenReturn(matchRequest)
        }

        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PopularMovieResult.Type.self), completion: anyClosure()).then { implementation in
                let popularMovieResult = PopularMovieResult(page: 1, totalPages: 100, totalResults: 1000, movies: [])
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
        let matchRequest = URLRequestBuilder().getPopularPeopleURLRequest(page: 1)
        
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: "en-US").thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PopularPeopleResult.Type.self), completion: anyClosure()).then { implementation in
                let popularPeopleResult = PopularPeopleResult(page: 1, totalPages: 100, totalResults: 1000, peoples: [])
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
        let matchRequest = URLRequestBuilder().getPopularTVURLRequest(page: 1)
        
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: "en-US").thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PopularOnTVResult.Type.self), completion: anyClosure()).then { implementation in
                let popularPeopleResult = PopularOnTVResult(page: 1, totalPages: 100, totalResults: 1000, onTV: [])
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
        let matchRequest = URLRequestBuilder().getMovieDetailURLRequest(id: 3)
        
        stub(urlRequestBuilder) { stub in
            when(stub).getMovieDetailURLRequest(id: 3, language: "en-US").thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(MovieDetail.Type.self), completion: anyClosure()).then { implementation in
                let movieDetail = MovieDetail(id: 1, adult: true, backdropPath: "", budget: 0,
                                              genres: [], homepage: "", imdbId: "", originalLanguage: "",
                                              originalTitle: "", overview: "", popularity: 0, posterPath: "",
                                              productionCompanies: [], productionCountries: [], releaseDate: "",
                                              revenue: 0, runtime: 0, spokenLanguage: [], status: "", tagline: "",
                                              title: "", video: false, voteAverage: 0, voteCount: 0)
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
            matchRequest = URLRequestBuilder().getTrendingURLRequest(time: time, type: .all)
            trendingType =  TrendingMediaMatchable(matcher: self.allTrending)
        case .movie:
            matchRequest = URLRequestBuilder().getTrendingURLRequest(time: time, type: .movie)
            trendingType = TrendingMediaMatchable(matcher: self.movieTrending)
        case .person:
            matchRequest = URLRequestBuilder().getTrendingURLRequest(time: time, type: .person)
            trendingType = TrendingMediaMatchable(matcher: self.personTrending)
        case .tv:
            matchRequest = URLRequestBuilder().getTrendingURLRequest(time: time, type: .tv)
            trendingType = TrendingMediaMatchable(matcher: self.tvTrending)
        }

        stub(urlRequestBuilder) { stub in
            when(stub).getTrendingURLRequest(time: trendingTime, type: trendingType).thenReturn(matchRequest)
        }

        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(TrendingResult.Type.self), completion: anyClosure()).then { implementation in
                let trending = TrendingResult(page: 1, totalPages: 10, totalResult: 50, trending: [])
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
}
