// MARK: - Mocks generated from file: TMDB/TMDBLocalDataSource/TMDBLocalDataSource.swift at 2020-08-13 16:02:01 +0000

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
    
    
    
     func saveSimilarMovie(_ similarMovie: List<Movie>, to movieId: Int)  {
        
    return cuckoo_manager.call("saveSimilarMovie(_: List<Movie>, to: Int)",
            parameters: (similarMovie, movieId),
            escapingParameters: (similarMovie, movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveSimilarMovie(similarMovie, to: movieId))
        
    }
    
    
    
     func saveRecommendMovie(_ recommendMovie: List<Movie>, to movieId: Int)  {
        
    return cuckoo_manager.call("saveRecommendMovie(_: List<Movie>, to: Int)",
            parameters: (recommendMovie, movieId),
            escapingParameters: (recommendMovie, movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveRecommendMovie(recommendMovie, to: movieId))
        
    }
    
    
    
     func saveMovieImages(_ movieImages: ImageResult, to movieId: Int)  {
        
    return cuckoo_manager.call("saveMovieImages(_: ImageResult, to: Int)",
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
    
    
    
     func saveSimilarTVShow(_ similarTVShow: List<TVShow>, to tvShowId: Int)  {
        
    return cuckoo_manager.call("saveSimilarTVShow(_: List<TVShow>, to: Int)",
            parameters: (similarTVShow, tvShowId),
            escapingParameters: (similarTVShow, tvShowId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveSimilarTVShow(similarTVShow, to: tvShowId))
        
    }
    
    
    
     func saveRecommendTVShow(_ recommendTVShow: List<TVShow>, to tvShowId: Int)  {
        
    return cuckoo_manager.call("saveRecommendTVShow(_: List<TVShow>, to: Int)",
            parameters: (recommendTVShow, tvShowId),
            escapingParameters: (recommendTVShow, tvShowId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveRecommendTVShow(recommendTVShow, to: tvShowId))
        
    }
    
    
    
     func saveTVShowSeason(_ season: Season, to tvShowId: Int)  {
        
    return cuckoo_manager.call("saveTVShowSeason(_: Season, to: Int)",
            parameters: (season, tvShowId),
            escapingParameters: (season, tvShowId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveTVShowSeason(season, to: tvShowId))
        
    }
    
    
    
     func getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season? {
        
    return cuckoo_manager.call("getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season?",
            parameters: (tvShowId, seasonNumber),
            escapingParameters: (tvShowId, seasonNumber),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowSeason(tvShowId: tvShowId, seasonNumber: seasonNumber))
        
    }
    
    
    
     func saveTVShowImages(_ tvShowImages: ImageResult, to tvShowId: Int)  {
        
    return cuckoo_manager.call("saveTVShowImages(_: ImageResult, to: Int)",
            parameters: (tvShowImages, tvShowId),
            escapingParameters: (tvShowImages, tvShowId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveTVShowImages(tvShowImages, to: tvShowId))
        
    }
    
    
    
     func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> Episode? {
        
    return cuckoo_manager.call("getTVShowEpisode(from: Int, seasonNumber: Int, episodeNumber: Int) -> Episode?",
            parameters: (tvShowId, seasonNumber, episodeNumber),
            escapingParameters: (tvShowId, seasonNumber, episodeNumber),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber))
        
    }
    
    
    
     func saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)  {
        
    return cuckoo_manager.call("saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)",
            parameters: (tvShowId, seasonNumber, episode),
            escapingParameters: (tvShowId, seasonNumber, episode),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveTVShowEpisode(tvShowId: tvShowId, seasonNumber: seasonNumber, episode: episode))
        
    }
    
    
    
     func saveTVShowSeasonImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int)  {
        
    return cuckoo_manager.call("saveTVShowSeasonImage(_: ImageResult, to: Int, seasonNumber: Int)",
            parameters: (seasonImage, tvShowId, seasonNumber),
            escapingParameters: (seasonImage, tvShowId, seasonNumber),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveTVShowSeasonImage(seasonImage, to: tvShowId, seasonNumber: seasonNumber))
        
    }
    
    
    
     func saveTVShowEpisodeImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int, episodeNumber: Int)  {
        
    return cuckoo_manager.call("saveTVShowEpisodeImage(_: ImageResult, to: Int, seasonNumber: Int, episodeNumber: Int)",
            parameters: (seasonImage, tvShowId, seasonNumber, episodeNumber),
            escapingParameters: (seasonImage, tvShowId, seasonNumber, episodeNumber),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveTVShowEpisodeImage(seasonImage, to: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber))
        
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
	    
	    func saveSimilarMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarMovie: M1, to movieId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(List<Movie>, Int)> where M1.MatchedType == List<Movie>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Int)>] = [wrap(matchable: similarMovie) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveSimilarMovie(_: List<Movie>, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveRecommendMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendMovie: M1, to movieId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(List<Movie>, Int)> where M1.MatchedType == List<Movie>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Int)>] = [wrap(matchable: recommendMovie) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveRecommendMovie(_: List<Movie>, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movieImages: M1, to movieId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(ImageResult, Int)> where M1.MatchedType == ImageResult, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int)>] = [wrap(matchable: movieImages) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveMovieImages(_: ImageResult, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getTVShow(id: Int) -> TVShow?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShow<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(TVShow)> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveTVShow(_: TVShow)", parameterMatchers: matchers))
	    }
	    
	    func saveSimilarTVShow<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarTVShow: M1, to tvShowId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(List<TVShow>, Int)> where M1.MatchedType == List<TVShow>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>, Int)>] = [wrap(matchable: similarTVShow) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveSimilarTVShow(_: List<TVShow>, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveRecommendTVShow<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendTVShow: M1, to tvShowId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(List<TVShow>, Int)> where M1.MatchedType == List<TVShow>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>, Int)>] = [wrap(matchable: recommendTVShow) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveRecommendTVShow(_: List<TVShow>, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowSeason<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ season: M1, to tvShowId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Season, Int)> where M1.MatchedType == Season, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Season, Int)>] = [wrap(matchable: season) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveTVShowSeason(_: Season, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func getTVShowSeason<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(tvShowId: M1, seasonNumber: M2) -> Cuckoo.ProtocolStubFunction<(Int, Int), Season?> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tvShowImages: M1, to tvShowId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(ImageResult, Int)> where M1.MatchedType == ImageResult, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int)>] = [wrap(matchable: tvShowImages) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveTVShowImages(_: ImageResult, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func getTVShowEpisode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, seasonNumber: M2, episodeNumber: M3) -> Cuckoo.ProtocolStubFunction<(Int, Int, Int), Episode?> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episodeNumber) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "getTVShowEpisode(from: Int, seasonNumber: Int, episodeNumber: Int) -> Episode?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowEpisode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(tvShowId: M1, seasonNumber: M2, episode: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(Int, Int, Episode)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Episode {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Episode)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episode) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowSeasonImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ seasonImage: M1, to tvShowId: M2, seasonNumber: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(ImageResult, Int, Int)> where M1.MatchedType == ImageResult, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int, Int)>] = [wrap(matchable: seasonImage) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }, wrap(matchable: seasonNumber) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveTVShowSeasonImage(_: ImageResult, to: Int, seasonNumber: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowEpisodeImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(_ seasonImage: M1, to tvShowId: M2, seasonNumber: M3, episodeNumber: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(ImageResult, Int, Int, Int)> where M1.MatchedType == ImageResult, M2.MatchedType == Int, M3.MatchedType == Int, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int, Int, Int)>] = [wrap(matchable: seasonImage) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }, wrap(matchable: seasonNumber) { $0.2 }, wrap(matchable: episodeNumber) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSourceProtocol.self, method: "saveTVShowEpisodeImage(_: ImageResult, to: Int, seasonNumber: Int, episodeNumber: Int)", parameterMatchers: matchers))
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
	    func saveSimilarMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarMovie: M1, to movieId: M2) -> Cuckoo.__DoNotUse<(List<Movie>, Int), Void> where M1.MatchedType == List<Movie>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Int)>] = [wrap(matchable: similarMovie) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return cuckoo_manager.verify("saveSimilarMovie(_: List<Movie>, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveRecommendMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendMovie: M1, to movieId: M2) -> Cuckoo.__DoNotUse<(List<Movie>, Int), Void> where M1.MatchedType == List<Movie>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Int)>] = [wrap(matchable: recommendMovie) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return cuckoo_manager.verify("saveRecommendMovie(_: List<Movie>, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movieImages: M1, to movieId: M2) -> Cuckoo.__DoNotUse<(ImageResult, Int), Void> where M1.MatchedType == ImageResult, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int)>] = [wrap(matchable: movieImages) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return cuckoo_manager.verify("saveMovieImages(_: ImageResult, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
	    func saveSimilarTVShow<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarTVShow: M1, to tvShowId: M2) -> Cuckoo.__DoNotUse<(List<TVShow>, Int), Void> where M1.MatchedType == List<TVShow>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>, Int)>] = [wrap(matchable: similarTVShow) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return cuckoo_manager.verify("saveSimilarTVShow(_: List<TVShow>, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveRecommendTVShow<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendTVShow: M1, to tvShowId: M2) -> Cuckoo.__DoNotUse<(List<TVShow>, Int), Void> where M1.MatchedType == List<TVShow>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>, Int)>] = [wrap(matchable: recommendTVShow) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return cuckoo_manager.verify("saveRecommendTVShow(_: List<TVShow>, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowSeason<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ season: M1, to tvShowId: M2) -> Cuckoo.__DoNotUse<(Season, Int), Void> where M1.MatchedType == Season, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Season, Int)>] = [wrap(matchable: season) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return cuckoo_manager.verify("saveTVShowSeason(_: Season, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowSeason<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(tvShowId: M1, seasonNumber: M2) -> Cuckoo.__DoNotUse<(Int, Int), Season?> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }]
	        return cuckoo_manager.verify("getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tvShowImages: M1, to tvShowId: M2) -> Cuckoo.__DoNotUse<(ImageResult, Int), Void> where M1.MatchedType == ImageResult, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int)>] = [wrap(matchable: tvShowImages) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return cuckoo_manager.verify("saveTVShowImages(_: ImageResult, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowEpisode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, seasonNumber: M2, episodeNumber: M3) -> Cuckoo.__DoNotUse<(Int, Int, Int), Episode?> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episodeNumber) { $0.2 }]
	        return cuckoo_manager.verify("getTVShowEpisode(from: Int, seasonNumber: Int, episodeNumber: Int) -> Episode?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowEpisode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(tvShowId: M1, seasonNumber: M2, episode: M3) -> Cuckoo.__DoNotUse<(Int, Int, Episode), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Episode {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Episode)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episode) { $0.2 }]
	        return cuckoo_manager.verify("saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowSeasonImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ seasonImage: M1, to tvShowId: M2, seasonNumber: M3) -> Cuckoo.__DoNotUse<(ImageResult, Int, Int), Void> where M1.MatchedType == ImageResult, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int, Int)>] = [wrap(matchable: seasonImage) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }, wrap(matchable: seasonNumber) { $0.2 }]
	        return cuckoo_manager.verify("saveTVShowSeasonImage(_: ImageResult, to: Int, seasonNumber: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowEpisodeImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(_ seasonImage: M1, to tvShowId: M2, seasonNumber: M3, episodeNumber: M4) -> Cuckoo.__DoNotUse<(ImageResult, Int, Int, Int), Void> where M1.MatchedType == ImageResult, M2.MatchedType == Int, M3.MatchedType == Int, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int, Int, Int)>] = [wrap(matchable: seasonImage) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }, wrap(matchable: seasonNumber) { $0.2 }, wrap(matchable: episodeNumber) { $0.3 }]
	        return cuckoo_manager.verify("saveTVShowEpisodeImage(_: ImageResult, to: Int, seasonNumber: Int, episodeNumber: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    
     func saveSimilarMovie(_ similarMovie: List<Movie>, to movieId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveRecommendMovie(_ recommendMovie: List<Movie>, to movieId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveMovieImages(_ movieImages: ImageResult, to movieId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTVShow(id: Int) -> TVShow?  {
        return DefaultValueRegistry.defaultValue(for: (TVShow?).self)
    }
    
     func saveTVShow(_ tvShow: TVShow)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveSimilarTVShow(_ similarTVShow: List<TVShow>, to tvShowId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveRecommendTVShow(_ recommendTVShow: List<TVShow>, to tvShowId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveTVShowSeason(_ season: Season, to tvShowId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season?  {
        return DefaultValueRegistry.defaultValue(for: (Season?).self)
    }
    
     func saveTVShowImages(_ tvShowImages: ImageResult, to tvShowId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> Episode?  {
        return DefaultValueRegistry.defaultValue(for: (Episode?).self)
    }
    
     func saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveTVShowSeasonImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func saveTVShowEpisodeImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int, episodeNumber: Int)   {
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
    

    

    

    
    
    
     override func saveMovieImages(_ movieImages: ImageResult, to movieId: Int)  {
        
    return cuckoo_manager.call("saveMovieImages(_: ImageResult, to: Int)",
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
    
    
    
     override func saveSimilarMovie(_ similarMovie: List<Movie>, to movieId: Int)  {
        
    return cuckoo_manager.call("saveSimilarMovie(_: List<Movie>, to: Int)",
            parameters: (similarMovie, movieId),
            escapingParameters: (similarMovie, movieId),
            superclassCall:
                
                super.saveSimilarMovie(similarMovie, to: movieId)
                ,
            defaultCall: __defaultImplStub!.saveSimilarMovie(similarMovie, to: movieId))
        
    }
    
    
    
     override func saveRecommendMovie(_ recommendMovie: List<Movie>, to movieId: Int)  {
        
    return cuckoo_manager.call("saveRecommendMovie(_: List<Movie>, to: Int)",
            parameters: (recommendMovie, movieId),
            escapingParameters: (recommendMovie, movieId),
            superclassCall:
                
                super.saveRecommendMovie(recommendMovie, to: movieId)
                ,
            defaultCall: __defaultImplStub!.saveRecommendMovie(recommendMovie, to: movieId))
        
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
    
    
    
     override func saveSimilarTVShow(_ similarTVShow: List<TVShow>, to tvShowId: Int)  {
        
    return cuckoo_manager.call("saveSimilarTVShow(_: List<TVShow>, to: Int)",
            parameters: (similarTVShow, tvShowId),
            escapingParameters: (similarTVShow, tvShowId),
            superclassCall:
                
                super.saveSimilarTVShow(similarTVShow, to: tvShowId)
                ,
            defaultCall: __defaultImplStub!.saveSimilarTVShow(similarTVShow, to: tvShowId))
        
    }
    
    
    
     override func saveRecommendTVShow(_ recommendTVShow: List<TVShow>, to tvShowId: Int)  {
        
    return cuckoo_manager.call("saveRecommendTVShow(_: List<TVShow>, to: Int)",
            parameters: (recommendTVShow, tvShowId),
            escapingParameters: (recommendTVShow, tvShowId),
            superclassCall:
                
                super.saveRecommendTVShow(recommendTVShow, to: tvShowId)
                ,
            defaultCall: __defaultImplStub!.saveRecommendTVShow(recommendTVShow, to: tvShowId))
        
    }
    
    
    
     override func saveTVShowSeason(_ season: Season, to tvShowId: Int)  {
        
    return cuckoo_manager.call("saveTVShowSeason(_: Season, to: Int)",
            parameters: (season, tvShowId),
            escapingParameters: (season, tvShowId),
            superclassCall:
                
                super.saveTVShowSeason(season, to: tvShowId)
                ,
            defaultCall: __defaultImplStub!.saveTVShowSeason(season, to: tvShowId))
        
    }
    
    
    
     override func getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season? {
        
    return cuckoo_manager.call("getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season?",
            parameters: (tvShowId, seasonNumber),
            escapingParameters: (tvShowId, seasonNumber),
            superclassCall:
                
                super.getTVShowSeason(tvShowId: tvShowId, seasonNumber: seasonNumber)
                ,
            defaultCall: __defaultImplStub!.getTVShowSeason(tvShowId: tvShowId, seasonNumber: seasonNumber))
        
    }
    
    
    
     override func saveTVShowImages(_ tvShowImages: ImageResult, to tvShowId: Int)  {
        
    return cuckoo_manager.call("saveTVShowImages(_: ImageResult, to: Int)",
            parameters: (tvShowImages, tvShowId),
            escapingParameters: (tvShowImages, tvShowId),
            superclassCall:
                
                super.saveTVShowImages(tvShowImages, to: tvShowId)
                ,
            defaultCall: __defaultImplStub!.saveTVShowImages(tvShowImages, to: tvShowId))
        
    }
    
    
    
     override func saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)  {
        
    return cuckoo_manager.call("saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)",
            parameters: (tvShowId, seasonNumber, episode),
            escapingParameters: (tvShowId, seasonNumber, episode),
            superclassCall:
                
                super.saveTVShowEpisode(tvShowId: tvShowId, seasonNumber: seasonNumber, episode: episode)
                ,
            defaultCall: __defaultImplStub!.saveTVShowEpisode(tvShowId: tvShowId, seasonNumber: seasonNumber, episode: episode))
        
    }
    
    
    
     override func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> Episode? {
        
    return cuckoo_manager.call("getTVShowEpisode(from: Int, seasonNumber: Int, episodeNumber: Int) -> Episode?",
            parameters: (tvShowId, seasonNumber, episodeNumber),
            escapingParameters: (tvShowId, seasonNumber, episodeNumber),
            superclassCall:
                
                super.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
                ,
            defaultCall: __defaultImplStub!.getTVShowEpisode(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber))
        
    }
    
    
    
     override func saveTVShowSeasonImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int)  {
        
    return cuckoo_manager.call("saveTVShowSeasonImage(_: ImageResult, to: Int, seasonNumber: Int)",
            parameters: (seasonImage, tvShowId, seasonNumber),
            escapingParameters: (seasonImage, tvShowId, seasonNumber),
            superclassCall:
                
                super.saveTVShowSeasonImage(seasonImage, to: tvShowId, seasonNumber: seasonNumber)
                ,
            defaultCall: __defaultImplStub!.saveTVShowSeasonImage(seasonImage, to: tvShowId, seasonNumber: seasonNumber))
        
    }
    
    
    
     override func saveTVShowEpisodeImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int, episodeNumber: Int)  {
        
    return cuckoo_manager.call("saveTVShowEpisodeImage(_: ImageResult, to: Int, seasonNumber: Int, episodeNumber: Int)",
            parameters: (seasonImage, tvShowId, seasonNumber, episodeNumber),
            escapingParameters: (seasonImage, tvShowId, seasonNumber, episodeNumber),
            superclassCall:
                
                super.saveTVShowEpisodeImage(seasonImage, to: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber)
                ,
            defaultCall: __defaultImplStub!.saveTVShowEpisodeImage(seasonImage, to: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber))
        
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
	    
	    
	    func saveMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movieImages: M1, to movieId: M2) -> Cuckoo.ClassStubNoReturnFunction<(ImageResult, Int)> where M1.MatchedType == ImageResult, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int)>] = [wrap(matchable: movieImages) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveMovieImages(_: ImageResult, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func getMovie<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), Movie?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getMovie(id: Int) -> Movie?", parameterMatchers: matchers))
	    }
	    
	    func saveMovie<M1: Cuckoo.Matchable>(_ movie: M1) -> Cuckoo.ClassStubNoReturnFunction<(Movie)> where M1.MatchedType == Movie {
	        let matchers: [Cuckoo.ParameterMatcher<(Movie)>] = [wrap(matchable: movie) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveMovie(_: Movie)", parameterMatchers: matchers))
	    }
	    
	    func saveSimilarMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarMovie: M1, to movieId: M2) -> Cuckoo.ClassStubNoReturnFunction<(List<Movie>, Int)> where M1.MatchedType == List<Movie>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Int)>] = [wrap(matchable: similarMovie) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveSimilarMovie(_: List<Movie>, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveRecommendMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendMovie: M1, to movieId: M2) -> Cuckoo.ClassStubNoReturnFunction<(List<Movie>, Int)> where M1.MatchedType == List<Movie>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Int)>] = [wrap(matchable: recommendMovie) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveRecommendMovie(_: List<Movie>, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func getTVShow<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Int), TVShow?> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getTVShow(id: Int) -> TVShow?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShow<M1: Cuckoo.Matchable>(_ tvShow: M1) -> Cuckoo.ClassStubNoReturnFunction<(TVShow)> where M1.MatchedType == TVShow {
	        let matchers: [Cuckoo.ParameterMatcher<(TVShow)>] = [wrap(matchable: tvShow) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveTVShow(_: TVShow)", parameterMatchers: matchers))
	    }
	    
	    func saveSimilarTVShow<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarTVShow: M1, to tvShowId: M2) -> Cuckoo.ClassStubNoReturnFunction<(List<TVShow>, Int)> where M1.MatchedType == List<TVShow>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>, Int)>] = [wrap(matchable: similarTVShow) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveSimilarTVShow(_: List<TVShow>, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveRecommendTVShow<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendTVShow: M1, to tvShowId: M2) -> Cuckoo.ClassStubNoReturnFunction<(List<TVShow>, Int)> where M1.MatchedType == List<TVShow>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>, Int)>] = [wrap(matchable: recommendTVShow) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveRecommendTVShow(_: List<TVShow>, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowSeason<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ season: M1, to tvShowId: M2) -> Cuckoo.ClassStubNoReturnFunction<(Season, Int)> where M1.MatchedType == Season, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Season, Int)>] = [wrap(matchable: season) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveTVShowSeason(_: Season, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func getTVShowSeason<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(tvShowId: M1, seasonNumber: M2) -> Cuckoo.ClassStubFunction<(Int, Int), Season?> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tvShowImages: M1, to tvShowId: M2) -> Cuckoo.ClassStubNoReturnFunction<(ImageResult, Int)> where M1.MatchedType == ImageResult, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int)>] = [wrap(matchable: tvShowImages) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveTVShowImages(_: ImageResult, to: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowEpisode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(tvShowId: M1, seasonNumber: M2, episode: M3) -> Cuckoo.ClassStubNoReturnFunction<(Int, Int, Episode)> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Episode {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Episode)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episode) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)", parameterMatchers: matchers))
	    }
	    
	    func getTVShowEpisode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, seasonNumber: M2, episodeNumber: M3) -> Cuckoo.ClassStubFunction<(Int, Int, Int), Episode?> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episodeNumber) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "getTVShowEpisode(from: Int, seasonNumber: Int, episodeNumber: Int) -> Episode?", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowSeasonImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ seasonImage: M1, to tvShowId: M2, seasonNumber: M3) -> Cuckoo.ClassStubNoReturnFunction<(ImageResult, Int, Int)> where M1.MatchedType == ImageResult, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int, Int)>] = [wrap(matchable: seasonImage) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }, wrap(matchable: seasonNumber) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveTVShowSeasonImage(_: ImageResult, to: Int, seasonNumber: Int)", parameterMatchers: matchers))
	    }
	    
	    func saveTVShowEpisodeImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(_ seasonImage: M1, to tvShowId: M2, seasonNumber: M3, episodeNumber: M4) -> Cuckoo.ClassStubNoReturnFunction<(ImageResult, Int, Int, Int)> where M1.MatchedType == ImageResult, M2.MatchedType == Int, M3.MatchedType == Int, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int, Int, Int)>] = [wrap(matchable: seasonImage) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }, wrap(matchable: seasonNumber) { $0.2 }, wrap(matchable: episodeNumber) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBLocalDataSource.self, method: "saveTVShowEpisodeImage(_: ImageResult, to: Int, seasonNumber: Int, episodeNumber: Int)", parameterMatchers: matchers))
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
	    func saveMovieImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ movieImages: M1, to movieId: M2) -> Cuckoo.__DoNotUse<(ImageResult, Int), Void> where M1.MatchedType == ImageResult, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int)>] = [wrap(matchable: movieImages) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return cuckoo_manager.verify("saveMovieImages(_: ImageResult, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
	    func saveSimilarMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarMovie: M1, to movieId: M2) -> Cuckoo.__DoNotUse<(List<Movie>, Int), Void> where M1.MatchedType == List<Movie>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Int)>] = [wrap(matchable: similarMovie) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return cuckoo_manager.verify("saveSimilarMovie(_: List<Movie>, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveRecommendMovie<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendMovie: M1, to movieId: M2) -> Cuckoo.__DoNotUse<(List<Movie>, Int), Void> where M1.MatchedType == List<Movie>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<Movie>, Int)>] = [wrap(matchable: recommendMovie) { $0.0 }, wrap(matchable: movieId) { $0.1 }]
	        return cuckoo_manager.verify("saveRecommendMovie(_: List<Movie>, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
	    func saveSimilarTVShow<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ similarTVShow: M1, to tvShowId: M2) -> Cuckoo.__DoNotUse<(List<TVShow>, Int), Void> where M1.MatchedType == List<TVShow>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>, Int)>] = [wrap(matchable: similarTVShow) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return cuckoo_manager.verify("saveSimilarTVShow(_: List<TVShow>, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveRecommendTVShow<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ recommendTVShow: M1, to tvShowId: M2) -> Cuckoo.__DoNotUse<(List<TVShow>, Int), Void> where M1.MatchedType == List<TVShow>, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(List<TVShow>, Int)>] = [wrap(matchable: recommendTVShow) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return cuckoo_manager.verify("saveRecommendTVShow(_: List<TVShow>, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowSeason<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ season: M1, to tvShowId: M2) -> Cuckoo.__DoNotUse<(Season, Int), Void> where M1.MatchedType == Season, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Season, Int)>] = [wrap(matchable: season) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return cuckoo_manager.verify("saveTVShowSeason(_: Season, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowSeason<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(tvShowId: M1, seasonNumber: M2) -> Cuckoo.__DoNotUse<(Int, Int), Season?> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }]
	        return cuckoo_manager.verify("getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowImages<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tvShowImages: M1, to tvShowId: M2) -> Cuckoo.__DoNotUse<(ImageResult, Int), Void> where M1.MatchedType == ImageResult, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int)>] = [wrap(matchable: tvShowImages) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }]
	        return cuckoo_manager.verify("saveTVShowImages(_: ImageResult, to: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowEpisode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(tvShowId: M1, seasonNumber: M2, episode: M3) -> Cuckoo.__DoNotUse<(Int, Int, Episode), Void> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Episode {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Episode)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episode) { $0.2 }]
	        return cuckoo_manager.verify("saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowEpisode<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, seasonNumber: M2, episodeNumber: M3) -> Cuckoo.__DoNotUse<(Int, Int, Int), Episode?> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episodeNumber) { $0.2 }]
	        return cuckoo_manager.verify("getTVShowEpisode(from: Int, seasonNumber: Int, episodeNumber: Int) -> Episode?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowSeasonImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(_ seasonImage: M1, to tvShowId: M2, seasonNumber: M3) -> Cuckoo.__DoNotUse<(ImageResult, Int, Int), Void> where M1.MatchedType == ImageResult, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int, Int)>] = [wrap(matchable: seasonImage) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }, wrap(matchable: seasonNumber) { $0.2 }]
	        return cuckoo_manager.verify("saveTVShowSeasonImage(_: ImageResult, to: Int, seasonNumber: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveTVShowEpisodeImage<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(_ seasonImage: M1, to tvShowId: M2, seasonNumber: M3, episodeNumber: M4) -> Cuckoo.__DoNotUse<(ImageResult, Int, Int, Int), Void> where M1.MatchedType == ImageResult, M2.MatchedType == Int, M3.MatchedType == Int, M4.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(ImageResult, Int, Int, Int)>] = [wrap(matchable: seasonImage) { $0.0 }, wrap(matchable: tvShowId) { $0.1 }, wrap(matchable: seasonNumber) { $0.2 }, wrap(matchable: episodeNumber) { $0.3 }]
	        return cuckoo_manager.verify("saveTVShowEpisodeImage(_: ImageResult, to: Int, seasonNumber: Int, episodeNumber: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    

    

    
     override func saveMovieImages(_ movieImages: ImageResult, to movieId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getMovie(id: Int) -> Movie?  {
        return DefaultValueRegistry.defaultValue(for: (Movie?).self)
    }
    
     override func saveMovie(_ movie: Movie)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveSimilarMovie(_ similarMovie: List<Movie>, to movieId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveRecommendMovie(_ recommendMovie: List<Movie>, to movieId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTVShow(id: Int) -> TVShow?  {
        return DefaultValueRegistry.defaultValue(for: (TVShow?).self)
    }
    
     override func saveTVShow(_ tvShow: TVShow)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveSimilarTVShow(_ similarTVShow: List<TVShow>, to tvShowId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveRecommendTVShow(_ recommendTVShow: List<TVShow>, to tvShowId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveTVShowSeason(_ season: Season, to tvShowId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTVShowSeason(tvShowId: Int, seasonNumber: Int) -> Season?  {
        return DefaultValueRegistry.defaultValue(for: (Season?).self)
    }
    
     override func saveTVShowImages(_ tvShowImages: ImageResult, to tvShowId: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveTVShowEpisode(tvShowId: Int, seasonNumber: Int, episode: Episode)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getTVShowEpisode(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> Episode?  {
        return DefaultValueRegistry.defaultValue(for: (Episode?).self)
    }
    
     override func saveTVShowSeasonImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func saveTVShowEpisodeImage(_ seasonImage: ImageResult, to tvShowId: Int, seasonNumber: Int, episodeNumber: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getPerson(id: Int) -> People?  {
        return DefaultValueRegistry.defaultValue(for: (People?).self)
    }
    
     override func savePerson(_ person: People)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBRepository/TMDBRepository.swift at 2020-08-13 16:02:01 +0000

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
import RealmSwift

// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBSession.swift at 2020-08-13 16:02:01 +0000

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


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLRequestBuilder.swift at 2020-08-13 16:02:01 +0000

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
    
    
    
     func getSimilarTVShowsURLRequest(from tvShowId: Int, page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getSimilarTVShowsURLRequest(from: Int, page: Int, language: String?) -> URLRequest",
            parameters: (tvShowId, page, language),
            escapingParameters: (tvShowId, page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getSimilarTVShowsURLRequest(from: tvShowId, page: page, language: language))
        
    }
    
    
    
     func getRecommendTVShowURLRequest(from tvShowId: Int, page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getRecommendTVShowURLRequest(from: Int, page: Int, language: String?) -> URLRequest",
            parameters: (tvShowId, page, language),
            escapingParameters: (tvShowId, page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getRecommendTVShowURLRequest(from: tvShowId, page: page, language: language))
        
    }
    
    
    
     func getTVShowSeasonDetailURLRequest(tvShowId: Int, seasonNumber: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getTVShowSeasonDetailURLRequest(tvShowId: Int, seasonNumber: Int, language: String?) -> URLRequest",
            parameters: (tvShowId, seasonNumber, language),
            escapingParameters: (tvShowId, seasonNumber, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowSeasonDetailURLRequest(tvShowId: tvShowId, seasonNumber: seasonNumber, language: language))
        
    }
    
    
    
     func getTVShowImagesURLRequest(from tvShowId: Int) -> URLRequest {
        
    return cuckoo_manager.call("getTVShowImagesURLRequest(from: Int) -> URLRequest",
            parameters: (tvShowId),
            escapingParameters: (tvShowId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowImagesURLRequest(from: tvShowId))
        
    }
    
    
    
     func getTVShowEpisodeURLRequest(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getTVShowEpisodeURLRequest(from: Int, seasonNumber: Int, episodeNumber: Int, language: String?) -> URLRequest",
            parameters: (tvShowId, seasonNumber, episodeNumber, language),
            escapingParameters: (tvShowId, seasonNumber, episodeNumber, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowEpisodeURLRequest(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber, language: language))
        
    }
    
    
    
     func getTVShowSeasonImageURLRequest(from tvShowId: Int, seasonNumber: Int) -> URLRequest {
        
    return cuckoo_manager.call("getTVShowSeasonImageURLRequest(from: Int, seasonNumber: Int) -> URLRequest",
            parameters: (tvShowId, seasonNumber),
            escapingParameters: (tvShowId, seasonNumber),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowSeasonImageURLRequest(from: tvShowId, seasonNumber: seasonNumber))
        
    }
    
    
    
     func getTVShowEpisodeImageURLRequest(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> URLRequest {
        
    return cuckoo_manager.call("getTVShowEpisodeImageURLRequest(from: Int, seasonNumber: Int, episodeNumber: Int) -> URLRequest",
            parameters: (tvShowId, seasonNumber, episodeNumber),
            escapingParameters: (tvShowId, seasonNumber, episodeNumber),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowEpisodeImageURLRequest(from: tvShowId, seasonNumber: seasonNumber, episodeNumber: episodeNumber))
        
    }
    
    
    
     func getTVShowOnTheAirURLRequest(page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getTVShowOnTheAirURLRequest(page: Int, language: String?) -> URLRequest",
            parameters: (page, language),
            escapingParameters: (page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowOnTheAirURLRequest(page: page, language: language))
        
    }
    
    
    
     func getTVShowAiringTodayURLRequest(page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getTVShowAiringTodayURLRequest(page: Int, language: String?) -> URLRequest",
            parameters: (page, language),
            escapingParameters: (page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTVShowAiringTodayURLRequest(page: page, language: language))
        
    }
    
    
    
     func getTopRatedTVShowURLRequest(page: Int, language: String?) -> URLRequest {
        
    return cuckoo_manager.call("getTopRatedTVShowURLRequest(page: Int, language: String?) -> URLRequest",
            parameters: (page, language),
            escapingParameters: (page, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTopRatedTVShowURLRequest(page: page, language: language))
        
    }
    
    
    
     func getAllTVShowURLRequest(query: DiscoverQuery) -> URLRequest {
        
    return cuckoo_manager.call("getAllTVShowURLRequest(query: DiscoverQuery) -> URLRequest",
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getAllTVShowURLRequest(query: query))
        
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
    
    
    
     func getMovieImagesURLRequest(from movieId: Int) -> URLRequest {
        
    return cuckoo_manager.call("getMovieImagesURLRequest(from: Int) -> URLRequest",
            parameters: (movieId),
            escapingParameters: (movieId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMovieImagesURLRequest(from: movieId))
        
    }
    
    
    
     func getNowPlayingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        
    return cuckoo_manager.call("getNowPlayingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest",
            parameters: (page, language, region),
            escapingParameters: (page, language, region),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getNowPlayingMovieURLRequest(page: page, language: language, region: region))
        
    }
    
    
    
     func getTopRateMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        
    return cuckoo_manager.call("getTopRateMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest",
            parameters: (page, language, region),
            escapingParameters: (page, language, region),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTopRateMovieURLRequest(page: page, language: language, region: region))
        
    }
    
    
    
     func getUpcomingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest {
        
    return cuckoo_manager.call("getUpcomingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest",
            parameters: (page, language, region),
            escapingParameters: (page, language, region),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getUpcomingMovieURLRequest(page: page, language: language, region: region))
        
    }
    
    
    
     func getAllMovieURLRequest(query: DiscoverQuery) -> URLRequest {
        
    return cuckoo_manager.call("getAllMovieURLRequest(query: DiscoverQuery) -> URLRequest",
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getAllMovieURLRequest(query: query))
        
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
	    
	    func getSimilarTVShowsURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(from tvShowId: M1, page: M2, language: M3) -> Cuckoo.ProtocolStubFunction<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getSimilarTVShowsURLRequest(from: Int, page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getRecommendTVShowURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(from tvShowId: M1, page: M2, language: M3) -> Cuckoo.ProtocolStubFunction<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getRecommendTVShowURLRequest(from: Int, page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTVShowSeasonDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(tvShowId: M1, seasonNumber: M2, language: M3) -> Cuckoo.ProtocolStubFunction<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTVShowSeasonDetailURLRequest(tvShowId: Int, seasonNumber: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTVShowImagesURLRequest<M1: Cuckoo.Matchable>(from tvShowId: M1) -> Cuckoo.ProtocolStubFunction<(Int), URLRequest> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: tvShowId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTVShowImagesURLRequest(from: Int) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTVShowEpisodeURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from tvShowId: M1, seasonNumber: M2, episodeNumber: M3, language: M4) -> Cuckoo.ProtocolStubFunction<(Int, Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Int, M4.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Int, String?)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episodeNumber) { $0.2 }, wrap(matchable: language) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTVShowEpisodeURLRequest(from: Int, seasonNumber: Int, episodeNumber: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTVShowSeasonImageURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShowId: M1, seasonNumber: M2) -> Cuckoo.ProtocolStubFunction<(Int, Int), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTVShowSeasonImageURLRequest(from: Int, seasonNumber: Int) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTVShowEpisodeImageURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, seasonNumber: M2, episodeNumber: M3) -> Cuckoo.ProtocolStubFunction<(Int, Int, Int), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episodeNumber) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTVShowEpisodeImageURLRequest(from: Int, seasonNumber: Int, episodeNumber: Int) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTVShowOnTheAirURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTVShowOnTheAirURLRequest(page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTVShowAiringTodayURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTVShowAiringTodayURLRequest(page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTopRatedTVShowURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTopRatedTVShowURLRequest(page: Int, language: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getAllTVShowURLRequest<M1: Cuckoo.Matchable>(query: M1) -> Cuckoo.ProtocolStubFunction<(DiscoverQuery), URLRequest> where M1.MatchedType == DiscoverQuery {
	        let matchers: [Cuckoo.ParameterMatcher<(DiscoverQuery)>] = [wrap(matchable: query) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getAllTVShowURLRequest(query: DiscoverQuery) -> URLRequest", parameterMatchers: matchers))
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
	    
	    func getMovieImagesURLRequest<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.ProtocolStubFunction<(Int), URLRequest> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getMovieImagesURLRequest(from: Int) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getNowPlayingMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.ProtocolStubFunction<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getNowPlayingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getTopRateMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.ProtocolStubFunction<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getTopRateMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getUpcomingMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.ProtocolStubFunction<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getUpcomingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", parameterMatchers: matchers))
	    }
	    
	    func getAllMovieURLRequest<M1: Cuckoo.Matchable>(query: M1) -> Cuckoo.ProtocolStubFunction<(DiscoverQuery), URLRequest> where M1.MatchedType == DiscoverQuery {
	        let matchers: [Cuckoo.ParameterMatcher<(DiscoverQuery)>] = [wrap(matchable: query) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTMDBURLRequestBuilderProtocol.self, method: "getAllMovieURLRequest(query: DiscoverQuery) -> URLRequest", parameterMatchers: matchers))
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
	    func getSimilarTVShowsURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(from tvShowId: M1, page: M2, language: M3) -> Cuckoo.__DoNotUse<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return cuckoo_manager.verify("getSimilarTVShowsURLRequest(from: Int, page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRecommendTVShowURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(from tvShowId: M1, page: M2, language: M3) -> Cuckoo.__DoNotUse<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: page) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return cuckoo_manager.verify("getRecommendTVShowURLRequest(from: Int, page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowSeasonDetailURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(tvShowId: M1, seasonNumber: M2, language: M3) -> Cuckoo.__DoNotUse<(Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, String?)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: language) { $0.2 }]
	        return cuckoo_manager.verify("getTVShowSeasonDetailURLRequest(tvShowId: Int, seasonNumber: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowImagesURLRequest<M1: Cuckoo.Matchable>(from tvShowId: M1) -> Cuckoo.__DoNotUse<(Int), URLRequest> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: tvShowId) { $0 }]
	        return cuckoo_manager.verify("getTVShowImagesURLRequest(from: Int) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowEpisodeURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(from tvShowId: M1, seasonNumber: M2, episodeNumber: M3, language: M4) -> Cuckoo.__DoNotUse<(Int, Int, Int, String?), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Int, M4.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Int, String?)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episodeNumber) { $0.2 }, wrap(matchable: language) { $0.3 }]
	        return cuckoo_manager.verify("getTVShowEpisodeURLRequest(from: Int, seasonNumber: Int, episodeNumber: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowSeasonImageURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from tvShowId: M1, seasonNumber: M2) -> Cuckoo.__DoNotUse<(Int, Int), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }]
	        return cuckoo_manager.verify("getTVShowSeasonImageURLRequest(from: Int, seasonNumber: Int) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowEpisodeImageURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from tvShowId: M1, seasonNumber: M2, episodeNumber: M3) -> Cuckoo.__DoNotUse<(Int, Int, Int), URLRequest> where M1.MatchedType == Int, M2.MatchedType == Int, M3.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, Int, Int)>] = [wrap(matchable: tvShowId) { $0.0 }, wrap(matchable: seasonNumber) { $0.1 }, wrap(matchable: episodeNumber) { $0.2 }]
	        return cuckoo_manager.verify("getTVShowEpisodeImageURLRequest(from: Int, seasonNumber: Int, episodeNumber: Int) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowOnTheAirURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getTVShowOnTheAirURLRequest(page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTVShowAiringTodayURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getTVShowAiringTodayURLRequest(page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTopRatedTVShowURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(page: M1, language: M2) -> Cuckoo.__DoNotUse<(Int, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getTopRatedTVShowURLRequest(page: Int, language: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getAllTVShowURLRequest<M1: Cuckoo.Matchable>(query: M1) -> Cuckoo.__DoNotUse<(DiscoverQuery), URLRequest> where M1.MatchedType == DiscoverQuery {
	        let matchers: [Cuckoo.ParameterMatcher<(DiscoverQuery)>] = [wrap(matchable: query) { $0 }]
	        return cuckoo_manager.verify("getAllTVShowURLRequest(query: DiscoverQuery) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
	    func getMovieImagesURLRequest<M1: Cuckoo.Matchable>(from movieId: M1) -> Cuckoo.__DoNotUse<(Int), URLRequest> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: movieId) { $0 }]
	        return cuckoo_manager.verify("getMovieImagesURLRequest(from: Int) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getNowPlayingMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.__DoNotUse<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return cuckoo_manager.verify("getNowPlayingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTopRateMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.__DoNotUse<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return cuckoo_manager.verify("getTopRateMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getUpcomingMovieURLRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.OptionalMatchable>(page: M1, language: M2, region: M3) -> Cuckoo.__DoNotUse<(Int, String?, String?), URLRequest> where M1.MatchedType == Int, M2.OptionalMatchedType == String, M3.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Int, String?, String?)>] = [wrap(matchable: page) { $0.0 }, wrap(matchable: language) { $0.1 }, wrap(matchable: region) { $0.2 }]
	        return cuckoo_manager.verify("getUpcomingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getAllMovieURLRequest<M1: Cuckoo.Matchable>(query: M1) -> Cuckoo.__DoNotUse<(DiscoverQuery), URLRequest> where M1.MatchedType == DiscoverQuery {
	        let matchers: [Cuckoo.ParameterMatcher<(DiscoverQuery)>] = [wrap(matchable: query) { $0 }]
	        return cuckoo_manager.verify("getAllMovieURLRequest(query: DiscoverQuery) -> URLRequest", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    
     func getSimilarTVShowsURLRequest(from tvShowId: Int, page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getRecommendTVShowURLRequest(from tvShowId: Int, page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTVShowSeasonDetailURLRequest(tvShowId: Int, seasonNumber: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTVShowImagesURLRequest(from tvShowId: Int) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTVShowEpisodeURLRequest(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTVShowSeasonImageURLRequest(from tvShowId: Int, seasonNumber: Int) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTVShowEpisodeImageURLRequest(from tvShowId: Int, seasonNumber: Int, episodeNumber: Int) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTVShowOnTheAirURLRequest(page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTVShowAiringTodayURLRequest(page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTopRatedTVShowURLRequest(page: Int, language: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getAllTVShowURLRequest(query: DiscoverQuery) -> URLRequest  {
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
    
     func getMovieImagesURLRequest(from movieId: Int) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getNowPlayingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getTopRateMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getUpcomingMovieURLRequest(page: Int, language: String?, region: String?) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getAllMovieURLRequest(query: DiscoverQuery) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
     func getMultiSearchURLRequest(query: String, language: String?, region: String?, page: Int) -> URLRequest  {
        return DefaultValueRegistry.defaultValue(for: (URLRequest).self)
    }
    
}


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLSessionDataTaskProtocol.swift at 2020-08-13 16:02:01 +0000

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


// MARK: - Mocks generated from file: TMDB/TMDBServices/TMDBURLSessionProtocol.swift at 2020-08-13 16:02:01 +0000

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


// MARK: - Mocks generated from file: TMDB/TMDBUserSetting/TMDBUserSetting.swift at 2020-08-13 16:02:01 +0000

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
    
    
    
     var countriesCode: [CountryCode] {
        get {
            return cuckoo_manager.getter("countriesCode",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.countriesCode)
        }
        
    }
    
    
    
     var languagesCode: [LanguageCode] {
        get {
            return cuckoo_manager.getter("languagesCode",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.languagesCode)
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
	    
	    
	    var imageConfig: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTMDBUserSettingProtocol, ImageConfigResult> {
	        return .init(manager: cuckoo_manager, name: "imageConfig")
	    }
	    
	    
	    var userDefault: Cuckoo.ProtocolToBeStubbedProperty<MockTMDBUserSettingProtocol, UserDefaults> {
	        return .init(manager: cuckoo_manager, name: "userDefault")
	    }
	    
	    
	    var countriesCode: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTMDBUserSettingProtocol, [CountryCode]> {
	        return .init(manager: cuckoo_manager, name: "countriesCode")
	    }
	    
	    
	    var languagesCode: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTMDBUserSettingProtocol, [LanguageCode]> {
	        return .init(manager: cuckoo_manager, name: "languagesCode")
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
	
	    
	    
	    var imageConfig: Cuckoo.VerifyReadOnlyProperty<ImageConfigResult> {
	        return .init(manager: cuckoo_manager, name: "imageConfig", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var userDefault: Cuckoo.VerifyProperty<UserDefaults> {
	        return .init(manager: cuckoo_manager, name: "userDefault", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var countriesCode: Cuckoo.VerifyReadOnlyProperty<[CountryCode]> {
	        return .init(manager: cuckoo_manager, name: "countriesCode", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var languagesCode: Cuckoo.VerifyReadOnlyProperty<[LanguageCode]> {
	        return .init(manager: cuckoo_manager, name: "languagesCode", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
        
    }
    
    
     var userDefault: UserDefaults {
        get {
            return DefaultValueRegistry.defaultValue(for: (UserDefaults).self)
        }
        
        set { }
        
    }
    
    
     var countriesCode: [CountryCode] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CountryCode]).self)
        }
        
    }
    
    
     var languagesCode: [LanguageCode] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([LanguageCode]).self)
        }
        
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

