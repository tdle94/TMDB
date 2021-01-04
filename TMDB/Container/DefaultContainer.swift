//
//  DefaultContainer.swift
//  TMDB
//
//  Created by Tuyen Le on 11/15/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import Swinject

final class DefaultContainer {
    let container: Container = Container()
    
    init() {
        self.container.register(TMDBUserSettingProtocol.self) { _ in
            TMDBUserSetting()
        }
        self.container.register(TMDBLocalDataSourceProtocol.self) { _ in
            TMDBLocalDataSource()
        }
        self.container.register(TMDBURLRequestBuilderProtocol.self) { _ in
            TMDBURLRequestBuilder()
        }
        self.container.register(TMDBSessionProtocol.self) { _ in
            TMDBSession(session: URLSession.shared)
        }
        self.registerViews()
        self.registerRepository()
        self.registerViewModel()
    }
}

extension DefaultContainer {
    func registerViewModel() {
        self.container.register(HomeViewModelProtocol.self) { resolver in
            HomeViewModel(movieRepository: resolver.resolve(TMDBMovieRepository.self)!,
                          tvShowRepository: resolver.resolve(TMDBTVShowRepository.self)!,
                          trendingRepository: resolver.resolve(TMDBTrendingRepository.self)!,
                          peopleRepository: resolver.resolve(TMDBPeopleRepository.self)!)
        }
        
        self.container.register(MovieDetailViewModelProtocol.self) { resolver in
            MovieDetailViewModel(movieRepository: resolver.resolve(TMDBMovieRepository.self)!,
                                 userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }

        self.container.register(TVShowDetailViewModelProtocol.self) { resolver in
            TVShowDetailViewModel(repository: resolver.resolve(TMDBTVShowRepository.self)!,
                                  userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }
        
        self.container.register(TVShowSeasonDetailViewModelProtocol.self) { resolver in
            TVShowSeasonDetailViewModel(repository: resolver.resolve(TMDBTVShowRepository.self)!,
                                        userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }
        
        self.container.register(SearchViewModelProtocol.self) { resolver in
            SearchViewViewModel(searchRepository: resolver.resolve(TMDBSearchRepository.self)!)
        }
        
        self.container.register(PersonDetailViewModelProtocol.self) { resolver in
            PersonDetailViewModel(repository: resolver.resolve(TMDBPeopleRepository.self)!,
                                  userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }
        
        self.container.register(ReleaseDateViewModelProtocol.self) { resolver in
            ReleaseDateViewModel(repository: resolver.resolve(TMDBMovieRepository.self)!)
        }
        
        self.container.register(EpisodeDetailViewModelProtocol.self) { resolver in
            EpisodeDetailViewModel(repository: resolver.resolve(TMDBTVShowRepository.self)!,
                                   userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }
        
        self.container.register(DiscoveryViewModelProtocol.self) { resolver in
            DiscoveryViewModel(movieRepository: resolver.resolve(TMDBMovieRepository.self)!,
                               tvShowRepository: resolver.resolve(TMDBTVShowRepository.self)!)
        }
    }

    func registerViews() {
        self.container.register(MovieDetailView.self) { resolver in
            MovieDetailView(viewModel: resolver.resolve(MovieDetailViewModelProtocol.self)!)
        }
        
        self.container.register(HomeView.self) { resolver in
            HomeView(userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!,
                     viewModel: resolver.resolve(HomeViewModelProtocol.self)!)
        }

        self.container.register(TVShowDetailView.self) { resolver in
            TVShowDetailView(viewModel: resolver.resolve(TVShowDetailViewModelProtocol.self)!)
        }

        self.container.register(TVShowListSeasonView.self) { resolver in
            TVShowListSeasonView()
        }
        
        self.container.register(TVShowSeasonDetailView.self) { resolver in
            TVShowSeasonDetailView(viewModel: resolver.resolve(TVShowSeasonDetailViewModelProtocol.self)!)
        }
        
        self.container.register(SearchResultView.self) { resolver in
            SearchResultView(nibName: String(describing: SearchResultView.self), bundle: nil)
        }

        self.container.register(SearchView.self) { resolver in
            SearchView(searchController: UISearchController(searchResultsController: resolver.resolve(SearchResultView.self)!),
                       searchViewModel: resolver.resolve(SearchViewModelProtocol.self)!,
                       discoveryViewModel: resolver.resolve(DiscoveryViewModelProtocol.self)!)
        }
        
        self.container.register(PersonDetailView.self) { resolver in
            PersonDetailView(viewModel: resolver.resolve(PersonDetailViewModelProtocol.self)!)
        }

        self.container.register(ReleaseDateView.self) { resolver in
            ReleaseDateView(viewModel: resolver.resolve(ReleaseDateViewModelProtocol.self)!)
        }
        
        self.container.register(ReviewView.self) { resolver in
            ReviewView()
        }
        
        self.container.register(EpisodeDetailView.self) { resolver in
            EpisodeDetailView(viewModel: resolver.resolve(EpisodeDetailViewModelProtocol.self)!)
        }
    }
    
    func registerRepository() {
        self.container.register(TMDBAuthenticationRepository.self) { resolver in
            TMDBRepository(services: TMDBServices(session: resolver.resolve(TMDBSessionProtocol.self)!,
                                                  urlRequestBuilder: resolver.resolve(TMDBURLRequestBuilderProtocol.self)!),
                           localDataSource: resolver.resolve(TMDBLocalDataSourceProtocol.self)!,
                           userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }

        self.container.register(TMDBMovieRepository.self) { resolver in
            TMDBRepository(services: TMDBServices(session: resolver.resolve(TMDBSessionProtocol.self)!,
                                                  urlRequestBuilder: resolver.resolve(TMDBURLRequestBuilderProtocol.self)!),
                           localDataSource: resolver.resolve(TMDBLocalDataSourceProtocol.self)!,
                           userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }
        
        self.container.register(TMDBTVShowRepository.self) { resolver in
            TMDBRepository(services: TMDBServices(session: resolver.resolve(TMDBSessionProtocol.self)!,
                                                  urlRequestBuilder: resolver.resolve(TMDBURLRequestBuilderProtocol.self)!),
                           localDataSource: resolver.resolve(TMDBLocalDataSourceProtocol.self)!,
                           userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }
        
        
        self.container.register(TMDBTrendingRepository.self) { resolver in
            TMDBRepository(services: TMDBServices(session: resolver.resolve(TMDBSessionProtocol.self)!,
                                                  urlRequestBuilder: resolver.resolve(TMDBURLRequestBuilderProtocol.self)!),
                           localDataSource: resolver.resolve(TMDBLocalDataSourceProtocol.self)!,
                           userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }
        
        self.container.register(TMDBPeopleRepository.self) { resolver in
            TMDBRepository(services: TMDBServices(session: resolver.resolve(TMDBSessionProtocol.self)!,
                                                  urlRequestBuilder: resolver.resolve(TMDBURLRequestBuilderProtocol.self)!),
                           localDataSource: resolver.resolve(TMDBLocalDataSourceProtocol.self)!,
                           userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }
        
        self.container.register(TMDBSearchRepository.self) { resolver in
            TMDBRepository(services: TMDBServices(session: resolver.resolve(TMDBSessionProtocol.self)!,
                                                  urlRequestBuilder: resolver.resolve(TMDBURLRequestBuilderProtocol.self)!),
                           localDataSource: resolver.resolve(TMDBLocalDataSourceProtocol.self)!,
                           userSetting: resolver.resolve(TMDBUserSettingProtocol.self)!)
        }
    }
}
