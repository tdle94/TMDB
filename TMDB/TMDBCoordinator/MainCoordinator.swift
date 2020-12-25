//
//  MainCoordinator.swift
//  TMDB
//
//  Created by Tuyen Le on 6/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Swinject

protocol CommonNavigation: class {
    func navigateBack()
}

protocol HomeViewDelegate: class {
    func navigateToMovieDetail(movieId: Int)
    func navigateToTVShowDetail(tvShowId: Int)
}

protocol MovieDetailViewDelegate: CommonNavigation {
    func navigateToMovieDetail(movieId: Int)
}

protocol TVShowDetailViewDelegate: CommonNavigation {
    func navigateToListSeason(season: [Season], tvShowId: Int)
    func navigateToTVShowDetail(tvShowId: Int)
}

protocol ListSeasonViewDelegate: CommonNavigation {
    func navigateToSeasonDetail(season: Season, tvShowId: Int)
}

protocol SeasonDetailViewDelegate: CommonNavigation {
    // TODO: nav function
}

class AppCoordinator {
    let window: UIWindow
    let container: Container
    
    var currentView: UIViewController?

    var homeView: HomeView {
        return container.resolve(HomeView.self)!
    }
    
    var movieDetailView: MovieDetailView {
        return container.resolve(MovieDetailView.self)!
    }
    
    var tvShowDetailView: TVShowDetailView {
        return container.resolve(TVShowDetailView.self)!
    }
    
    var listSeasonView: TVShowListSeasonView {
        return container.resolve(TVShowListSeasonView.self)!
    }
    
    var seasonDetailView: TVShowSeasonDetailView {
        return container.resolve(TVShowSeasonDetailView.self)!
    }

    init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
    }

    fileprivate func showMovieDetailView(movieId: Int) {
        let view = movieDetailView
        view.movieId = movieId
        view.delegate = self
        currentView?.navigationController?.pushViewController(view, animated: true)
        currentView = view
    }
    
    fileprivate func showTVShowDetailView(tvShowId: Int) {
        let view = tvShowDetailView
        view.tvShowId = tvShowId
        view.delegate = self
        currentView?.navigationController?.pushViewController(view, animated: true)
        currentView = view
    }
    
    fileprivate func showListSeason(season: [Season], tvShowId: Int) {
        let view = listSeasonView
        view.seasons = season
        view.tvShowId = tvShowId
        view.delegate = self
        currentView?.navigationController?.pushViewController(view, animated: true)
        currentView = view
    }

    fileprivate func showSeasonDetaiL(season: Season, tvShowId: Int ) {
        let view = seasonDetailView
        view.season = season
        view.tvShowId = tvShowId
        view.delegate = self
        currentView?.navigationController?.pushViewController(view, animated: true)
        currentView = view
    }
    
    func navigateBack() {
        currentView = currentView?.navigationController?.popViewController(animated: true)
        currentView = currentView?.navigationController?.topViewController
    }
}

extension AppCoordinator: HomeViewDelegate, MovieDetailViewDelegate {
    func navigateToMovieDetail(movieId: Int) {
        showMovieDetailView(movieId: movieId)
    }
    
    func navigateToTVShowDetail(tvShowId: Int) {
        showTVShowDetailView(tvShowId: tvShowId)
    }
}

extension AppCoordinator: TVShowDetailViewDelegate {
    func navigateToListSeason(season: [Season], tvShowId: Int) {
        showListSeason(season: season, tvShowId: tvShowId)
    }
}

extension AppCoordinator: ListSeasonViewDelegate {
    func navigateToSeasonDetail(season: Season, tvShowId: Int) {
        showSeasonDetaiL(season: season, tvShowId: tvShowId)
    }
}

extension AppCoordinator: SeasonDetailViewDelegate {
    // TODO: nav function
}
