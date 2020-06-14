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
    var tmdbSession: TMDBSession!
    
    override class func setUp() {
        // this is only for increasing test coverage for the sake of testing. It's unused
        let urlSessionDataTask = URLSession.shared.tmdbDataTask(with: URLRequest(url: URL(string: "test.com")!)) { _,_,_  in }
        urlSessionDataTask.tmdbResume()
    }
    
    override func setUp() {
        // create tmdb session
        tmdbSession = TMDBSession(session: session)
    }
    
    func common(request: URLRequest) {
        let expectation = self.expectation(description: "")
        stub(dataTask) { stub in
            when(stub).tmdbResume().thenDoNothing()
        }

        /*WHEN*/
        tmdbSession.send(request: request, responseType: PopularMovieResult.self) { _ in
            expectation.fulfill()
        }
        
        /**THEN*/
        waitForExpectations(timeout: 1, handler: nil)
        verify(session).tmdbDataTask(with: any(), completionHandler: anyClosure())
        verify(dataTask).tmdbResume()
    }
    
    func testSuccessCall() {
       // let expectation = self.expectation(description: "")
        let request = TMDBURLRequestBuilder().getPopularMovieURLRequest(page: 1)

        /*GIVEN*/
        stub(session) { stub in
            when(stub).tmdbDataTask(with: any(), completionHandler: anyClosure()).then { implementation in
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
            when(stub).tmdbDataTask(with: any(), completionHandler: anyClosure()).then { implementation in
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
            when(stub).tmdbDataTask(with: any(), completionHandler: anyClosure()).then { implementation in
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
            when(stub).tmdbDataTask(with: any(), completionHandler: anyClosure()).then { implementation in
                let urlResponse = HTTPURLResponse(url: URL(string: "test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
                implementation.1(nil, urlResponse, nil)
                return self.dataTask
            }
        }
        
        common(request: request)
    }
}
