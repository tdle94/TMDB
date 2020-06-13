// MARK: - Mocks generated from file: TMDB/TMDBLocalDataSource/TMDBLocalDataSource.swift at 2020-06-13 18:13:21 +0000

//
//  TMDBLocalDataSource+TMDBLocalDataSourceProtocol.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Cuckoo
@testable import TMDB

import Foundation
import RealmSwift


 class MockTMDBLocalDataSourceProtocol: TMDBLocalDataSourceProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TMDBLocalDataSourceProtocol
    
     typealias Stubbing = __StubbingProxy_TMDBLocalDataSourceProtocol
     typealias Verification = __VerificationProxy_TMDBLocalDataSourceProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TMDBLocalDataSourceProtocol?

     func enableDefaultImplementation(_ stub: TMDBLocalDataSourceProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getMovieDetail(id: Int) -> MovieDetail? {
        
    return cuckoo_manager.call("getMovieDetail(id: Int) -> MovieDetail?",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieDetail(id: id))
        
    }
    
    
    
     func save(movie: MovieDetail) -> Error? {
        
    return cuckoo_manager.call("save(movie: MovieDetail) -> Error?",
            parameters: (movie),
            escapingParameters: (movie),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.save(movie: movie))
        
    }
    

	 struct __StubbingProxy_TMDBLocalDataSourceProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMovieDetail<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Int), MovieDetail?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getMovieDetail(id: Int) -> MovieDetail?", parameterMatchers: matchers))
	    }
	    
	    func save<M1: Cuckoo.Matchable>(movie: M1) -> Cuckoo.ProtocolStubFunction<(MovieDetail), Error?> where M1.MatchedType == MovieDetail {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetail)>] = [wrap(matchable: movie) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "save(movie: MovieDetail) -> Error?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TMDBLocalDataSourceProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getMovieDetail<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), MovieDetail?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getMovieDetail(id: Int) -> MovieDetail?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func save<M1: Cuckoo.Matchable>(movie: M1) -> Cuckoo.__DoNotUse<(MovieDetail), Error?> where M1.MatchedType == MovieDetail {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieDetail)>] = [wrap(matchable: movie) { $0 }]
	        return cuckoo_manager.verify("save(movie: MovieDetail) -> Error?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBLocalDataSourceProtocolStub: TMDBLocalDataSourceProtocol {
    

    

    
     func getMovieDetail(id: Int) -> MovieDetail?  {
        return DefaultValueRegistry.defaultValue(for: (MovieDetail?).self)
    }
    
     func save(movie: MovieDetail) -> Error?  {
        return DefaultValueRegistry.defaultValue(for: (Error?).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBLocationManager/TMDBLocationService.swift at 2020-06-13 18:13:21 +0000

//
//  LocationService.swift
//  TMDB
//
//  Created by Tuyen Le on 13.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Cuckoo
@testable import TMDB

import CoreLocation
import Foundation


 class MockTMDBLocationService: TMDBLocationService, Cuckoo.ProtocolMock {
    
     typealias MocksType = TMDBLocationService
    
     typealias Stubbing = __StubbingProxy_TMDBLocationService
     typealias Verification = __VerificationProxy_TMDBLocationService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TMDBLocationService?

     func enableDefaultImplementation(_ stub: TMDBLocationService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func geocode(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void)  {
        
    return cuckoo_manager.call("geocode(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void)",
            parameters: (location, completion),
            escapingParameters: (location, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.geocode(location: location, completion: completion))
        
    }
    

	 struct __StubbingProxy_TMDBLocationService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func geocode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(location: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(CLLocation, ([CLPlacemark]?, Error?) -> Void)> where M1.MatchedType == CLLocation, M2.MatchedType == ([CLPlacemark]?, Error?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(CLLocation, ([CLPlacemark]?, Error?) -> Void)>] = [wrap(matchable: location) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocationService.self, method: "geocode(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TMDBLocationService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func geocode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(location: M1, completion: M2) -> Cuckoo.__DoNotUse<(CLLocation, ([CLPlacemark]?, Error?) -> Void), Void> where M1.MatchedType == CLLocation, M2.MatchedType == ([CLPlacemark]?, Error?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(CLLocation, ([CLPlacemark]?, Error?) -> Void)>] = [wrap(matchable: location) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("geocode(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBLocationServiceStub: TMDBLocationService {
    

    

    
     func geocode(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBSession.swift at 2020-06-13 18:13:21 +0000

//
//  Session.swift
//  TMDB
//
//  Created by Tuyen Le on 06.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Cuckoo
@testable import TMDB

import Foundation


 class MockTMDBSessionProtocol: TMDBSessionProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TMDBSessionProtocol
    
     typealias Stubbing = __StubbingProxy_TMDBSessionProtocol
     typealias Verification = __VerificationProxy_TMDBSessionProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TMDBSessionProtocol?

     func enableDefaultImplementation(_ stub: TMDBSessionProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func send<T: Decodable>(request: URLRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)  {
        
    return cuckoo_manager.call("send(request: URLRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)",
            parameters: (request, responseType, completion),
            escapingParameters: (request, responseType, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.send(request: request, responseType: responseType, completion: completion))
        
    }
    

	 struct __StubbingProxy_TMDBSessionProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func send<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, T: Decodable>(request: M1, responseType: M2, completion: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(URLRequest, T.Type, (Result<T, Error>) -> Void)> where M1.MatchedType == URLRequest, M2.MatchedType == T.Type, M3.MatchedType == (Result<T, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest, T.Type, (Result<T, Error>) -> Void)>] = [wrap(matchable: request) { $0.0 }, wrap(matchable: responseType) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBSessionProtocol.self, method: "send(request: URLRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TMDBSessionProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func send<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, T: Decodable>(request: M1, responseType: M2, completion: M3) -> Cuckoo.__DoNotUse<(URLRequest, T.Type, (Result<T, Error>) -> Void), Void> where M1.MatchedType == URLRequest, M2.MatchedType == T.Type, M3.MatchedType == (Result<T, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest, T.Type, (Result<T, Error>) -> Void)>] = [wrap(matchable: request) { $0.0 }, wrap(matchable: responseType) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("send(request: URLRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBSessionProtocolStub: TMDBSessionProtocol {
    

    

    
     func send<T: Decodable>(request: URLRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLRequestBuilder.swift at 2020-06-13 18:13:21 +0000

//
//  URLRequestBuilder.swift
//  TMDB
//
//  Created by Tuyen Le on 06.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Cuckoo
@testable import TMDB

import Foundation


 class MockTMDBURLRequestBuilderProtocol: TMDBURLRequestBuilderProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TMDBURLRequestBuilderProtocol
    
     typealias Stubbing = __StubbingProxy_TMDBURLRequestBuilderProtocol
     typealias Verification = __VerificationProxy_TMDBURLRequestBuilderProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TMDBURLRequestBuilderProtocol?

     func enableDefaultImplementation(_ stub: TMDBURLRequestBuilderProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        
    return cuckoo_manager.call("getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest",
            parameters: (page, language, region),
            escapingParameters: (page, language, region),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularMovieURLRequest(page: page, language: language, region: region))
        
    }
    
    
    
     func getPopularTVURLRequest(page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getPopularTVURLRequest(page: Int, language: String?) -> URLRequest",
            parameters: (page, language),
            escapingParameters: (page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularTVURLRequest(page: page, language: language))
        
    }
    
    
    
     func getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest",
            parameters: (page, language),
            escapingParameters: (page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularPeopleURLRequest(page: page, language: language))
        
    }
    
    
    
     func getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest {
        
    return cuckoo_manager.call("getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest",
            parameters: (time, type),
            escapingParameters: (time, type),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTrendingURLRequest(time: time, type: type))
        
    }
    
    
    
     func getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest",
            parameters: (id, language),
            escapingParameters: (id, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieDetailURLRequest(id: id, language: language))
        
    }
    

	 struct __StubbingProxy_TMDBURLRequestBuilderProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getPopularMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.ProtocolStubFunction<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getPopularTVURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getPopularTVURLRequest(page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getPopularPeopleURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTrendingURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(time: M1, type: M2) -> Cuckoo.ProtocolStubFunction<(TrendingTime, TrendingMediaType), URLRequest> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getMovieDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(id: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TMDBURLRequestBuilderProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getPopularMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.__DoNotUse<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return cuckoo_manager.verify("getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularTVURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getPopularTVURLRequest(page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularPeopleURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTrendingURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(time: M1, type: M2) -> Cuckoo.__DoNotUse<(TrendingTime, TrendingMediaType), URLRequest> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }]
	        return cuckoo_manager.verify("getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(id: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBURLRequestBuilderProtocolStub: TMDBURLRequestBuilderProtocol {
    

    

    
     func getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getPopularTVURLRequest(page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBUserSetting/TMDBUserSetting.swift at 2020-06-13 18:13:21 +0000

//
//  UserDefault.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Cuckoo
@testable import TMDB

import Foundation


 class MockTMDBUserSettingProtocol: TMDBUserSettingProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TMDBUserSettingProtocol
    
     typealias Stubbing = __StubbingProxy_TMDBUserSettingProtocol
     typealias Verification = __VerificationProxy_TMDBUserSettingProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TMDBUserSettingProtocol?

     func enableDefaultImplementation(_ stub: TMDBUserSettingProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var language: String? {
        get {
            return cuckoo_manager.getter("language",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.language)
        }
        
        set {
            cuckoo_manager.setter("language",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.language = newValue)
        }
        
    }
    
    
    
     var country: String? {
        get {
            return cuckoo_manager.getter("country",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.country)
        }
        
        set {
            cuckoo_manager.setter("country",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.country = newValue)
        }
        
    }
    
    
    
     var region: String? {
        get {
            return cuckoo_manager.getter("region",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.region)
        }
        
        set {
            cuckoo_manager.setter("region",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.region = newValue)
        }
        
    }
    

    

    

	 struct __StubbingProxy_TMDBUserSettingProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var language: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockTMDBUserSettingProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "language")
	    }
	    
	    
	    var country: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockTMDBUserSettingProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "country")
	    }
	    
	    
	    var region: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockTMDBUserSettingProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "region")
	    }
	    
	    
	}

	 struct __VerificationProxy_TMDBUserSettingProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var language: Cuckoo.VerifyOptionalProperty<String> {
	        return .init(manager: cuckoo_manager, name: "language", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var country: Cuckoo.VerifyOptionalProperty<String> {
	        return .init(manager: cuckoo_manager, name: "country", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var region: Cuckoo.VerifyOptionalProperty<String> {
	        return .init(manager: cuckoo_manager, name: "region", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class TMDBUserSettingProtocolStub: TMDBUserSettingProtocol {
    
    
     var language: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    
     var country: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    
     var region: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    

    

    
}

