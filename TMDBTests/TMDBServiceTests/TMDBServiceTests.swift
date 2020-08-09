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
        services = TMDBServices(session: session, urlRequestBuilder: urlRequestBuilder)
        stub(userSetting) { stub in
            when(stub).userDefault.get.thenReturn(userDefault)
        }
    }

    override func tearDown() {
        userDefault.dictionaryRepresentation().keys.forEach { key in
            userDefault.removeObject(forKey: key)
        }
    }

    // MARK: - people
    
    func testGetPopularPeople() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getPopularPeopleURLRequest(page: 1, language: NSLocale.current.languageCode)
        /*GIVEN*/
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: NSLocale.current.languageCode).thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(PeopleResult.Type.self), completion: anyClosure()).then { implementation in
                let popularPeopleResult = PeopleResult()
                implementation.2(.success(popularPeopleResult))
            }
        }

        /*WHEN*/
        services.getPopularPeople(page: 1) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getPopularPeopleURLRequest(page: 1, language: NSLocale.current.languageCode)
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(PeopleResult.Type.self), completion: anyClosure())
    }

    // MARK: - tv shows
    func testGetPopularOnTV() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1, language: NSLocale.current.languageCode)
        
        /*GIVEN*/
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: NSLocale.current.languageCode).thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                let popularPeopleResult = TVShowResult()
                implementation.2(.success(popularPeopleResult))
            }
        }
        
        /*WHEN*/
        services.getPopularOnTV(page: 1) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getPopularTVURLRequest(page: 1, language: NSLocale.current.languageCode)
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(TVShowResult.Type.self), completion: anyClosure())
    }
    
    // MARK: - movie
    
    func testGetSimilarMovies() {
        let expectation = self.expectation(description: "")
        let urlRequest = TMDBURLRequestBuilder().getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == urlRequest })

        /*GIVEN*/
        stub(urlRequestBuilder) { stub in
            when(stub).getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode).thenReturn(urlRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                let movieResult = MovieResult()
                implementation.2(.success(movieResult))
            }
        }
        
        /*WHEN*/
        services.getSimilarMovies(from: 3, page: 1) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getSimilarMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }
    
    func testGetRecommendMovies() {
        let expectation = self.expectation(description: "")
        let urlRequest = TMDBURLRequestBuilder().getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == urlRequest })

        /*GIVEN*/
        stub(urlRequestBuilder) { stub in
            when(stub).getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode).thenReturn(urlRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                let movieResult = MovieResult()
                implementation.2(.success(movieResult))
            }
        }
        
        /*WHEN*/
        services.getRecommendMovies(from: 3, page: 1) { result in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getRecommendMoviesURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
        verify(session).send(request: requestMatcher, responseType: any(MovieResult.Type.self), completion: anyClosure())
    }
    
    func testGetPopularMovie() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)

        /*GIVEN*/
        stub(urlRequestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode).thenReturn(matchRequest)
        }

        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(MovieResult.Type.self), completion: anyClosure()).then { implementation in
                let popularMovieResult = MovieResult()
                implementation.2(.success(popularMovieResult))
            }
        }

        /*WHEN*/
        services.getPopularMovie(page: 1) { result in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getPopularMovieURLRequest(page: 1, language: NSLocale.current.languageCode, region: NSLocale.current.regionCode)
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(MovieResult.Type.self), completion: anyClosure())
    }

    func testGetMovieDetail() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        
        stub(urlRequestBuilder) { stub in
            when(stub).getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode).thenReturn(matchRequest)
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
        verify(urlRequestBuilder).getMovieDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        verify(session, times(1)).send(request: ArgumentCaptor<URLRequest>().capture(), responseType: any(Movie.Type.self), completion: anyClosure())
    }
    
    func testGetMovieCredit() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getMovieCreditURLRequest(from: 3)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == matchRequest })
        
        stub(urlRequestBuilder) { stub in
            when(stub).getMovieCreditURLRequest(from: 3).thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(CreditResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(CreditResult()))
            }
        }
        
        services.getMovieCredit(from: 3) { result in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getMovieCreditURLRequest(from: 3)
        verify(session).send(request: requestMatcher, responseType: any(CreditResult.Type.self), completion: anyClosure())
    }
    
    func testGetMovieReview() {
        let expectation = self.expectation(description: "")
        let matchRequest = TMDBURLRequestBuilder().getMovieReviewURLRequest(from: 3, page: 1)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == matchRequest })
        
        stub(urlRequestBuilder) { stub in
            when(stub).getMovieReviewURLRequest(from: 3, page: 1).thenReturn(matchRequest)
        }
        
        stub(session) { stub in
            when(stub).send(request: any(), responseType: any(ReviewResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(ReviewResult()))
            }
        }
        
        services.getMovieReview(page: 1, from: 3) { result in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        verify(urlRequestBuilder).getMovieReviewURLRequest(from: 3, page: 1)
        verify(session).send(request: requestMatcher, responseType: any(ReviewResult.Type.self), completion: anyClosure())
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
    
    // MARK: - tv show detail
    func testGetTVShowDetail() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShow.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShow()))
            }
        }

        stub(urlRequestBuilder) { stub in
            when(stub).getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode).thenReturn(request)
        }

        /*WHEN*/
        services.getTVShowDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TVShow.Type.self), completion: anyClosure())
        verify(urlRequestBuilder).getTVShowDetailURLRequest(id: 3, language: NSLocale.current.languageCode)
    }

    // MARK: - similar tv show
    func testGetSimilarTVShow() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getSimilarTVShowsURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(TVShowResult()))
            }
        }
        
        stub(urlRequestBuilder) { stub in
            when(stub).getSimilarTVShowsURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }
        
        /*WHEN*/
        services.getSimilarTVShows(from: 3, page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(TVShowResult.Type.self), completion: anyClosure())
        verify(urlRequestBuilder).getSimilarTVShowsURLRequest(from: 3, page: 1, language: NSLocale.current.languageCode)
    }
    
    // MARK: - tv show season
    func testGetTVShowSeason() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowSeasonDetailURLRequest(tvShowId: 3, seasonNumber: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(Season.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(Season()))
            }
        }
        
        stub(urlRequestBuilder) { stub in
            when(stub).getTVShowSeasonDetailURLRequest(tvShowId: 3, seasonNumber: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }
        /*WHEN*/
        
        services.getTVShowSeasonDetail(from: 3, seasonNumber: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(Season.Type.self), completion: anyClosure())
        verify(urlRequestBuilder).getTVShowSeasonDetailURLRequest(tvShowId: 3, seasonNumber: 1, language: NSLocale.current.languageCode)
    }
    
    // MARK: - tv show image
    func testGetTVShowImage() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowImagesURLRequest(from: 3)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(ImageResult()))
            }
        }
        
        stub(urlRequestBuilder) { stub in
            when(stub).getTVShowImagesURLRequest(from: 3).thenReturn(request)
        }
        /*WHEN*/
        services.getTVShowImages(from: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure())
        verify(urlRequestBuilder).getTVShowImagesURLRequest(from: 3)
    }
    
    // MARK: - movie image
    func testGetMovieImage() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieImagesURLRequest(from: 3)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(ImageResult()))
            }
        }

        stub(urlRequestBuilder) { stub in
            when(stub).getMovieImagesURLRequest(from: 3).thenReturn(request)
        }
        /*WHEN*/
        services.getMovieImages(from: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure())
        verify(urlRequestBuilder).getMovieImagesURLRequest(from: 3)
    }
    
    // MARK: - tv show episode
    func testGetTVShowEpisode() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowEpisodeURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1, language: NSLocale.current.languageCode)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(Episode.Type.self), completion: anyClosure()).then { implementation in
                implementation.2(.success(Episode()))
            }
        }

        stub(urlRequestBuilder) { stub in
            when(stub).getTVShowEpisodeURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1, language: NSLocale.current.languageCode).thenReturn(request)
        }

        /*WHEN*/
        services.getTVShowEpisode(from: 3, seasonNumber: 1, episodeNumber: 1) { _ in
            expectation.fulfill()
        }

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(Episode.Type.self), completion: anyClosure())
        verify(urlRequestBuilder).getTVShowEpisodeURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1, language: NSLocale.current.languageCode)
    }
    
    // MARK: - tv show season image
    func testGetTVShowSeasonImage() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowSeasonImageURLRequest(from: 3, seasonNumber: 1)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).thenDoNothing()
        }

        stub(urlRequestBuilder) { stub in
            when(stub).getTVShowSeasonImageURLRequest(from: 3, seasonNumber: 1).thenReturn(request)
        }
        /*WHEN*/
        services.getTVShowSeasonImage(from: 3, seasonNumber: 1) { _ in
            expectation.fulfill()
        }
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure())
        verify(urlRequestBuilder).getTVShowSeasonImageURLRequest(from: 3, seasonNumber: 1)
    }
    
    // MARK: - tv show episode image
    func testGetTVShowEpisodeImage() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getTVShowEpisodeImageURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1)
        let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher(matchesFunction: { $0 == request })
        
        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure()).thenDoNothing()
        }
        
        stub(urlRequestBuilder) { stub in
            when(stub).getTVShowEpisodeImageURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1).thenReturn(request)
        }
        /*WHEN*/
        services.getTVShowEpisodeImage(from: 3, seasonNumber: 1, episodeNumber: 1) { _ in
            expectation.fulfill()
        }
        
        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(ImageResult.Type.self), completion: anyClosure())
        verify(urlRequestBuilder).getTVShowEpisodeImageURLRequest(from: 3, seasonNumber: 1, episodeNumber: 1)
    }
}
