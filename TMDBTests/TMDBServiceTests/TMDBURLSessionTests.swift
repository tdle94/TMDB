//
//  TMDBURLSessionTests.swift
//  TMDBTests
//
//  Created by Tuyen Le on 14.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

@testable import TMDB
import Quick
import Nimble
import Cuckoo

class TMDBURLSessionTests: XCTestCase {
    let session: MockTMDBURLSessionProtocol = MockTMDBURLSessionProtocol()
    let dataTask: MockTMDBURLSessionDataTaskProtocol = MockTMDBURLSessionDataTaskProtocol()
    let requestMatcher: ParameterMatcher<URLRequest> = ParameterMatcher()
    let urlMatcher: ParameterMatcher<URL> = ParameterMatcher()
    var tmdbSession: TMDBSession!

    override class func setUp() {
        // this is only for increasing test coverage for the sake of testing. It's unused
        let urlSessionDataTaskWithCustomTypeReturn = URLSession.shared.tmdbDataTask(with: URLRequest(url: URL(string: "test.com")!)) { _,_,_  in }
        let urlSessionDataTaskWithURL = URLSession.shared.tmdbDataTask(with: URL(string: "test.com")!) {_, _, _ in
        }

        urlSessionDataTaskWithURL.tmdbResume()
        urlSessionDataTaskWithCustomTypeReturn.tmdbResume()
    }
    
    override func setUp() {
        // create tmdb session
        tmdbSession = TMDBSession(session: session)
    }
    
    // MARK: - test URLRequest with custom return type

    func common(request: URLRequest) {
        let expectation = self.expectation(description: "")
        stub(dataTask) { stub in
            when(stub).tmdbResume().thenDoNothing()
        }

        /*WHEN*/
        tmdbSession.send(request: request, responseType: PopularMovie.self) { _ in
            expectation.fulfill()
        }
        
        /**THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).tmdbDataTask(with: requestMatcher, completionHandler: anyClosure())
        verify(dataTask).tmdbResume()
    }

    func testSuccessCall() {
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1)

        /*GIVEN*/
        stub(session) { stub in
            when(stub).tmdbDataTask(with: requestMatcher, completionHandler: anyClosure()).then { implementation in
                let urlResponse = HTTPURLResponse(url: URL(string: "test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
                implementation.1(Data(), urlResponse, nil)
                return self.dataTask
            }
        }
        
        common(request: request)
    }
    
    func testErrorCall() {
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1)

        /*GIVEN*/
        stub(session) { stub in
            when(stub).tmdbDataTask(with: requestMatcher, completionHandler: anyClosure()).then { implementation in
                implementation.1(nil, nil, NSError())
                return self.dataTask
            }
        }
        
        common(request: request)
    }
    
    func test500HTTPStatus() {
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1)

        /*GIVEN*/
        stub(session) { stub in
            when(stub).tmdbDataTask(with: requestMatcher, completionHandler: anyClosure()).then { implementation in
                let urlResponse = HTTPURLResponse(url: URL(string: "test.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
                implementation.1(Data(), urlResponse, nil)
                return self.dataTask
            }
        }
        
        common(request: request)
    }
    
    func testNoDataReturn() {
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1)

        /*GIVEN*/
        stub(session) { stub in
            when(stub).tmdbDataTask(with: requestMatcher, completionHandler: anyClosure()).then { implementation in
                let urlResponse = HTTPURLResponse(url: URL(string: "test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
                implementation.1(nil, urlResponse, nil)
                return self.dataTask
            }
        }
        
        common(request: request)
    }
}
