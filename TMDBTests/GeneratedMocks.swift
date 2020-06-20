// MARK: - Mocks generated from file: TMDB/TMDBLocalDataSource/TMDBLocalDataSource.swift at 2020-06-20 14:41:43 +0000

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
    

    

    

    
    
    
     func getMovie(id: Int) -> Movie? {
        
    return cuckoo_manager.call("getMovie(id: Int) -> Movie?",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovie(id: id))
        
    }
    
    
    
     func saveMovie(_ movie: Movie)  {
        
    return cuckoo_manager.call("saveMovie(_: Movie)",
            parameters: (movie),
            escapingParameters: (movie),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveMovie(movie))
        
    }
    
    
    
     func saveMovies(_ movies: List<Movie>)  {
        
    return cuckoo_manager.call("saveMovies(_: List<Movie>)",
            parameters: (movies),
            escapingParameters: (movies),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveMovies(movies))
        
    }
    
    
    
     func getMoviePosterImgData(_ movie: Movie) -> Data? {
        
    return cuckoo_manager.call("getMoviePosterImgData(_: Movie) -> Data?",
            parameters: (movie),
            escapingParameters: (movie),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMoviePosterImgData(movie))
        
    }
    
    
    
     func saveMoviePosterImgData(_ movie: Movie, _ data: Data)  {
        
    return cuckoo_manager.call("saveMoviePosterImgData(_: Movie, _: Data)",
            parameters: (movie, data),
            escapingParameters: (movie, data),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveMoviePosterImgData(movie, data))
        
    }
    
    
    
     func getTVShow(id: Int) -> TVShow? {
        
    return cuckoo_manager.call("getTVShow(id: Int) -> TVShow?",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShow(id: id))
        
    }
    
    
    
     func saveTVShows(_ tvShows: List<TVShow>)  {
        
    return cuckoo_manager.call("saveTVShows(_: List<TVShow>)",
            parameters: (tvShows),
            escapingParameters: (tvShows),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveTVShows(tvShows))
        
    }
    
    
    
     func saveTVPosterImgData(_ tvShow: TVShow, _ data: Data)  {
        
    return cuckoo_manager.call("saveTVPosterImgData(_: TVShow, _: Data)",
            parameters: (tvShow, data),
            escapingParameters: (tvShow, data),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveTVPosterImgData(tvShow, data))
        
    }
    
    
    
     func getTVPosterImgData(_ tvShow: TVShow) -> Data? {
        
    return cuckoo_manager.call("getTVPosterImgData(_: TVShow) -> Data?",
            parameters: (tvShow),
            escapingParameters: (tvShow),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVPosterImgData(tvShow))
        
    }
    
    
    
     func getPerson(id: Int) -> People? {
        
    return cuckoo_manager.call("getPerson(id: Int) -> People?",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPerson(id: id))
        
    }
    
    
    
     func savePeople(_ people: List<People>)  {
        
    return cuckoo_manager.call("savePeople(_: List<People>)",
            parameters: (people),
            escapingParameters: (people),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.savePeople(people))
        
    }
    
    
    
     func savePersonProfileImgData(_ person: People, _ data: Data)  {
        
    return cuckoo_manager.call("savePersonProfileImgData(_: People, _: Data)",
            parameters: (person, data),
            escapingParameters: (person, data),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.savePersonProfileImgData(person, data))
        
    }
    
    
    
     func getPersonProfileImgData(_ person: People) -> Data? {
        
    return cuckoo_manager.call("getPersonProfileImgData(_: People) -> Data?",
            parameters: (person),
            escapingParameters: (person),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPersonProfileImgData(person))
        
    }
    

	 struct __StubbingProxy_TMDBLocalDataSourceProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Int), Movie?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getMovie(id: Int) -> Movie?", parameterMatchers: matchers))
	    }
	    
	    func saveMovie<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Movie)> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveMovie(_: Movie)", parameterMatchers: matchers))
	    }
	    
	    func saveMovies<M1: Cuckoo.Matchable>(_ movies: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(List<Movie>)> where M1.MatchedType == List<Movie> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>)>] = [wrap(matchable: movies) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveMovies(_: List<Movie>)", parameterMatchers: matchers))
	    }
	    
	    func getMoviePosterImgData<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.ProtocolStubFunction<(Movie), Data?> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getMoviePosterImgData(_: Movie) -> Data?", parameterMatchers: matchers))
	    }
	    
	    func saveMoviePosterImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movie: M1, _ data: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Movie, Data)> where M1.MatchedType == Movie, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie, Data)>] = [wrap(matchable: movie) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveMoviePosterImgData(_: Movie, _: Data)", parameterMatchers: matchers))
	    }
	    
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getTVShow(id: Int) -> TVShow?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShows<M1: Cuckoo.Matchable>(_ tvShows: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(List<TVShow>)> where M1.MatchedType == List<TVShow> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>)>] = [wrap(matchable: tvShows) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveTVShows(_: List<TVShow>)", parameterMatchers: matchers))
	    }
	    
	    func saveTVPosterImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tvShow: M1, _ data: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(TVShow, Data)> where M1.MatchedType == TVShow, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow, Data)>] = [wrap(matchable: tvShow) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveTVPosterImgData(_: TVShow, _: Data)", parameterMatchers: matchers))
	    }
	    
	    func getTVPosterImgData<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.ProtocolStubFunction<(TVShow), Data?> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getTVPosterImgData(_: TVShow) -> Data?", parameterMatchers: matchers))
	    }
	    
	    func getPerson<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Int), People?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getPerson(id: Int) -> People?", parameterMatchers: matchers))
	    }
	    
	    func savePeople<M1: Cuckoo.Matchable>(_ people: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(List<People>)> where M1.MatchedType == List<People> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<People>)>] = [wrap(matchable: people) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "savePeople(_: List<People>)", parameterMatchers: matchers))
	    }
	    
	    func savePersonProfileImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ person: M1, _ data: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(People, Data)> where M1.MatchedType == People, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(People, Data)>] = [wrap(matchable: person) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "savePersonProfileImgData(_: People, _: Data)", parameterMatchers: matchers))
	    }
	    
	    func getPersonProfileImgData<M1: Cuckoo.Matchable>(_ person: M1) -> Cuckoo.ProtocolStubFunction<(People), Data?> where M1.MatchedType == People {
	        let matchers: [Cuckoo.ParameterMatcher<(People)>] = [wrap(matchable: person) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getPersonProfileImgData(_: People) -> Data?", parameterMatchers: matchers))
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
	    func getMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), Movie?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getMovie(id: Int) -> Movie?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveMovie<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.__DoNotUse<(Movie), Void> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return cuckoo_manager.verify("saveMovie(_: Movie)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveMovies<M1: Cuckoo.Matchable>(_ movies: M1) -> Cuckoo.__DoNotUse<(List<Movie>), Void> where M1.MatchedType == List<Movie> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>)>] = [wrap(matchable: movies) { $0 }]
	        return cuckoo_manager.verify("saveMovies(_: List<Movie>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMoviePosterImgData<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.__DoNotUse<(Movie), Data?> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return cuckoo_manager.verify("getMoviePosterImgData(_: Movie) -> Data?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveMoviePosterImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movie: M1, _ data: M2) -> Cuckoo.__DoNotUse<(Movie, Data), Void> where M1.MatchedType == Movie, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie, Data)>] = [wrap(matchable: movie) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return cuckoo_manager.verify("saveMoviePosterImgData(_: Movie, _: Data)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getTVShow(id: Int) -> TVShow?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShows<M1: Cuckoo.Matchable>(_ tvShows: M1) -> Cuckoo.__DoNotUse<(List<TVShow>), Void> where M1.MatchedType == List<TVShow> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>)>] = [wrap(matchable: tvShows) { $0 }]
	        return cuckoo_manager.verify("saveTVShows(_: List<TVShow>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVPosterImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tvShow: M1, _ data: M2) -> Cuckoo.__DoNotUse<(TVShow, Data), Void> where M1.MatchedType == TVShow, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow, Data)>] = [wrap(matchable: tvShow) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return cuckoo_manager.verify("saveTVPosterImgData(_: TVShow, _: Data)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVPosterImgData<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.__DoNotUse<(TVShow), Data?> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return cuckoo_manager.verify("getTVPosterImgData(_: TVShow) -> Data?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPerson<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), People?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getPerson(id: Int) -> People?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func savePeople<M1: Cuckoo.Matchable>(_ people: M1) -> Cuckoo.__DoNotUse<(List<People>), Void> where M1.MatchedType == List<People> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<People>)>] = [wrap(matchable: people) { $0 }]
	        return cuckoo_manager.verify("savePeople(_: List<People>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func savePersonProfileImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ person: M1, _ data: M2) -> Cuckoo.__DoNotUse<(People, Data), Void> where M1.MatchedType == People, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(People, Data)>] = [wrap(matchable: person) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return cuckoo_manager.verify("savePersonProfileImgData(_: People, _: Data)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPersonProfileImgData<M1: Cuckoo.Matchable>(_ person: M1) -> Cuckoo.__DoNotUse<(People), Data?> where M1.MatchedType == People {
	        let matchers: [Cuckoo.ParameterMatcher<(People)>] = [wrap(matchable: person) { $0 }]
	        return cuckoo_manager.verify("getPersonProfileImgData(_: People) -> Data?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBLocalDataSourceProtocolStub: TMDBLocalDataSourceProtocol {
    

    

    
     func getMovie(id: Int) -> Movie?  {
        return DefaultValueRegistry.defaultValue(for: (Movie?).self)
    }
    
     func saveMovie(_ movie: Movie)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveMovies(_ movies: List<Movie>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getMoviePosterImgData(_ movie: Movie) -> Data?  {
        return DefaultValueRegistry.defaultValue(for: (Data?).self)
    }
    
     func saveMoviePosterImgData(_ movie: Movie, _ data: Data)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTVShow(id: Int) -> TVShow?  {
        return DefaultValueRegistry.defaultValue(for: (TVShow?).self)
    }
    
     func saveTVShows(_ tvShows: List<TVShow>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveTVPosterImgData(_ tvShow: TVShow, _ data: Data)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTVPosterImgData(_ tvShow: TVShow) -> Data?  {
        return DefaultValueRegistry.defaultValue(for: (Data?).self)
    }
    
     func getPerson(id: Int) -> People?  {
        return DefaultValueRegistry.defaultValue(for: (People?).self)
    }
    
     func savePeople(_ people: List<People>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func savePersonProfileImgData(_ person: People, _ data: Data)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPersonProfileImgData(_ person: People) -> Data?  {
        return DefaultValueRegistry.defaultValue(for: (Data?).self)
    }
    
}



 class MockTMDBLocalDataSource: TMDBLocalDataSource, Cuckoo.ClassMock {
    
     typealias MocksType = TMDBLocalDataSource
    
     typealias Stubbing = __StubbingProxy_TMDBLocalDataSource
     typealias Verification = __VerificationProxy_TMDBLocalDataSource

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: TMDBLocalDataSource?

     func enableDefaultImplementation(_ stub: TMDBLocalDataSource) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getMovie(id: Int) -> Movie? {
        
    return cuckoo_manager.call("getMovie(id: Int) -> Movie?",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                super.getMovie(id: id)
                ,
            defaultCall: __defaultImplStub!.getMovie(id: id))
        
    }
    
    
    
     override func saveMovie(_ movie: Movie)  {
        
    return cuckoo_manager.call("saveMovie(_: Movie)",
            parameters: (movie),
            escapingParameters: (movie),
            superclassCall:
                
                super.saveMovie(movie)
                ,
            defaultCall: __defaultImplStub!.saveMovie(movie))
        
    }
    
    
    
     override func saveMovies(_ movies: List<Movie>)  {
        
    return cuckoo_manager.call("saveMovies(_: List<Movie>)",
            parameters: (movies),
            escapingParameters: (movies),
            superclassCall:
                
                super.saveMovies(movies)
                ,
            defaultCall: __defaultImplStub!.saveMovies(movies))
        
    }
    
    
    
     override func getMoviePosterImgData(_ movie: Movie) -> Data? {
        
    return cuckoo_manager.call("getMoviePosterImgData(_: Movie) -> Data?",
            parameters: (movie),
            escapingParameters: (movie),
            superclassCall:
                
                super.getMoviePosterImgData(movie)
                ,
            defaultCall: __defaultImplStub!.getMoviePosterImgData(movie))
        
    }
    
    
    
     override func saveMoviePosterImgData(_ movie: Movie, _ data: Data)  {
        
    return cuckoo_manager.call("saveMoviePosterImgData(_: Movie, _: Data)",
            parameters: (movie, data),
            escapingParameters: (movie, data),
            superclassCall:
                
                super.saveMoviePosterImgData(movie, data)
                ,
            defaultCall: __defaultImplStub!.saveMoviePosterImgData(movie, data))
        
    }
    
    
    
     override func getTVShow(id: Int) -> TVShow? {
        
    return cuckoo_manager.call("getTVShow(id: Int) -> TVShow?",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                super.getTVShow(id: id)
                ,
            defaultCall: __defaultImplStub!.getTVShow(id: id))
        
    }
    
    
    
     override func saveTVShows(_ tvShows: List<TVShow>)  {
        
    return cuckoo_manager.call("saveTVShows(_: List<TVShow>)",
            parameters: (tvShows),
            escapingParameters: (tvShows),
            superclassCall:
                
                super.saveTVShows(tvShows)
                ,
            defaultCall: __defaultImplStub!.saveTVShows(tvShows))
        
    }
    
    
    
     override func saveTVPosterImgData(_ tvShow: TVShow, _ data: Data)  {
        
    return cuckoo_manager.call("saveTVPosterImgData(_: TVShow, _: Data)",
            parameters: (tvShow, data),
            escapingParameters: (tvShow, data),
            superclassCall:
                
                super.saveTVPosterImgData(tvShow, data)
                ,
            defaultCall: __defaultImplStub!.saveTVPosterImgData(tvShow, data))
        
    }
    
    
    
     override func getTVPosterImgData(_ tvShow: TVShow) -> Data? {
        
    return cuckoo_manager.call("getTVPosterImgData(_: TVShow) -> Data?",
            parameters: (tvShow),
            escapingParameters: (tvShow),
            superclassCall:
                
                super.getTVPosterImgData(tvShow)
                ,
            defaultCall: __defaultImplStub!.getTVPosterImgData(tvShow))
        
    }
    
    
    
     override func getPerson(id: Int) -> People? {
        
    return cuckoo_manager.call("getPerson(id: Int) -> People?",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                super.getPerson(id: id)
                ,
            defaultCall: __defaultImplStub!.getPerson(id: id))
        
    }
    
    
    
     override func savePeople(_ people: List<People>)  {
        
    return cuckoo_manager.call("savePeople(_: List<People>)",
            parameters: (people),
            escapingParameters: (people),
            superclassCall:
                
                super.savePeople(people)
                ,
            defaultCall: __defaultImplStub!.savePeople(people))
        
    }
    
    
    
     override func savePersonProfileImgData(_ person: People, _ data: Data)  {
        
    return cuckoo_manager.call("savePersonProfileImgData(_: People, _: Data)",
            parameters: (person, data),
            escapingParameters: (person, data),
            superclassCall:
                
                super.savePersonProfileImgData(person, data)
                ,
            defaultCall: __defaultImplStub!.savePersonProfileImgData(person, data))
        
    }
    
    
    
     override func getPersonProfileImgData(_ person: People) -> Data? {
        
    return cuckoo_manager.call("getPersonProfileImgData(_: People) -> Data?",
            parameters: (person),
            escapingParameters: (person),
            superclassCall:
                
                super.getPersonProfileImgData(person)
                ,
            defaultCall: __defaultImplStub!.getPersonProfileImgData(person))
        
    }
    

	 struct __StubbingProxy_TMDBLocalDataSource: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), Movie?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getMovie(id: Int) -> Movie?", parameterMatchers: matchers))
	    }
	    
	    func saveMovie<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.ClassStubNoReturnFunction<(Movie)> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveMovie(_: Movie)", parameterMatchers: matchers))
	    }
	    
	    func saveMovies<M1: Cuckoo.Matchable>(_ movies: M1) -> Cuckoo.ClassStubNoReturnFunction<(List<Movie>)> where M1.MatchedType == List<Movie> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>)>] = [wrap(matchable: movies) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveMovies(_: List<Movie>)", parameterMatchers: matchers))
	    }
	    
	    func getMoviePosterImgData<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.ClassStubFunction<(Movie), Data?> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getMoviePosterImgData(_: Movie) -> Data?", parameterMatchers: matchers))
	    }
	    
	    func saveMoviePosterImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movie: M1, _ data: M2) -> Cuckoo.ClassStubNoReturnFunction<(Movie, Data)> where M1.MatchedType == Movie, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie, Data)>] = [wrap(matchable: movie) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveMoviePosterImgData(_: Movie, _: Data)", parameterMatchers: matchers))
	    }
	    
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getTVShow(id: Int) -> TVShow?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShows<M1: Cuckoo.Matchable>(_ tvShows: M1) -> Cuckoo.ClassStubNoReturnFunction<(List<TVShow>)> where M1.MatchedType == List<TVShow> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>)>] = [wrap(matchable: tvShows) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveTVShows(_: List<TVShow>)", parameterMatchers: matchers))
	    }
	    
	    func saveTVPosterImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tvShow: M1, _ data: M2) -> Cuckoo.ClassStubNoReturnFunction<(TVShow, Data)> where M1.MatchedType == TVShow, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow, Data)>] = [wrap(matchable: tvShow) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveTVPosterImgData(_: TVShow, _: Data)", parameterMatchers: matchers))
	    }
	    
	    func getTVPosterImgData<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.ClassStubFunction<(TVShow), Data?> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getTVPosterImgData(_: TVShow) -> Data?", parameterMatchers: matchers))
	    }
	    
	    func getPerson<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), People?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getPerson(id: Int) -> People?", parameterMatchers: matchers))
	    }
	    
	    func savePeople<M1: Cuckoo.Matchable>(_ people: M1) -> Cuckoo.ClassStubNoReturnFunction<(List<People>)> where M1.MatchedType == List<People> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<People>)>] = [wrap(matchable: people) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "savePeople(_: List<People>)", parameterMatchers: matchers))
	    }
	    
	    func savePersonProfileImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ person: M1, _ data: M2) -> Cuckoo.ClassStubNoReturnFunction<(People, Data)> where M1.MatchedType == People, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(People, Data)>] = [wrap(matchable: person) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "savePersonProfileImgData(_: People, _: Data)", parameterMatchers: matchers))
	    }
	    
	    func getPersonProfileImgData<M1: Cuckoo.Matchable>(_ person: M1) -> Cuckoo.ClassStubFunction<(People), Data?> where M1.MatchedType == People {
	        let matchers: [Cuckoo.ParameterMatcher<(People)>] = [wrap(matchable: person) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getPersonProfileImgData(_: People) -> Data?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TMDBLocalDataSource: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), Movie?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getMovie(id: Int) -> Movie?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveMovie<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.__DoNotUse<(Movie), Void> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return cuckoo_manager.verify("saveMovie(_: Movie)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveMovies<M1: Cuckoo.Matchable>(_ movies: M1) -> Cuckoo.__DoNotUse<(List<Movie>), Void> where M1.MatchedType == List<Movie> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>)>] = [wrap(matchable: movies) { $0 }]
	        return cuckoo_manager.verify("saveMovies(_: List<Movie>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMoviePosterImgData<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.__DoNotUse<(Movie), Data?> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return cuckoo_manager.verify("getMoviePosterImgData(_: Movie) -> Data?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveMoviePosterImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movie: M1, _ data: M2) -> Cuckoo.__DoNotUse<(Movie, Data), Void> where M1.MatchedType == Movie, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie, Data)>] = [wrap(matchable: movie) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return cuckoo_manager.verify("saveMoviePosterImgData(_: Movie, _: Data)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getTVShow(id: Int) -> TVShow?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShows<M1: Cuckoo.Matchable>(_ tvShows: M1) -> Cuckoo.__DoNotUse<(List<TVShow>), Void> where M1.MatchedType == List<TVShow> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>)>] = [wrap(matchable: tvShows) { $0 }]
	        return cuckoo_manager.verify("saveTVShows(_: List<TVShow>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVPosterImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tvShow: M1, _ data: M2) -> Cuckoo.__DoNotUse<(TVShow, Data), Void> where M1.MatchedType == TVShow, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow, Data)>] = [wrap(matchable: tvShow) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return cuckoo_manager.verify("saveTVPosterImgData(_: TVShow, _: Data)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVPosterImgData<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.__DoNotUse<(TVShow), Data?> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return cuckoo_manager.verify("getTVPosterImgData(_: TVShow) -> Data?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPerson<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), People?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getPerson(id: Int) -> People?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func savePeople<M1: Cuckoo.Matchable>(_ people: M1) -> Cuckoo.__DoNotUse<(List<People>), Void> where M1.MatchedType == List<People> {
	        let matchers: [Cuckoo.ParameterMatcher<(List<People>)>] = [wrap(matchable: people) { $0 }]
	        return cuckoo_manager.verify("savePeople(_: List<People>)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func savePersonProfileImgData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ person: M1, _ data: M2) -> Cuckoo.__DoNotUse<(People, Data), Void> where M1.MatchedType == People, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(People, Data)>] = [wrap(matchable: person) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return cuckoo_manager.verify("savePersonProfileImgData(_: People, _: Data)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPersonProfileImgData<M1: Cuckoo.Matchable>(_ person: M1) -> Cuckoo.__DoNotUse<(People), Data?> where M1.MatchedType == People {
	        let matchers: [Cuckoo.ParameterMatcher<(People)>] = [wrap(matchable: person) { $0 }]
	        return cuckoo_manager.verify("getPersonProfileImgData(_: People) -> Data?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBLocalDataSourceStub: TMDBLocalDataSource {
    

    

    
     override func getMovie(id: Int) -> Movie?  {
        return DefaultValueRegistry.defaultValue(for: (Movie?).self)
    }
    
     override func saveMovie(_ movie: Movie)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveMovies(_ movies: List<Movie>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getMoviePosterImgData(_ movie: Movie) -> Data?  {
        return DefaultValueRegistry.defaultValue(for: (Data?).self)
    }
    
     override func saveMoviePosterImgData(_ movie: Movie, _ data: Data)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTVShow(id: Int) -> TVShow?  {
        return DefaultValueRegistry.defaultValue(for: (TVShow?).self)
    }
    
     override func saveTVShows(_ tvShows: List<TVShow>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveTVPosterImgData(_ tvShow: TVShow, _ data: Data)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTVPosterImgData(_ tvShow: TVShow) -> Data?  {
        return DefaultValueRegistry.defaultValue(for: (Data?).self)
    }
    
     override func getPerson(id: Int) -> People?  {
        return DefaultValueRegistry.defaultValue(for: (People?).self)
    }
    
     override func savePeople(_ people: List<People>)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func savePersonProfileImgData(_ person: People, _ data: Data)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPersonProfileImgData(_ person: People) -> Data?  {
        return DefaultValueRegistry.defaultValue(for: (Data?).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBRepository/TMDBRepository.swift at 2020-06-20 14:41:43 +0000

//
//  Repository.swift
//  TMDB
//
//  Created by Tuyen Le on 10.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//
import Cuckoo
@testable import TMDB

import Foundation


 class MockTMDBRepositoryProtocol: TMDBRepositoryProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TMDBRepositoryProtocol
    
     typealias Stubbing = __StubbingProxy_TMDBRepositoryProtocol
     typealias Verification = __VerificationProxy_TMDBRepositoryProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TMDBRepositoryProtocol?

     func enableDefaultImplementation(_ stub: TMDBRepositoryProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)  {
        
    return cuckoo_manager.call("getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)",
            parameters: (id, completion),
            escapingParameters: (id, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieDetail(id: id, completion: completion))
        
    }
    
    
    
     func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)",
            parameters: (time, type, completion),
            escapingParameters: (time, type, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTrending(time: time, type: type, completion: completion))
        
    }
    
    
    
     func getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularPeople(page: page, completion: completion))
        
    }
    
    
    
     func getProfileImageData(from people: People, completion: @escaping (Result<Data, Error>) -> Void)  {
        
    return cuckoo_manager.call("getProfileImageData(from: People, completion: @escaping (Result<Data, Error>) -> Void)",
            parameters: (people, completion),
            escapingParameters: (people, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getProfileImageData(from: people, completion: completion))
        
    }
    
    
    
     func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularMovie(page: page, completion: completion))
        
    }
    
    
    
     func getPosterImageData(from movie: Movie, completion: @escaping (Result<Data, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPosterImageData(from: Movie, completion: @escaping (Result<Data, Error>) -> Void)",
            parameters: (movie, completion),
            escapingParameters: (movie, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPosterImageData(from: movie, completion: completion))
        
    }
    
    
    
     func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularOnTV(page: page, completion: completion))
        
    }
    
    
    
     func getPosterImageData(from tvShow: TVShow, completion: @escaping (Result<Data, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPosterImageData(from: TVShow, completion: @escaping (Result<Data, Error>) -> Void)",
            parameters: (tvShow, completion),
            escapingParameters: (tvShow, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPosterImageData(from: tvShow, completion: completion))
        
    }
    
    
    
     func updateImageConfig()  {
        
    return cuckoo_manager.call("updateImageConfig()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.updateImageConfig())
        
    }
    

	 struct __StubbingProxy_TMDBRepositoryProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getMovieDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<Movie, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<Movie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<Movie, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getTrending<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(time: M1, type: M2, completion: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType, M3.MatchedType == (Result<TrendingResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularPeople<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<PopularPeopleResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularPeopleResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularPeopleResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getProfileImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from people: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(People, (Result<Data, Error>) -> Void)> where M1.MatchedType == People, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(People, (Result<Data, Error>) -> Void)>] = [wrap(matchable: people) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getProfileImageData(from: People, completion: @escaping (Result<Data, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<PopularMovie, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularMovie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularMovie, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPosterImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movie: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Movie, (Result<Data, Error>) -> Void)> where M1.MatchedType == Movie, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie, (Result<Data, Error>) -> Void)>] = [wrap(matchable: movie) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPosterImageData(from: Movie, completion: @escaping (Result<Data, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularOnTV<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<PopularOnTVResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularOnTVResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularOnTVResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPosterImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShow: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(TVShow, (Result<Data, Error>) -> Void)> where M1.MatchedType == TVShow, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow, (Result<Data, Error>) -> Void)>] = [wrap(matchable: tvShow) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPosterImageData(from: TVShow, completion: @escaping (Result<Data, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func updateImageConfig() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "updateImageConfig()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TMDBRepositoryProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getMovieDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<Movie, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<Movie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<Movie, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTrending<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(time: M1, type: M2, completion: M3) -> Cuckoo.__DoNotUse<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void), Void> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType, M3.MatchedType == (Result<TrendingResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularPeople<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<PopularPeopleResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularPeopleResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularPeopleResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getProfileImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from people: M1, completion: M2) -> Cuckoo.__DoNotUse<(People, (Result<Data, Error>) -> Void), Void> where M1.MatchedType == People, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(People, (Result<Data, Error>) -> Void)>] = [wrap(matchable: people) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getProfileImageData(from: People, completion: @escaping (Result<Data, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<PopularMovie, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularMovie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularMovie, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPosterImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movie: M1, completion: M2) -> Cuckoo.__DoNotUse<(Movie, (Result<Data, Error>) -> Void), Void> where M1.MatchedType == Movie, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie, (Result<Data, Error>) -> Void)>] = [wrap(matchable: movie) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPosterImageData(from: Movie, completion: @escaping (Result<Data, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularOnTV<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<PopularOnTVResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularOnTVResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularOnTVResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPosterImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShow: M1, completion: M2) -> Cuckoo.__DoNotUse<(TVShow, (Result<Data, Error>) -> Void), Void> where M1.MatchedType == TVShow, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow, (Result<Data, Error>) -> Void)>] = [wrap(matchable: tvShow) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPosterImageData(from: TVShow, completion: @escaping (Result<Data, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func updateImageConfig() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("updateImageConfig()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBRepositoryProtocolStub: TMDBRepositoryProtocol {
    

    

    
     func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getProfileImageData(from people: People, completion: @escaping (Result<Data, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPosterImageData(from movie: Movie, completion: @escaping (Result<Data, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPosterImageData(from tvShow: TVShow, completion: @escaping (Result<Data, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func updateImageConfig()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockTMDBRepository: TMDBRepository, Cuckoo.ClassMock {
    
     typealias MocksType = TMDBRepository
    
     typealias Stubbing = __StubbingProxy_TMDBRepository
     typealias Verification = __VerificationProxy_TMDBRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: TMDBRepository?

     func enableDefaultImplementation(_ stub: TMDBRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var userSetting: TMDBUserSettingProtocol {
        get {
            return cuckoo_manager.getter("userSetting",
                superclassCall:
                    
                    super.userSetting
                    ,
                defaultCall: __defaultImplStub!.userSetting)
        }
        
        set {
            cuckoo_manager.setter("userSetting",
                value: newValue,
                superclassCall:
                    
                    super.userSetting = newValue
                    ,
                defaultCall: __defaultImplStub!.userSetting = newValue)
        }
        
    }
    

    

    
    
    
     override func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)  {
        
    return cuckoo_manager.call("getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)",
            parameters: (id, completion),
            escapingParameters: (id, completion),
            superclassCall:
                
                super.getMovieDetail(id: id, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getMovieDetail(id: id, completion: completion))
        
    }
    
    
    
     override func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                super.getPopularMovie(page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getPopularMovie(page: page, completion: completion))
        
    }
    
    
    
     override func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                super.getPopularOnTV(page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getPopularOnTV(page: page, completion: completion))
        
    }
    
    
    
     override func getPosterImageData(from tvShow: TVShow, completion: @escaping (Result<Data, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPosterImageData(from: TVShow, completion: @escaping (Result<Data, Error>) -> Void)",
            parameters: (tvShow, completion),
            escapingParameters: (tvShow, completion),
            superclassCall:
                
                super.getPosterImageData(from: tvShow, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getPosterImageData(from: tvShow, completion: completion))
        
    }
    
    
    
     override func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)",
            parameters: (time, type, completion),
            escapingParameters: (time, type, completion),
            superclassCall:
                
                super.getTrending(time: time, type: type, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getTrending(time: time, type: type, completion: completion))
        
    }
    
    
    
     override func getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                super.getPopularPeople(page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getPopularPeople(page: page, completion: completion))
        
    }
    
    
    
     override func getProfileImageData(from people: People, completion: @escaping (Result<Data, Error>) -> Void)  {
        
    return cuckoo_manager.call("getProfileImageData(from: People, completion: @escaping (Result<Data, Error>) -> Void)",
            parameters: (people, completion),
            escapingParameters: (people, completion),
            superclassCall:
                
                super.getProfileImageData(from: people, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getProfileImageData(from: people, completion: completion))
        
    }
    
    
    
     override func getPosterImageData(from movie: Movie, completion: @escaping (Result<Data, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPosterImageData(from: Movie, completion: @escaping (Result<Data, Error>) -> Void)",
            parameters: (movie, completion),
            escapingParameters: (movie, completion),
            superclassCall:
                
                super.getPosterImageData(from: movie, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getPosterImageData(from: movie, completion: completion))
        
    }
    
    
    
     override func updateImageConfig()  {
        
    return cuckoo_manager.call("updateImageConfig()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.updateImageConfig()
                ,
            defaultCall: __defaultImplStub!.updateImageConfig())
        
    }
    

	 struct __StubbingProxy_TMDBRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var userSetting: Cuckoo.ClassToBeStubbedProperty<MockTMDBRepository, TMDBUserSettingProtocol> {
	        return .init(manager: cuckoo_manager, name: "userSetting")
	    }
	    
	    
	    func getMovieDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<Movie, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<Movie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<Movie, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<PopularMovie, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularMovie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularMovie, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularOnTV<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<PopularOnTVResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularOnTVResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularOnTVResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPosterImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShow: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(TVShow, (Result<Data, Error>) -> Void)> where M1.MatchedType == TVShow, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow, (Result<Data, Error>) -> Void)>] = [wrap(matchable: tvShow) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPosterImageData(from: TVShow, completion: @escaping (Result<Data, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getTrending<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(time: M1, type: M2, completion: M3) -> Cuckoo.ClassStubNoReturnFunction<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType, M3.MatchedType == (Result<TrendingResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularPeople<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<PopularPeopleResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularPeopleResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularPeopleResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getProfileImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from people: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(People, (Result<Data, Error>) -> Void)> where M1.MatchedType == People, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(People, (Result<Data, Error>) -> Void)>] = [wrap(matchable: people) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getProfileImageData(from: People, completion: @escaping (Result<Data, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPosterImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movie: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Movie, (Result<Data, Error>) -> Void)> where M1.MatchedType == Movie, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie, (Result<Data, Error>) -> Void)>] = [wrap(matchable: movie) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPosterImageData(from: Movie, completion: @escaping (Result<Data, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func updateImageConfig() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "updateImageConfig()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TMDBRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var userSetting: Cuckoo.VerifyProperty<TMDBUserSettingProtocol> {
	        return .init(manager: cuckoo_manager, name: "userSetting", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func getMovieDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<Movie, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<Movie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<Movie, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<PopularMovie, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularMovie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularMovie, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularOnTV<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<PopularOnTVResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularOnTVResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularOnTVResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPosterImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShow: M1, completion: M2) -> Cuckoo.__DoNotUse<(TVShow, (Result<Data, Error>) -> Void), Void> where M1.MatchedType == TVShow, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow, (Result<Data, Error>) -> Void)>] = [wrap(matchable: tvShow) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPosterImageData(from: TVShow, completion: @escaping (Result<Data, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTrending<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(time: M1, type: M2, completion: M3) -> Cuckoo.__DoNotUse<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void), Void> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType, M3.MatchedType == (Result<TrendingResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularPeople<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<PopularPeopleResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<PopularPeopleResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PopularPeopleResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getProfileImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from people: M1, completion: M2) -> Cuckoo.__DoNotUse<(People, (Result<Data, Error>) -> Void), Void> where M1.MatchedType == People, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(People, (Result<Data, Error>) -> Void)>] = [wrap(matchable: people) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getProfileImageData(from: People, completion: @escaping (Result<Data, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPosterImageData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movie: M1, completion: M2) -> Cuckoo.__DoNotUse<(Movie, (Result<Data, Error>) -> Void), Void> where M1.MatchedType == Movie, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie, (Result<Data, Error>) -> Void)>] = [wrap(matchable: movie) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPosterImageData(from: Movie, completion: @escaping (Result<Data, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func updateImageConfig() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("updateImageConfig()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBRepositoryStub: TMDBRepository {
    
    
     override var userSetting: TMDBUserSettingProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (TMDBUserSettingProtocol).self)
        }
        
        set { }
        
    }
    

    

    
     override func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPopularMovie(page: Int, completion: @escaping (Result<PopularMovie, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPopularOnTV(page: Int, completion: @escaping (Result<PopularOnTVResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPosterImageData(from tvShow: TVShow, completion: @escaping (Result<Data, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPopularPeople(page: Int, completion: @escaping (Result<PopularPeopleResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getProfileImageData(from people: People, completion: @escaping (Result<Data, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPosterImageData(from movie: Movie, completion: @escaping (Result<Data, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func updateImageConfig()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBSession.swift at 2020-06-20 14:41:43 +0000

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
    
    
    
     func send(url: URL, completion: @escaping (Result<Data, Error>) -> Void)  {
        
    return cuckoo_manager.call("send(url: URL, completion: @escaping (Result<Data, Error>) -> Void)",
            parameters: (url, completion),
            escapingParameters: (url, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.send(url: url, completion: completion))
        
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
	    
	    func send<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(url: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(URL, (Result<Data, Error>) -> Void)> where M1.MatchedType == URL, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URL, (Result<Data, Error>) -> Void)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBSessionProtocol.self, method: "send(url: URL, completion: @escaping (Result<Data, Error>) -> Void)", parameterMatchers: matchers))
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
	    
	    @discardableResult
	    func send<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(url: M1, completion: M2) -> Cuckoo.__DoNotUse<(URL, (Result<Data, Error>) -> Void), Void> where M1.MatchedType == URL, M2.MatchedType == (Result<Data, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URL, (Result<Data, Error>) -> Void)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("send(url: URL, completion: @escaping (Result<Data, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBSessionProtocolStub: TMDBSessionProtocol {
    

    

    
     func send<T: Decodable>(request: URLRequest, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func send(url: URL, completion: @escaping (Result<Data, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLRequestBuilder.swift at 2020-06-20 14:41:43 +0000

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
    
    
    
     func getImageConfigURLRequest() -> URLRequest {
        
    return cuckoo_manager.call("getImageConfigURLRequest() -> URLRequest",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getImageConfigURLRequest())
        
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
	    
	    func getImageConfigURLRequest() -> Cuckoo.ProtocolStubFunction<(), URLRequest> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getImageConfigURLRequest() -> URLRequest", parameterMatchers: matchers))
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
	    
	    @discardableResult
	    func getImageConfigURLRequest() -> Cuckoo.__DoNotUse<(), URLRequest> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getImageConfigURLRequest() -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    
     func getImageConfigURLRequest() -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLSessionDataTaskProtocol.swift at 2020-06-20 14:41:43 +0000

//
//  URLSessionDataTaskProtocol.swift
//  TMDB
//
//  Created by Tuyen Le on 14.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Cuckoo
@testable import TMDB

import Foundation


 class MockTMDBURLSessionDataTaskProtocol: TMDBURLSessionDataTaskProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TMDBURLSessionDataTaskProtocol
    
     typealias Stubbing = __StubbingProxy_TMDBURLSessionDataTaskProtocol
     typealias Verification = __VerificationProxy_TMDBURLSessionDataTaskProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TMDBURLSessionDataTaskProtocol?

     func enableDefaultImplementation(_ stub: TMDBURLSessionDataTaskProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func tmdbResume()  {
        
    return cuckoo_manager.call("tmdbResume()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.tmdbResume())
        
    }
    

	 struct __StubbingProxy_TMDBURLSessionDataTaskProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func tmdbResume() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLSessionDataTaskProtocol.self, method: "tmdbResume()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TMDBURLSessionDataTaskProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func tmdbResume() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("tmdbResume()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBURLSessionDataTaskProtocolStub: TMDBURLSessionDataTaskProtocol {
    

    

    
     func tmdbResume()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLSessionProtocol.swift at 2020-06-20 14:41:43 +0000

//
//  URLSessionProtocol.swift
//  TMDB
//
//  Created by Tuyen Le on 14.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Cuckoo
@testable import TMDB

import Foundation


 class MockTMDBURLSessionProtocol: TMDBURLSessionProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = TMDBURLSessionProtocol
    
     typealias Stubbing = __StubbingProxy_TMDBURLSessionProtocol
     typealias Verification = __VerificationProxy_TMDBURLSessionProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: TMDBURLSessionProtocol?

     func enableDefaultImplementation(_ stub: TMDBURLSessionProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func tmdbDataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol {
        
    return cuckoo_manager.call("tmdbDataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol",
            parameters: (with, completionHandler),
            escapingParameters: (with, completionHandler),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.tmdbDataTask(with: with, completionHandler: completionHandler))
        
    }
    
    
    
     func tmdbDataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol {
        
    return cuckoo_manager.call("tmdbDataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol",
            parameters: (with, completionHandler),
            escapingParameters: (with, completionHandler),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.tmdbDataTask(with: with, completionHandler: completionHandler))
        
    }
    

	 struct __StubbingProxy_TMDBURLSessionProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func tmdbDataTask<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with: M1, completionHandler: M2) -> Cuckoo.ProtocolStubFunction<(URLRequest, (Data?, URLResponse?, Error?) -> Void), TMDBURLSessionDataTaskProtocol> where M1.MatchedType == URLRequest, M2.MatchedType == (Data?, URLResponse?, Error?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest, (Data?, URLResponse?, Error?) -> Void)>] = [wrap(matchable: with) { $0.0 }, wrap(matchable: completionHandler) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLSessionProtocol.self, method: "tmdbDataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol", parameterMatchers: matchers))
	    }
	    
	    func tmdbDataTask<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with: M1, completionHandler: M2) -> Cuckoo.ProtocolStubFunction<(URL, (Data?, URLResponse?, Error?) -> Void), TMDBURLSessionDataTaskProtocol> where M1.MatchedType == URL, M2.MatchedType == (Data?, URLResponse?, Error?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URL, (Data?, URLResponse?, Error?) -> Void)>] = [wrap(matchable: with) { $0.0 }, wrap(matchable: completionHandler) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLSessionProtocol.self, method: "tmdbDataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_TMDBURLSessionProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func tmdbDataTask<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with: M1, completionHandler: M2) -> Cuckoo.__DoNotUse<(URLRequest, (Data?, URLResponse?, Error?) -> Void), TMDBURLSessionDataTaskProtocol> where M1.MatchedType == URLRequest, M2.MatchedType == (Data?, URLResponse?, Error?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest, (Data?, URLResponse?, Error?) -> Void)>] = [wrap(matchable: with) { $0.0 }, wrap(matchable: completionHandler) { $0.1 }]
	        return cuckoo_manager.verify("tmdbDataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func tmdbDataTask<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with: M1, completionHandler: M2) -> Cuckoo.__DoNotUse<(URL, (Data?, URLResponse?, Error?) -> Void), TMDBURLSessionDataTaskProtocol> where M1.MatchedType == URL, M2.MatchedType == (Data?, URLResponse?, Error?) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(URL, (Data?, URLResponse?, Error?) -> Void)>] = [wrap(matchable: with) { $0.0 }, wrap(matchable: completionHandler) { $0.1 }]
	        return cuckoo_manager.verify("tmdbDataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBURLSessionProtocolStub: TMDBURLSessionProtocol {
    

    

    
     func tmdbDataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol  {
        return DefaultValueRegistry.defaultValue(for: (TMDBURLSessionDataTaskProtocol).self)
    }
    
     func tmdbDataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> TMDBURLSessionDataTaskProtocol  {
        return DefaultValueRegistry.defaultValue(for: (TMDBURLSessionDataTaskProtocol).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBUserSetting/TMDBUserSetting.swift at 2020-06-20 14:41:43 +0000

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
    
    
    
     var imageConfig: ImageConfigResult {
        get {
            return cuckoo_manager.getter("imageConfig",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.imageConfig)
        }
        
        set {
            cuckoo_manager.setter("imageConfig",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.imageConfig = newValue)
        }
        
    }
    
    
    
     var userDefault: UserDefaults {
        get {
            return cuckoo_manager.getter("userDefault",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.userDefault)
        }
        
        set {
            cuckoo_manager.setter("userDefault",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.userDefault = newValue)
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
	    
	    
	    var imageConfig: Cuckoo.ProtocolToBeStubbedProperty<MockTMDBUserSettingProtocol, ImageConfigResult> {
	        return .init(manager: cuckoo_manager, name: "imageConfig")
	    }
	    
	    
	    var userDefault: Cuckoo.ProtocolToBeStubbedProperty<MockTMDBUserSettingProtocol, UserDefaults> {
	        return .init(manager: cuckoo_manager, name: "userDefault")
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
	    
	    
	    var imageConfig: Cuckoo.VerifyProperty<ImageConfigResult> {
	        return .init(manager: cuckoo_manager, name: "imageConfig", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var userDefault: Cuckoo.VerifyProperty<UserDefaults> {
	        return .init(manager: cuckoo_manager, name: "userDefault", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
    
    
     var imageConfig: ImageConfigResult {
        get {
            return DefaultValueRegistry.defaultValue(for: (ImageConfigResult).self)
        }
        
        set { }
        
    }
    
    
     var userDefault: UserDefaults {
        get {
            return DefaultValueRegistry.defaultValue(for: (UserDefaults).self)
        }
        
        set { }
        
    }
    

    

    
}

