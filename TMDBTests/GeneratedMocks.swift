// MARK: - Mocks generated from file: TMDB/TMDBLocalDataSource/TMDBLocalDataSource.swift at 2020-07-23 21:32:10 +0000

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
    
    
    
     func saveSimilarMovie(_ similarMovie: List<Movie>, to movie: Movie)  {
        
    return cuckoo_manager.call("saveSimilarMovie(_: List<Movie>, to: Movie)",
            parameters: (similarMovie, movie),
            escapingParameters: (similarMovie, movie),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveSimilarMovie(similarMovie, to: movie))
        
    }
    
    
    
     func saveRecommendMovie(_ recommendMovie: List<Movie>, to movie: Movie)  {
        
    return cuckoo_manager.call("saveRecommendMovie(_: List<Movie>, to: Movie)",
            parameters: (recommendMovie, movie),
            escapingParameters: (recommendMovie, movie),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveRecommendMovie(recommendMovie, to: movie))
        
    }
    
    
    
     func saveMovieImages(_ movieImages: MovieImages, to movieId: Int)  {
        
    return cuckoo_manager.call("saveMovieImages(_: MovieImages, to: Int)",
            parameters: (movieImages, movieId),
            escapingParameters: (movieImages, movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveMovieImages(movieImages, to: movieId))
        
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
    
    
    
     func saveTVShow(_ tvShow: TVShow)  {
        
    return cuckoo_manager.call("saveTVShow(_: TVShow)",
            parameters: (tvShow),
            escapingParameters: (tvShow),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveTVShow(tvShow))
        
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
    
    
    
     func savePerson(_ person: People)  {
        
    return cuckoo_manager.call("savePerson(_: People)",
            parameters: (person),
            escapingParameters: (person),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.savePerson(person))
        
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
	    
	    func saveSimilarMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarMovie: M1, to movie: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(List<Movie>, Movie)> where M1.MatchedType == List<Movie>, M2.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Movie)>] = [wrap(matchable: similarMovie) { $0.0 }, wrap(matchable: movie) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveSimilarMovie(_: List<Movie>, to: Movie)", parameterMatchers: matchers))
	    }
	    
	    func saveRecommendMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendMovie: M1, to movie: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(List<Movie>, Movie)> where M1.MatchedType == List<Movie>, M2.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Movie)>] = [wrap(matchable: recommendMovie) { $0.0 }, wrap(matchable: movie) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveRecommendMovie(_: List<Movie>, to: Movie)", parameterMatchers: matchers))
	    }
	    
	    func saveMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movieImages: M1, to movieId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(MovieImages, Int)> where M1.MatchedType == MovieImages, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieImages, Int)>] = [wrap(matchable: movieImages) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveMovieImages(_: MovieImages, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getTVShow(id: Int) -> TVShow?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShow<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(TVShow)> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveTVShow(_: TVShow)", parameterMatchers: matchers))
	    }
	    
	    func getPerson<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Int), People?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getPerson(id: Int) -> People?", parameterMatchers: matchers))
	    }
	    
	    func savePerson<M1: Cuckoo.Matchable>(_ person: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(People)> where M1.MatchedType == People {
	        let matchers: [Cuckoo.ParameterMatcher<(People)>] = [wrap(matchable: person) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "savePerson(_: People)", parameterMatchers: matchers))
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
	    func saveSimilarMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarMovie: M1, to movie: M2) -> Cuckoo.__DoNotUse<(List<Movie>, Movie), Void> where M1.MatchedType == List<Movie>, M2.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Movie)>] = [wrap(matchable: similarMovie) { $0.0 }, wrap(matchable: movie) { $0.1 }]
	        return cuckoo_manager.verify("saveSimilarMovie(_: List<Movie>, to: Movie)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveRecommendMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendMovie: M1, to movie: M2) -> Cuckoo.__DoNotUse<(List<Movie>, Movie), Void> where M1.MatchedType == List<Movie>, M2.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Movie)>] = [wrap(matchable: recommendMovie) { $0.0 }, wrap(matchable: movie) { $0.1 }]
	        return cuckoo_manager.verify("saveRecommendMovie(_: List<Movie>, to: Movie)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movieImages: M1, to movieId: M2) -> Cuckoo.__DoNotUse<(MovieImages, Int), Void> where M1.MatchedType == MovieImages, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieImages, Int)>] = [wrap(matchable: movieImages) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return cuckoo_manager.verify("saveMovieImages(_: MovieImages, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getTVShow(id: Int) -> TVShow?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShow<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.__DoNotUse<(TVShow), Void> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return cuckoo_manager.verify("saveTVShow(_: TVShow)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPerson<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), People?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getPerson(id: Int) -> People?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func savePerson<M1: Cuckoo.Matchable>(_ person: M1) -> Cuckoo.__DoNotUse<(People), Void> where M1.MatchedType == People {
	        let matchers: [Cuckoo.ParameterMatcher<(People)>] = [wrap(matchable: person) { $0 }]
	        return cuckoo_manager.verify("savePerson(_: People)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    
     func saveSimilarMovie(_ similarMovie: List<Movie>, to movie: Movie)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveRecommendMovie(_ recommendMovie: List<Movie>, to movie: Movie)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveMovieImages(_ movieImages: MovieImages, to movieId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTVShow(id: Int) -> TVShow?  {
        return DefaultValueRegistry.defaultValue(for: (TVShow?).self)
    }
    
     func saveTVShow(_ tvShow: TVShow)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPerson(id: Int) -> People?  {
        return DefaultValueRegistry.defaultValue(for: (People?).self)
    }
    
     func savePerson(_ person: People)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
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
    

    

    

    
    
    
     override func saveMovieImages(_ movieImages: MovieImages, to movieId: Int)  {
        
    return cuckoo_manager.call("saveMovieImages(_: MovieImages, to: Int)",
            parameters: (movieImages, movieId),
            escapingParameters: (movieImages, movieId),
            superclassCall:
                
                super.saveMovieImages(movieImages, to: movieId)
                ,
            defaultCall: __defaultImplStub!.saveMovieImages(movieImages, to: movieId))
        
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
    
    
    
     override func saveSimilarMovie(_ similarMovie: List<Movie>, to movie: Movie)  {
        
    return cuckoo_manager.call("saveSimilarMovie(_: List<Movie>, to: Movie)",
            parameters: (similarMovie, movie),
            escapingParameters: (similarMovie, movie),
            superclassCall:
                
                super.saveSimilarMovie(similarMovie, to: movie)
                ,
            defaultCall: __defaultImplStub!.saveSimilarMovie(similarMovie, to: movie))
        
    }
    
    
    
     override func saveRecommendMovie(_ recommendMovie: List<Movie>, to movie: Movie)  {
        
    return cuckoo_manager.call("saveRecommendMovie(_: List<Movie>, to: Movie)",
            parameters: (recommendMovie, movie),
            escapingParameters: (recommendMovie, movie),
            superclassCall:
                
                super.saveRecommendMovie(recommendMovie, to: movie)
                ,
            defaultCall: __defaultImplStub!.saveRecommendMovie(recommendMovie, to: movie))
        
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
    
    
    
     override func saveTVShow(_ tvShow: TVShow)  {
        
    return cuckoo_manager.call("saveTVShow(_: TVShow)",
            parameters: (tvShow),
            escapingParameters: (tvShow),
            superclassCall:
                
                super.saveTVShow(tvShow)
                ,
            defaultCall: __defaultImplStub!.saveTVShow(tvShow))
        
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
    
    
    
     override func savePerson(_ person: People)  {
        
    return cuckoo_manager.call("savePerson(_: People)",
            parameters: (person),
            escapingParameters: (person),
            superclassCall:
                
                super.savePerson(person)
                ,
            defaultCall: __defaultImplStub!.savePerson(person))
        
    }
    

	 struct __StubbingProxy_TMDBLocalDataSource: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func saveMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movieImages: M1, to movieId: M2) -> Cuckoo.ClassStubNoReturnFunction<(MovieImages, Int)> where M1.MatchedType == MovieImages, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieImages, Int)>] = [wrap(matchable: movieImages) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveMovieImages(_: MovieImages, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func getMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), Movie?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getMovie(id: Int) -> Movie?", parameterMatchers: matchers))
	    }
	    
	    func saveMovie<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.ClassStubNoReturnFunction<(Movie)> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveMovie(_: Movie)", parameterMatchers: matchers))
	    }
	    
	    func saveSimilarMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarMovie: M1, to movie: M2) -> Cuckoo.ClassStubNoReturnFunction<(List<Movie>, Movie)> where M1.MatchedType == List<Movie>, M2.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Movie)>] = [wrap(matchable: similarMovie) { $0.0 }, wrap(matchable: movie) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveSimilarMovie(_: List<Movie>, to: Movie)", parameterMatchers: matchers))
	    }
	    
	    func saveRecommendMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendMovie: M1, to movie: M2) -> Cuckoo.ClassStubNoReturnFunction<(List<Movie>, Movie)> where M1.MatchedType == List<Movie>, M2.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Movie)>] = [wrap(matchable: recommendMovie) { $0.0 }, wrap(matchable: movie) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveRecommendMovie(_: List<Movie>, to: Movie)", parameterMatchers: matchers))
	    }
	    
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getTVShow(id: Int) -> TVShow?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShow<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.ClassStubNoReturnFunction<(TVShow)> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveTVShow(_: TVShow)", parameterMatchers: matchers))
	    }
	    
	    func getPerson<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), People?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getPerson(id: Int) -> People?", parameterMatchers: matchers))
	    }
	    
	    func savePerson<M1: Cuckoo.Matchable>(_ person: M1) -> Cuckoo.ClassStubNoReturnFunction<(People)> where M1.MatchedType == People {
	        let matchers: [Cuckoo.ParameterMatcher<(People)>] = [wrap(matchable: person) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "savePerson(_: People)", parameterMatchers: matchers))
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
	    func saveMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movieImages: M1, to movieId: M2) -> Cuckoo.__DoNotUse<(MovieImages, Int), Void> where M1.MatchedType == MovieImages, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(MovieImages, Int)>] = [wrap(matchable: movieImages) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return cuckoo_manager.verify("saveMovieImages(_: MovieImages, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
	    func saveSimilarMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarMovie: M1, to movie: M2) -> Cuckoo.__DoNotUse<(List<Movie>, Movie), Void> where M1.MatchedType == List<Movie>, M2.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Movie)>] = [wrap(matchable: similarMovie) { $0.0 }, wrap(matchable: movie) { $0.1 }]
	        return cuckoo_manager.verify("saveSimilarMovie(_: List<Movie>, to: Movie)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveRecommendMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendMovie: M1, to movie: M2) -> Cuckoo.__DoNotUse<(List<Movie>, Movie), Void> where M1.MatchedType == List<Movie>, M2.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Movie)>] = [wrap(matchable: recommendMovie) { $0.0 }, wrap(matchable: movie) { $0.1 }]
	        return cuckoo_manager.verify("saveRecommendMovie(_: List<Movie>, to: Movie)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getTVShow(id: Int) -> TVShow?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShow<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.__DoNotUse<(TVShow), Void> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return cuckoo_manager.verify("saveTVShow(_: TVShow)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPerson<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Int), People?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getPerson(id: Int) -> People?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func savePerson<M1: Cuckoo.Matchable>(_ person: M1) -> Cuckoo.__DoNotUse<(People), Void> where M1.MatchedType == People {
	        let matchers: [Cuckoo.ParameterMatcher<(People)>] = [wrap(matchable: person) { $0 }]
	        return cuckoo_manager.verify("savePerson(_: People)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBLocalDataSourceStub: TMDBLocalDataSource {
    

    

    
     override func saveMovieImages(_ movieImages: MovieImages, to movieId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getMovie(id: Int) -> Movie?  {
        return DefaultValueRegistry.defaultValue(for: (Movie?).self)
    }
    
     override func saveMovie(_ movie: Movie)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveSimilarMovie(_ similarMovie: List<Movie>, to movie: Movie)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveRecommendMovie(_ recommendMovie: List<Movie>, to movie: Movie)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTVShow(id: Int) -> TVShow?  {
        return DefaultValueRegistry.defaultValue(for: (TVShow?).self)
    }
    
     override func saveTVShow(_ tvShow: TVShow)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPerson(id: Int) -> People?  {
        return DefaultValueRegistry.defaultValue(for: (People?).self)
    }
    
     override func savePerson(_ person: People)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBRepository/TMDBRepository.swift at 2020-07-23 21:32:10 +0000

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
    
    
    
     func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getSimilarMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)",
            parameters: (movieId, page, completion),
            escapingParameters: (movieId, page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getSimilarMovies(from: movieId, page: page, completion: completion))
        
    }
    
    
    
     func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getRecommendMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)",
            parameters: (movieId, page, completion),
            escapingParameters: (movieId, page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getRecommendMovies(from: movieId, page: page, completion: completion))
        
    }
    
    
    
     func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularMovie(page: page, completion: completion))
        
    }
    
    
    
     func getMovieReview(from movieId: Int) -> [Review] {
        
    return cuckoo_manager.call("getMovieReview(from: Int) -> [Review]",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieReview(from: movieId))
        
    }
    
    
    
     func getMovieCast(from movieId: Int) -> [Cast] {
        
    return cuckoo_manager.call("getMovieCast(from: Int) -> [Cast]",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieCast(from: movieId))
        
    }
    
    
    
     func getMovieCrew(from movieId: Int) -> [Crew] {
        
    return cuckoo_manager.call("getMovieCrew(from: Int) -> [Crew]",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieCrew(from: movieId))
        
    }
    
    
    
     func getMovieKeywords(from movieId: Int) -> [Keyword] {
        
    return cuckoo_manager.call("getMovieKeywords(from: Int) -> [Keyword]",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieKeywords(from: movieId))
        
    }
    
    
    
     func getMovieImages(from movieId: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)  {
        
    return cuckoo_manager.call("getMovieImages(from: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)",
            parameters: (movieId, completion),
            escapingParameters: (movieId, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieImages(from: movieId, completion: completion))
        
    }
    
    
    
     func getMovieImages(from movieId: Int) -> MovieImages? {
        
    return cuckoo_manager.call("getMovieImages(from: Int) -> MovieImages?",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieImages(from: movieId))
        
    }
    
    
    
     func getMovieReleaseDates(from movieId: Int) -> ReleaseDateResults? {
        
    return cuckoo_manager.call("getMovieReleaseDates(from: Int) -> ReleaseDateResults?",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieReleaseDates(from: movieId))
        
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
    
    
    
     func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularPeople(page: page, completion: completion))
        
    }
    
    
    
     func getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)",
            parameters: (id, completion),
            escapingParameters: (id, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPersonDetail(id: id, completion: completion))
        
    }
    
    
    
     func getTVCredits(from personId: Int) -> TVCredit? {
        
    return cuckoo_manager.call("getTVCredits(from: Int) -> TVCredit?",
            parameters: (personId),
            escapingParameters: (personId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVCredits(from: personId))
        
    }
    
    
    
     func getMovieCredits(from personId: Int) -> MovieCredit? {
        
    return cuckoo_manager.call("getMovieCredits(from: Int) -> MovieCredit?",
            parameters: (personId),
            escapingParameters: (personId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieCredits(from: personId))
        
    }
    
    
    
     func getPersonImageProfile(from personId: Int) -> ImageProfile? {
        
    return cuckoo_manager.call("getPersonImageProfile(from: Int) -> ImageProfile?",
            parameters: (personId),
            escapingParameters: (personId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPersonImageProfile(from: personId))
        
    }
    
    
    
     func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularOnTV(page: page, completion: completion))
        
    }
    
    
    
     func getTVShowDetail(from tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void)  {
        
    return cuckoo_manager.call("getTVShowDetail(from: Int, completion: @escaping (Result<TVShow, Error>) -> Void)",
            parameters: (tvShowId, completion),
            escapingParameters: (tvShowId, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowDetail(from: tvShowId, completion: completion))
        
    }
    
    
    
     func getTVShowKeywords(from tvShowId: Int) -> [Keyword] {
        
    return cuckoo_manager.call("getTVShowKeywords(from: Int) -> [Keyword]",
            parameters: (tvShowId),
            escapingParameters: (tvShowId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowKeywords(from: tvShowId))
        
    }
    
    
    
     func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getSimilarTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)",
            parameters: (tvShowId, page, completion),
            escapingParameters: (tvShowId, page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getSimilarTVShows(from: tvShowId, page: page, completion: completion))
        
    }
    
    
    
     func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getRecommendTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)",
            parameters: (tvShowId, page, completion),
            escapingParameters: (tvShowId, page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getRecommendTVShows(from: tvShowId, page: page, completion: completion))
        
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
    
    
    
     func multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)",
            parameters: (query, page, completion),
            escapingParameters: (query, page, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.multiSearch(query: query, page: page, completion: completion))
        
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
	    
	    func getSimilarMovies<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from movieId: M1, page: M2, completion: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, Int, (Result<MovieResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getSimilarMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getRecommendMovies<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from movieId: M1, page: M2, completion: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, Int, (Result<MovieResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getRecommendMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<MovieResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getMovieReview<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ProtocolStubFunction<(Int), [Review]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getMovieReview(from: Int) -> [Review]", parameterMatchers: matchers))
	    }
	    
	    func getMovieCast<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ProtocolStubFunction<(Int), [Cast]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getMovieCast(from: Int) -> [Cast]", parameterMatchers: matchers))
	    }
	    
	    func getMovieCrew<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ProtocolStubFunction<(Int), [Crew]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getMovieCrew(from: Int) -> [Crew]", parameterMatchers: matchers))
	    }
	    
	    func getMovieKeywords<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ProtocolStubFunction<(Int), [Keyword]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getMovieKeywords(from: Int) -> [Keyword]", parameterMatchers: matchers))
	    }
	    
	    func getMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movieId: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<MovieImages, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<MovieImages, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<MovieImages, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getMovieImages(from: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getMovieImages<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ProtocolStubFunction<(Int), MovieImages?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getMovieImages(from: Int) -> MovieImages?", parameterMatchers: matchers))
	    }
	    
	    func getMovieReleaseDates<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ProtocolStubFunction<(Int), ReleaseDateResults?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getMovieReleaseDates(from: Int) -> ReleaseDateResults?", parameterMatchers: matchers))
	    }
	    
	    func getTrending<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(time: M1, type: M2, completion: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType, M3.MatchedType == (Result<TrendingResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularPeople<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<PeopleResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<PeopleResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PeopleResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPersonDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<People, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<People, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<People, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getTVCredits<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.ProtocolStubFunction<(Int), TVCredit?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getTVCredits(from: Int) -> TVCredit?", parameterMatchers: matchers))
	    }
	    
	    func getMovieCredits<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.ProtocolStubFunction<(Int), MovieCredit?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getMovieCredits(from: Int) -> MovieCredit?", parameterMatchers: matchers))
	    }
	    
	    func getPersonImageProfile<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.ProtocolStubFunction<(Int), ImageProfile?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPersonImageProfile(from: Int) -> ImageProfile?", parameterMatchers: matchers))
	    }
	    
	    func getPopularOnTV<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<TVShowResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getTVShowDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShowId: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, (Result<TVShow, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<TVShow, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<TVShow, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getTVShowDetail(from: Int, completion: @escaping (Result<TVShow, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getTVShowKeywords<M1: Cuckoo.Matchable>(from tvShowId: M1) -> Cuckoo.ProtocolStubFunction<(Int), [Keyword]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: tvShowId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getTVShowKeywords(from: Int) -> [Keyword]", parameterMatchers: matchers))
	    }
	    
	    func getSimilarTVShows<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, page: M2, completion: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, Int, (Result<TVShowResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getSimilarTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getRecommendTVShows<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, page: M2, completion: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, Int, (Result<TVShowResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "getRecommendTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func updateImageConfig() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "updateImageConfig()", parameterMatchers: matchers))
	    }
	    
	    func multiSearch<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(query: M1, page: M2, completion: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(String, Int, (Result<MultiSearchResult, Error>) -> Void)> where M1.MatchedType == String, M2.MatchedType == Int, M3.MatchedType == (Result<MultiSearchResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int, (Result<MultiSearchResult, Error>) -> Void)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepositoryProtocol.self, method: "multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)", parameterMatchers: matchers))
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
	    func getSimilarMovies<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from movieId: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(Int, Int, (Result<MovieResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getSimilarMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRecommendMovies<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from movieId: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(Int, Int, (Result<MovieResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getRecommendMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<MovieResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieReview<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), [Review]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieReview(from: Int) -> [Review]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieCast<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), [Cast]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieCast(from: Int) -> [Cast]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieCrew<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), [Crew]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieCrew(from: Int) -> [Crew]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieKeywords<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), [Keyword]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieKeywords(from: Int) -> [Keyword]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movieId: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<MovieImages, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<MovieImages, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<MovieImages, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getMovieImages(from: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieImages<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), MovieImages?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieImages(from: Int) -> MovieImages?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieReleaseDates<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), ReleaseDateResults?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieReleaseDates(from: Int) -> ReleaseDateResults?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTrending<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(time: M1, type: M2, completion: M3) -> Cuckoo.__DoNotUse<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void), Void> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType, M3.MatchedType == (Result<TrendingResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularPeople<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<PeopleResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<PeopleResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PeopleResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPersonDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<People, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<People, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<People, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVCredits<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.__DoNotUse<(Int), TVCredit?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return cuckoo_manager.verify("getTVCredits(from: Int) -> TVCredit?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieCredits<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.__DoNotUse<(Int), MovieCredit?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return cuckoo_manager.verify("getMovieCredits(from: Int) -> MovieCredit?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPersonImageProfile<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.__DoNotUse<(Int), ImageProfile?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return cuckoo_manager.verify("getPersonImageProfile(from: Int) -> ImageProfile?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularOnTV<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<TVShowResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShowId: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<TVShow, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<TVShow, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<TVShow, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getTVShowDetail(from: Int, completion: @escaping (Result<TVShow, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowKeywords<M1: Cuckoo.Matchable>(from tvShowId: M1) -> Cuckoo.__DoNotUse<(Int), [Keyword]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: tvShowId) { $0 }]
	        return cuckoo_manager.verify("getTVShowKeywords(from: Int) -> [Keyword]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getSimilarTVShows<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(Int, Int, (Result<TVShowResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getSimilarTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRecommendTVShows<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(Int, Int, (Result<TVShowResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getRecommendTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func updateImageConfig() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("updateImageConfig()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func multiSearch<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(query: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(String, Int, (Result<MultiSearchResult, Error>) -> Void), Void> where M1.MatchedType == String, M2.MatchedType == Int, M3.MatchedType == (Result<MultiSearchResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int, (Result<MultiSearchResult, Error>) -> Void)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBRepositoryProtocolStub: TMDBRepositoryProtocol {
    

    

    
     func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getMovieReview(from movieId: Int) -> [Review]  {
        return DefaultValueRegistry.defaultValue(for: ([Review]).self)
    }
    
     func getMovieCast(from movieId: Int) -> [Cast]  {
        return DefaultValueRegistry.defaultValue(for: ([Cast]).self)
    }
    
     func getMovieCrew(from movieId: Int) -> [Crew]  {
        return DefaultValueRegistry.defaultValue(for: ([Crew]).self)
    }
    
     func getMovieKeywords(from movieId: Int) -> [Keyword]  {
        return DefaultValueRegistry.defaultValue(for: ([Keyword]).self)
    }
    
     func getMovieImages(from movieId: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getMovieImages(from movieId: Int) -> MovieImages?  {
        return DefaultValueRegistry.defaultValue(for: (MovieImages?).self)
    }
    
     func getMovieReleaseDates(from movieId: Int) -> ReleaseDateResults?  {
        return DefaultValueRegistry.defaultValue(for: (ReleaseDateResults?).self)
    }
    
     func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTVCredits(from personId: Int) -> TVCredit?  {
        return DefaultValueRegistry.defaultValue(for: (TVCredit?).self)
    }
    
     func getMovieCredits(from personId: Int) -> MovieCredit?  {
        return DefaultValueRegistry.defaultValue(for: (MovieCredit?).self)
    }
    
     func getPersonImageProfile(from personId: Int) -> ImageProfile?  {
        return DefaultValueRegistry.defaultValue(for: (ImageProfile?).self)
    }
    
     func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTVShowDetail(from tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTVShowKeywords(from tvShowId: Int) -> [Keyword]  {
        return DefaultValueRegistry.defaultValue(for: ([Keyword]).self)
    }
    
     func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func updateImageConfig()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)   {
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
    

    

    
    
    
     override func getMovieReleaseDates(from movieId: Int) -> ReleaseDateResults? {
        
    return cuckoo_manager.call("getMovieReleaseDates(from: Int) -> ReleaseDateResults?",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                super.getMovieReleaseDates(from: movieId)
                ,
            defaultCall: __defaultImplStub!.getMovieReleaseDates(from: movieId))
        
    }
    
    
    
     override func getMovieImages(from movieId: Int) -> MovieImages? {
        
    return cuckoo_manager.call("getMovieImages(from: Int) -> MovieImages?",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                super.getMovieImages(from: movieId)
                ,
            defaultCall: __defaultImplStub!.getMovieImages(from: movieId))
        
    }
    
    
    
     override func getMovieImages(from movieId: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)  {
        
    return cuckoo_manager.call("getMovieImages(from: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)",
            parameters: (movieId, completion),
            escapingParameters: (movieId, completion),
            superclassCall:
                
                super.getMovieImages(from: movieId, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getMovieImages(from: movieId, completion: completion))
        
    }
    
    
    
     override func getMovieKeywords(from movieId: Int) -> [Keyword] {
        
    return cuckoo_manager.call("getMovieKeywords(from: Int) -> [Keyword]",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                super.getMovieKeywords(from: movieId)
                ,
            defaultCall: __defaultImplStub!.getMovieKeywords(from: movieId))
        
    }
    
    
    
     override func getMovieCast(from movieId: Int) -> [Cast] {
        
    return cuckoo_manager.call("getMovieCast(from: Int) -> [Cast]",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                super.getMovieCast(from: movieId)
                ,
            defaultCall: __defaultImplStub!.getMovieCast(from: movieId))
        
    }
    
    
    
     override func getMovieCrew(from movieId: Int) -> [Crew] {
        
    return cuckoo_manager.call("getMovieCrew(from: Int) -> [Crew]",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                super.getMovieCrew(from: movieId)
                ,
            defaultCall: __defaultImplStub!.getMovieCrew(from: movieId))
        
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
    
    
    
     override func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getSimilarMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)",
            parameters: (movieId, page, completion),
            escapingParameters: (movieId, page, completion),
            superclassCall:
                
                super.getSimilarMovies(from: movieId, page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getSimilarMovies(from: movieId, page: page, completion: completion))
        
    }
    
    
    
     override func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getRecommendMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)",
            parameters: (movieId, page, completion),
            escapingParameters: (movieId, page, completion),
            superclassCall:
                
                super.getRecommendMovies(from: movieId, page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getRecommendMovies(from: movieId, page: page, completion: completion))
        
    }
    
    
    
     override func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                super.getPopularMovie(page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getPopularMovie(page: page, completion: completion))
        
    }
    
    
    
     override func getMovieReview(from movieId: Int) -> [Review] {
        
    return cuckoo_manager.call("getMovieReview(from: Int) -> [Review]",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                super.getMovieReview(from: movieId)
                ,
            defaultCall: __defaultImplStub!.getMovieReview(from: movieId))
        
    }
    
    
    
     override func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getSimilarTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)",
            parameters: (tvShowId, page, completion),
            escapingParameters: (tvShowId, page, completion),
            superclassCall:
                
                super.getSimilarTVShows(from: tvShowId, page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getSimilarTVShows(from: tvShowId, page: page, completion: completion))
        
    }
    
    
    
     override func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getRecommendTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)",
            parameters: (tvShowId, page, completion),
            escapingParameters: (tvShowId, page, completion),
            superclassCall:
                
                super.getRecommendTVShows(from: tvShowId, page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getRecommendTVShows(from: tvShowId, page: page, completion: completion))
        
    }
    
    
    
     override func getTVShowDetail(from tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void)  {
        
    return cuckoo_manager.call("getTVShowDetail(from: Int, completion: @escaping (Result<TVShow, Error>) -> Void)",
            parameters: (tvShowId, completion),
            escapingParameters: (tvShowId, completion),
            superclassCall:
                
                super.getTVShowDetail(from: tvShowId, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getTVShowDetail(from: tvShowId, completion: completion))
        
    }
    
    
    
     override func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                super.getPopularOnTV(page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getPopularOnTV(page: page, completion: completion))
        
    }
    
    
    
     override func getTVShowKeywords(from tvShowId: Int) -> [Keyword] {
        
    return cuckoo_manager.call("getTVShowKeywords(from: Int) -> [Keyword]",
            parameters: (tvShowId),
            escapingParameters: (tvShowId),
            superclassCall:
                
                super.getTVShowKeywords(from: tvShowId)
                ,
            defaultCall: __defaultImplStub!.getTVShowKeywords(from: tvShowId))
        
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
    
    
    
     override func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)",
            parameters: (page, completion),
            escapingParameters: (page, completion),
            superclassCall:
                
                super.getPopularPeople(page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getPopularPeople(page: page, completion: completion))
        
    }
    
    
    
     override func getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)  {
        
    return cuckoo_manager.call("getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)",
            parameters: (id, completion),
            escapingParameters: (id, completion),
            superclassCall:
                
                super.getPersonDetail(id: id, completion: completion)
                ,
            defaultCall: __defaultImplStub!.getPersonDetail(id: id, completion: completion))
        
    }
    
    
    
     override func getTVCredits(from personId: Int) -> TVCredit? {
        
    return cuckoo_manager.call("getTVCredits(from: Int) -> TVCredit?",
            parameters: (personId),
            escapingParameters: (personId),
            superclassCall:
                
                super.getTVCredits(from: personId)
                ,
            defaultCall: __defaultImplStub!.getTVCredits(from: personId))
        
    }
    
    
    
     override func getMovieCredits(from personId: Int) -> MovieCredit? {
        
    return cuckoo_manager.call("getMovieCredits(from: Int) -> MovieCredit?",
            parameters: (personId),
            escapingParameters: (personId),
            superclassCall:
                
                super.getMovieCredits(from: personId)
                ,
            defaultCall: __defaultImplStub!.getMovieCredits(from: personId))
        
    }
    
    
    
     override func getPersonImageProfile(from personId: Int) -> ImageProfile? {
        
    return cuckoo_manager.call("getPersonImageProfile(from: Int) -> ImageProfile?",
            parameters: (personId),
            escapingParameters: (personId),
            superclassCall:
                
                super.getPersonImageProfile(from: personId)
                ,
            defaultCall: __defaultImplStub!.getPersonImageProfile(from: personId))
        
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
    
    
    
     override func multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)  {
        
    return cuckoo_manager.call("multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)",
            parameters: (query, page, completion),
            escapingParameters: (query, page, completion),
            superclassCall:
                
                super.multiSearch(query: query, page: page, completion: completion)
                ,
            defaultCall: __defaultImplStub!.multiSearch(query: query, page: page, completion: completion))
        
    }
    

	 struct __StubbingProxy_TMDBRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var userSetting: Cuckoo.ClassToBeStubbedProperty<MockTMDBRepository, TMDBUserSettingProtocol> {
	        return .init(manager: cuckoo_manager, name: "userSetting")
	    }
	    
	    
	    func getMovieReleaseDates<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ClassStubFunction<(Int), ReleaseDateResults?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieReleaseDates(from: Int) -> ReleaseDateResults?", parameterMatchers: matchers))
	    }
	    
	    func getMovieImages<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ClassStubFunction<(Int), MovieImages?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieImages(from: Int) -> MovieImages?", parameterMatchers: matchers))
	    }
	    
	    func getMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movieId: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<MovieImages, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<MovieImages, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<MovieImages, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieImages(from: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getMovieKeywords<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ClassStubFunction<(Int), [Keyword]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieKeywords(from: Int) -> [Keyword]", parameterMatchers: matchers))
	    }
	    
	    func getMovieCast<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ClassStubFunction<(Int), [Cast]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieCast(from: Int) -> [Cast]", parameterMatchers: matchers))
	    }
	    
	    func getMovieCrew<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ClassStubFunction<(Int), [Crew]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieCrew(from: Int) -> [Crew]", parameterMatchers: matchers))
	    }
	    
	    func getMovieDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<Movie, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<Movie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<Movie, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getSimilarMovies<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from movieId: M1, page: M2, completion: M3) -> Cuckoo.ClassStubNoReturnFunction<(Int, Int, (Result<MovieResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getSimilarMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getRecommendMovies<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from movieId: M1, page: M2, completion: M3) -> Cuckoo.ClassStubNoReturnFunction<(Int, Int, (Result<MovieResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getRecommendMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<MovieResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getMovieReview<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ClassStubFunction<(Int), [Review]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieReview(from: Int) -> [Review]", parameterMatchers: matchers))
	    }
	    
	    func getSimilarTVShows<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, page: M2, completion: M3) -> Cuckoo.ClassStubNoReturnFunction<(Int, Int, (Result<TVShowResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getSimilarTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getRecommendTVShows<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, page: M2, completion: M3) -> Cuckoo.ClassStubNoReturnFunction<(Int, Int, (Result<TVShowResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getRecommendTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getTVShowDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShowId: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<TVShow, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<TVShow, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<TVShow, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getTVShowDetail(from: Int, completion: @escaping (Result<TVShow, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularOnTV<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<TVShowResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getTVShowKeywords<M1: Cuckoo.Matchable>(from tvShowId: M1) -> Cuckoo.ClassStubFunction<(Int), [Keyword]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: tvShowId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getTVShowKeywords(from: Int) -> [Keyword]", parameterMatchers: matchers))
	    }
	    
	    func getTrending<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(time: M1, type: M2, completion: M3) -> Cuckoo.ClassStubNoReturnFunction<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType, M3.MatchedType == (Result<TrendingResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPopularPeople<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<PeopleResult, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<PeopleResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PeopleResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getPersonDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.ClassStubNoReturnFunction<(Int, (Result<People, Error>) -> Void)> where M1.MatchedType == Int, M2.MatchedType == (Result<People, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<People, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)", parameterMatchers: matchers))
	    }
	    
	    func getTVCredits<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.ClassStubFunction<(Int), TVCredit?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getTVCredits(from: Int) -> TVCredit?", parameterMatchers: matchers))
	    }
	    
	    func getMovieCredits<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.ClassStubFunction<(Int), MovieCredit?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getMovieCredits(from: Int) -> MovieCredit?", parameterMatchers: matchers))
	    }
	    
	    func getPersonImageProfile<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.ClassStubFunction<(Int), ImageProfile?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "getPersonImageProfile(from: Int) -> ImageProfile?", parameterMatchers: matchers))
	    }
	    
	    func updateImageConfig() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "updateImageConfig()", parameterMatchers: matchers))
	    }
	    
	    func multiSearch<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(query: M1, page: M2, completion: M3) -> Cuckoo.ClassStubNoReturnFunction<(String, Int, (Result<MultiSearchResult, Error>) -> Void)> where M1.MatchedType == String, M2.MatchedType == Int, M3.MatchedType == (Result<MultiSearchResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int, (Result<MultiSearchResult, Error>) -> Void)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBRepository.self, method: "multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)", parameterMatchers: matchers))
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
	    func getMovieReleaseDates<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), ReleaseDateResults?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieReleaseDates(from: Int) -> ReleaseDateResults?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieImages<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), MovieImages?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieImages(from: Int) -> MovieImages?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movieId: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<MovieImages, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<MovieImages, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<MovieImages, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getMovieImages(from: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieKeywords<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), [Keyword]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieKeywords(from: Int) -> [Keyword]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieCast<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), [Cast]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieCast(from: Int) -> [Cast]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieCrew<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), [Crew]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieCrew(from: Int) -> [Crew]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<Movie, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<Movie, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<Movie, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getSimilarMovies<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from movieId: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(Int, Int, (Result<MovieResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getSimilarMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRecommendMovies<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from movieId: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(Int, Int, (Result<MovieResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getRecommendMovies(from: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<MovieResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<MovieResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<MovieResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieReview<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), [Review]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieReview(from: Int) -> [Review]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getSimilarTVShows<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(Int, Int, (Result<TVShowResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getSimilarTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRecommendTVShows<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(Int, Int, (Result<TVShowResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getRecommendTVShows(from: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShowId: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<TVShow, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<TVShow, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<TVShow, Error>) -> Void)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getTVShowDetail(from: Int, completion: @escaping (Result<TVShow, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularOnTV<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<TVShowResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<TVShowResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<TVShowResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowKeywords<M1: Cuckoo.Matchable>(from tvShowId: M1) -> Cuckoo.__DoNotUse<(Int), [Keyword]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: tvShowId) { $0 }]
	        return cuckoo_manager.verify("getTVShowKeywords(from: Int) -> [Keyword]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTrending<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(time: M1, type: M2, completion: M3) -> Cuckoo.__DoNotUse<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void), Void> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType, M3.MatchedType == (Result<TrendingResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType, (Result<TrendingResult, Error>) -> Void)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularPeople<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(page: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<PeopleResult, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<PeopleResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<PeopleResult, Error>) -> Void)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPersonDetail<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(id: M1, completion: M2) -> Cuckoo.__DoNotUse<(Int, (Result<People, Error>) -> Void), Void> where M1.MatchedType == Int, M2.MatchedType == (Result<People, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, (Result<People, Error>) -> Void)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVCredits<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.__DoNotUse<(Int), TVCredit?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return cuckoo_manager.verify("getTVCredits(from: Int) -> TVCredit?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieCredits<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.__DoNotUse<(Int), MovieCredit?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return cuckoo_manager.verify("getMovieCredits(from: Int) -> MovieCredit?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPersonImageProfile<M1: Cuckoo.Matchable>(from personId: M1) -> Cuckoo.__DoNotUse<(Int), ImageProfile?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: personId) { $0 }]
	        return cuckoo_manager.verify("getPersonImageProfile(from: Int) -> ImageProfile?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func updateImageConfig() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("updateImageConfig()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func multiSearch<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(query: M1, page: M2, completion: M3) -> Cuckoo.__DoNotUse<(String, Int, (Result<MultiSearchResult, Error>) -> Void), Void> where M1.MatchedType == String, M2.MatchedType == Int, M3.MatchedType == (Result<MultiSearchResult, Error>) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int, (Result<MultiSearchResult, Error>) -> Void)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: completion) { $0.2 }]
	        return cuckoo_manager.verify("multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    

    

    
     override func getMovieReleaseDates(from movieId: Int) -> ReleaseDateResults?  {
        return DefaultValueRegistry.defaultValue(for: (ReleaseDateResults?).self)
    }
    
     override func getMovieImages(from movieId: Int) -> MovieImages?  {
        return DefaultValueRegistry.defaultValue(for: (MovieImages?).self)
    }
    
     override func getMovieImages(from movieId: Int, completion: @escaping (Result<MovieImages, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getMovieKeywords(from movieId: Int) -> [Keyword]  {
        return DefaultValueRegistry.defaultValue(for: ([Keyword]).self)
    }
    
     override func getMovieCast(from movieId: Int) -> [Cast]  {
        return DefaultValueRegistry.defaultValue(for: ([Cast]).self)
    }
    
     override func getMovieCrew(from movieId: Int) -> [Crew]  {
        return DefaultValueRegistry.defaultValue(for: ([Crew]).self)
    }
    
     override func getMovieDetail(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getSimilarMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getRecommendMovies(from movieId: Int, page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPopularMovie(page: Int, completion: @escaping (Result<MovieResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getMovieReview(from movieId: Int) -> [Review]  {
        return DefaultValueRegistry.defaultValue(for: ([Review]).self)
    }
    
     override func getSimilarTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getRecommendTVShows(from tvShowId: Int, page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTVShowDetail(from tvShowId: Int, completion: @escaping (Result<TVShow, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPopularOnTV(page: Int, completion: @escaping (Result<TVShowResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTVShowKeywords(from tvShowId: Int) -> [Keyword]  {
        return DefaultValueRegistry.defaultValue(for: ([Keyword]).self)
    }
    
     override func getTrending(time: TrendingTime, type: TrendingMediaType, completion: @escaping (Result<TrendingResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPopularPeople(page: Int, completion: @escaping (Result<PeopleResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPersonDetail(id: Int, completion: @escaping (Result<People, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTVCredits(from personId: Int) -> TVCredit?  {
        return DefaultValueRegistry.defaultValue(for: (TVCredit?).self)
    }
    
     override func getMovieCredits(from personId: Int) -> MovieCredit?  {
        return DefaultValueRegistry.defaultValue(for: (MovieCredit?).self)
    }
    
     override func getPersonImageProfile(from personId: Int) -> ImageProfile?  {
        return DefaultValueRegistry.defaultValue(for: (ImageProfile?).self)
    }
    
     override func updateImageConfig()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func multiSearch(query: String, page: Int, completion: @escaping (Result<MultiSearchResult, Error>) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBSession.swift at 2020-07-23 21:32:10 +0000

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


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLRequestBuilder.swift at 2020-07-23 21:32:10 +0000

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
    

    

    

    
    
    
     func getPopularTVURLRequest(page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getPopularTVURLRequest(page: Int, language: String?) -> URLRequest",
            parameters: (page, language),
            escapingParameters: (page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularTVURLRequest(page: page, language: language))
        
    }
    
    
    
     func getTVShowDetailURLRequest(id: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getTVShowDetailURLRequest(id: Int, language: String?) -> URLRequest",
            parameters: (id, language),
            escapingParameters: (id, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowDetailURLRequest(id: id, language: language))
        
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
    
    
    
     func getPersonDetailURLRequest(id: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getPersonDetailURLRequest(id: Int, language: String?) -> URLRequest",
            parameters: (id, language),
            escapingParameters: (id, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPersonDetailURLRequest(id: id, language: language))
        
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
    
    
    
     func getImageConfigURLRequest() -> URLRequest {
        
    return cuckoo_manager.call("getImageConfigURLRequest() -> URLRequest",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getImageConfigURLRequest())
        
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
    
    
    
     func getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        
    return cuckoo_manager.call("getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest",
            parameters: (page, language, region),
            escapingParameters: (page, language, region),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getPopularMovieURLRequest(page: page, language: language, region: region))
        
    }
    
    
    
     func getSimilarMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getSimilarMoviesURLRequest(from: Int, page: Int, language: String?) -> URLRequest",
            parameters: (movieId, page, language),
            escapingParameters: (movieId, page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getSimilarMoviesURLRequest(from: movieId, page: page, language: language))
        
    }
    
    
    
     func getRecommendMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getRecommendMoviesURLRequest(from: Int, page: Int, language: String?) -> URLRequest",
            parameters: (movieId, page, language),
            escapingParameters: (movieId, page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getRecommendMoviesURLRequest(from: movieId, page: page, language: language))
        
    }
    
    
    
     func getMovieCreditURLRequest(from movieId: Int) -> URLRequest {
        
    return cuckoo_manager.call("getMovieCreditURLRequest(from: Int) -> URLRequest",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieCreditURLRequest(from: movieId))
        
    }
    
    
    
     func getMovieReviewURLRequest(from movieId: Int, page: Int) -> URLRequest {
        
    return cuckoo_manager.call("getMovieReviewURLRequest(from: Int, page: Int) -> URLRequest",
            parameters: (movieId, page),
            escapingParameters: (movieId, page),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieReviewURLRequest(from: movieId, page: page))
        
    }
    
    
    
     func getMovieImages(from movieId: Int) -> URLRequest {
        
    return cuckoo_manager.call("getMovieImages(from: Int) -> URLRequest",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieImages(from: movieId))
        
    }
    
    
    
     func getMultiSearchURLRequest(query: String, language: String?, region: String?, page: Int) -> URLRequest {
        
    return cuckoo_manager.call("getMultiSearchURLRequest(query: String, language: String?, region: String?, page: Int) -> URLRequest",
            parameters: (query, language, region, page),
            escapingParameters: (query, language, region, page),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMultiSearchURLRequest(query: query, language: language, region: region, page: page))
        
    }
    

	 struct __StubbingProxy_TMDBURLRequestBuilderProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getPopularTVURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getPopularTVURLRequest(page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTVShowDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(id: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTVShowDetailURLRequest(id: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getPopularPeopleURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getPersonDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(id: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getPersonDetailURLRequest(id: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTrendingURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(time: M1, type: M2) -> Cuckoo.ProtocolStubFunction<(TrendingTime, TrendingMediaType), URLRequest> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getImageConfigURLRequest() -> Cuckoo.ProtocolStubFunction<(), URLRequest> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getImageConfigURLRequest() -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getMovieDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(id: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getPopularMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.ProtocolStubFunction<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getSimilarMoviesURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(from movieId: M1, page: M2, language: M3) -> Cuckoo.ProtocolStubFunction<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getSimilarMoviesURLRequest(from: Int, page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getRecommendMoviesURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(from movieId: M1, page: M2, language: M3) -> Cuckoo.ProtocolStubFunction<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getRecommendMoviesURLRequest(from: Int, page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getMovieCreditURLRequest<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ProtocolStubFunction<(Int), URLRequest> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getMovieCreditURLRequest(from: Int) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getMovieReviewURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movieId: M1, page: M2) -> Cuckoo.ProtocolStubFunction<(Int, Int), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getMovieReviewURLRequest(from: Int, page: Int) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getMovieImages<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ProtocolStubFunction<(Int), URLRequest> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getMovieImages(from: Int) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getMultiSearchURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(query: M1, language: M2, region: M3, page: M4) -> Cuckoo.ProtocolStubFunction<(String, String?, String?, Int), URLRequest> where M1.MatchedType == String, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String?, String?, Int)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }, wrap(matchable: page) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getMultiSearchURLRequest(query: String, language: String?, region: String?, page: Int) -> URLRequest", parameterMatchers: matchers))
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
	    func getPopularTVURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getPopularTVURLRequest(page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(id: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getTVShowDetailURLRequest(id: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularPeopleURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPersonDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(id: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getPersonDetailURLRequest(id: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTrendingURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(time: M1, type: M2) -> Cuckoo.__DoNotUse<(TrendingTime, TrendingMediaType), URLRequest> where M1.MatchedType == TrendingTime, M2.MatchedType == TrendingMediaType {
	        let matchers: [Cuckoo.ParameterMatcher<(TrendingTime, TrendingMediaType)>] = [wrap(matchable: time) { $0.0 }, wrap(matchable: type) { $0.1 }]
	        return cuckoo_manager.verify("getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getImageConfigURLRequest() -> Cuckoo.__DoNotUse<(), URLRequest> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getImageConfigURLRequest() -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(id: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getPopularMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.__DoNotUse<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return cuckoo_manager.verify("getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getSimilarMoviesURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(from movieId: M1, page: M2, language: M3) -> Cuckoo.__DoNotUse<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return cuckoo_manager.verify("getSimilarMoviesURLRequest(from: Int, page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRecommendMoviesURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(from movieId: M1, page: M2, language: M3) -> Cuckoo.__DoNotUse<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return cuckoo_manager.verify("getRecommendMoviesURLRequest(from: Int, page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieCreditURLRequest<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), URLRequest> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieCreditURLRequest(from: Int) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieReviewURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from movieId: M1, page: M2) -> Cuckoo.__DoNotUse<(Int, Int), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: movieId) { $0.0 }, wrap(matchable: page) { $0.1 }]
	        return cuckoo_manager.verify("getMovieReviewURLRequest(from: Int, page: Int) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMovieImages<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), URLRequest> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieImages(from: Int) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMultiSearchURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable, M4: Cuckoo.Matchable>(query: M1, language: M2, region: M3, page: M4) -> Cuckoo.__DoNotUse<(String, String?, String?, Int), URLRequest> where M1.MatchedType == String, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String?, String?, Int)>] = [wrap(matchable: query) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }, wrap(matchable: page) { $0.3 }]
	        return cuckoo_manager.verify("getMultiSearchURLRequest(query: String, language: String?, region: String?, page: Int) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBURLRequestBuilderProtocolStub: TMDBURLRequestBuilderProtocol {
    

    

    
     func getPopularTVURLRequest(page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTVShowDetailURLRequest(id: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getPopularPeopleURLRequest(page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getPersonDetailURLRequest(id: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTrendingURLRequest(time: TrendingTime, type: TrendingMediaType) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getImageConfigURLRequest() -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getMovieDetailURLRequest(id: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getPopularMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getSimilarMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getRecommendMoviesURLRequest(from movieId: Int, page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getMovieCreditURLRequest(from movieId: Int) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getMovieReviewURLRequest(from movieId: Int, page: Int) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getMovieImages(from movieId: Int) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getMultiSearchURLRequest(query: String, language: String?, region: String?, page: Int) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLSessionDataTaskProtocol.swift at 2020-07-23 21:32:10 +0000

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


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLSessionProtocol.swift at 2020-07-23 21:32:10 +0000

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


// MARK: - Mocks generated from file: TMDB/TMDBUserSetting/TMDBUserSetting.swift at 2020-07-23 21:32:10 +0000

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
    

    

    
    
    
     func getImageURL(from path: String) -> URL? {
        
    return cuckoo_manager.call("getImageURL(from: String) -> URL?",
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getImageURL(from: path))
        
    }
    
    
    
     func getYoutubeImageURL(key: String) -> URL? {
        
    return cuckoo_manager.call("getYoutubeImageURL(key: String) -> URL?",
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getYoutubeImageURL(key: key))
        
    }
    
    
    
     func getYoutubeVideoURL(key: String) -> URL? {
        
    return cuckoo_manager.call("getYoutubeVideoURL(key: String) -> URL?",
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getYoutubeVideoURL(key: key))
        
    }
    

	 struct __StubbingProxy_TMDBUserSettingProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var imageConfig: Cuckoo.ProtocolToBeStubbedProperty<MockTMDBUserSettingProtocol, ImageConfigResult> {
	        return .init(manager: cuckoo_manager, name: "imageConfig")
	    }
	    
	    
	    var userDefault: Cuckoo.ProtocolToBeStubbedProperty<MockTMDBUserSettingProtocol, UserDefaults> {
	        return .init(manager: cuckoo_manager, name: "userDefault")
	    }
	    
	    
	    func getImageURL<M1: Cuckoo.Matchable>(from path: M1) -> Cuckoo.ProtocolStubFunction<(String), URL?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBUserSettingProtocol.self, method: "getImageURL(from: String) -> URL?", parameterMatchers: matchers))
	    }
	    
	    func getYoutubeImageURL<M1: Cuckoo.Matchable>(key: M1) -> Cuckoo.ProtocolStubFunction<(String), URL?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBUserSettingProtocol.self, method: "getYoutubeImageURL(key: String) -> URL?", parameterMatchers: matchers))
	    }
	    
	    func getYoutubeVideoURL<M1: Cuckoo.Matchable>(key: M1) -> Cuckoo.ProtocolStubFunction<(String), URL?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBUserSettingProtocol.self, method: "getYoutubeVideoURL(key: String) -> URL?", parameterMatchers: matchers))
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
	
	    
	    
	    var imageConfig: Cuckoo.VerifyProperty<ImageConfigResult> {
	        return .init(manager: cuckoo_manager, name: "imageConfig", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var userDefault: Cuckoo.VerifyProperty<UserDefaults> {
	        return .init(manager: cuckoo_manager, name: "userDefault", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func getImageURL<M1: Cuckoo.Matchable>(from path: M1) -> Cuckoo.__DoNotUse<(String), URL?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
	        return cuckoo_manager.verify("getImageURL(from: String) -> URL?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getYoutubeImageURL<M1: Cuckoo.Matchable>(key: M1) -> Cuckoo.__DoNotUse<(String), URL?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
	        return cuckoo_manager.verify("getYoutubeImageURL(key: String) -> URL?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getYoutubeVideoURL<M1: Cuckoo.Matchable>(key: M1) -> Cuckoo.__DoNotUse<(String), URL?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
	        return cuckoo_manager.verify("getYoutubeVideoURL(key: String) -> URL?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class TMDBUserSettingProtocolStub: TMDBUserSettingProtocol {
    
    
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
    

    

    
     func getImageURL(from path: String) -> URL?  {
        return DefaultValueRegistry.defaultValue(for: (URL?).self)
    }
    
     func getYoutubeImageURL(key: String) -> URL?  {
        return DefaultValueRegistry.defaultValue(for: (URL?).self)
    }
    
     func getYoutubeVideoURL(key: String) -> URL?  {
        return DefaultValueRegistry.defaultValue(for: (URL?).self)
    }
    
}

