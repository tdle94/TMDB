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
    
    let repository: TMDBRepositoryProtocol = TMDBRepository()
    let session: MockTMDBSessionProtocol = MockTMDBSessionProtocol()
    let requestBuilder: MockTMDBURLRequestBuilderProtocol = MockTMDBURLRequestBuilderProtocol()
    let localDataSource: MockTMDBLocalDataSourceProtocol = MockTMDBLocalDataSourceProtocol()
    
    // MARK: - movie detail test

    private func setUpMovieDetailTest() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getMovieDetailURLRequest(id: 3)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub.send(request: requestMatcher, responseType: any(MovieDetail.Type.self), completion: anyClosure())).thenDoNothing()
        }

        stub(requestBuilder) { stub in
            when(stub.getMovieDetailURLRequest(id: 3, language: "en-US")).thenReturn(request)
        }

        /*WHEN*/
        repository.getMovieDetail(id: 3) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        session.send(request: request, responseType: MovieDetail.self) { result in
            expectation.fulfill()
        }

        let _ = localDataSource.getMovieDetail(id: 3)

        let _ = requestBuilder.getMovieDetailURLRequest(id: 3)

        /*THEN*/
        waitForExpectations(timeout: 5, handler: nil)
        verify(localDataSource).getMovieDetail(id: 3)
        verify(session).send(request: requestMatcher, responseType: any(MovieDetail.Type.self), completion: anyClosure())
        verify(requestBuilder).getMovieDetailURLRequest(id: 3, language: "en-US")
    }

    // no movie detail in realm, get from calling service
    func testGetMovieDetailCase1() {
        stub(localDataSource) { stub in
            when(stub.getMovieDetail(id: 3)).thenReturn(nil)
        }

        self.setUpMovieDetailTest()
    }

    // get movie detail in realm
    func testGetMovieDetailCase2() {
        stub(localDataSource) { stub in
            when(stub.getMovieDetail(id: 3)).thenReturn(MovieDetail())
        }

        self.setUpMovieDetailTest()
    }

    // MARK: - popular movie
    func testPopularMovie() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularMovieResult.Type.self), completion: anyClosure()).thenDoNothing()
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularMovieURLRequest(page: 1, language: "en-US", region: "US").thenReturn(request)
        }

        /*WHEN*/
        repository.getPopularMovie(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        session.send(request: request, responseType: PopularMovieResult.self) { result in
            expectation.fulfill()
        }

        let _ = requestBuilder.getPopularMovieURLRequest(page: 1, language: "en-US", region: "US")

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularMovieResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularMovieURLRequest(page: 1, language: "en-US", region: "US")
    }

    // MARK: - popular TV Shows
    func testPopularTVShows() {
        let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularTVURLRequest(page: 1)
        let requestMatcher = ParameterMatcher<URLRequest>(matchesFunction: { $0 == request })

        /*GIVEN*/
        stub(session) { stub in
            when(stub).send(request: requestMatcher, responseType: any(PopularOnTVResult.Type.self), completion: anyClosure()).thenDoNothing()
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularTVURLRequest(page: 1, language: "en-US").thenReturn(request)
        }

        /*WHEN*/
        repository.getPopularOnTV(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        session.send(request: request, responseType: PopularOnTVResult.self) { result in
            expectation.fulfill()
        }

        let _ = requestBuilder.getPopularTVURLRequest(page: 1, language: "en-US")

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
            when(stub).send(request: requestMatcher, responseType: any(PopularPeopleResult.Type.self), completion: anyClosure()).thenDoNothing()
        }

        stub(requestBuilder) { stub in
            when(stub).getPopularPeopleURLRequest(page: 1, language: "en-US").thenReturn(request)
        }
        
        /*WHEN*/
        repository.getPopularPeople(page: 1) { result in
            XCTAssertNoThrow(try! result.get())
            expectation.fulfill()
        }

        session.send(request: request, responseType: PopularPeopleResult.self) { result in
            expectation.fulfill()
        }

        let _ = requestBuilder.getPopularPeopleURLRequest(page: 1)

        /*THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).send(request: requestMatcher, responseType: any(PopularPeopleResult.Type.self), completion: anyClosure())
        verify(requestBuilder).getPopularPeopleURLRequest(page: 1, language: "en-US")
    }
}
