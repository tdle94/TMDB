//
//  TMDBMovieDetail.swift
//  TMDB
//
//  Created by Tuyen Le on 6/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TMDBMovieDetailViewController: UIViewController {
    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - properties

    enum Section: String, CaseIterable {
        case ProductionCompanies = "Produced By"
    }
    
    enum MatchingMovieSection: String, CaseIterable {
        case SimilarMovie = "Similar"
        case RecommendMovie = "Recommend"
    }

    var movieId: Int?

    var productionCompanyDataSource: UICollectionViewDiffableDataSource<Section, ProductionCompany>!

    var matchingMoviesDataSource: UICollectionViewDiffableDataSource<MatchingMovieSection, Object>!
    
    var movieDetail: TMDBMovieDetailDisplayProtocol = TMDBMovieDetailDisplay()

    // MARK: - repository
    let userSetting: TMDBUserSetting = TMDBUserSetting()

    lazy var repository: TMDBRepositoryProtocol = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                                                        urlRequestBuilder: TMDBURLRequestBuilder(),
                                                                                        userSetting: self.userSetting),
                                                                 localDataSource: TMDBLocalDataSource(),
                                                                 userSetting: self.userSetting)
    
    // MARK: - ui views
    @IBOutlet weak var matchingMoviesCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompanyCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var taglineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewDetailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var productionCompaniesCollectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewDetail: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var generes: UILabel!
    @IBOutlet weak var matchingMoviesCollectionView: UICollectionView! {
        didSet {
            matchingMoviesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
            matchingMoviesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            matchingMoviesCollectionView.register(UINib(nibName: "TMDBPreviewHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
        }
    }
    @IBOutlet weak var productionCompaniesCollectionView: UICollectionView! {
        didSet {
            productionCompaniesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout(fractionWidth: 0.5, fractionHeight: 0.3)
            productionCompaniesCollectionView.register(UINib(nibName: "TMDBPreviewItemCell", bundle: nil), forCellWithReuseIdentifier: Constant.Identifier.preview)
            productionCompaniesCollectionView.register(UINib(nibName: "TMDBPreviewHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constant.Identifier.previewHeader)
        }
    }
    @IBOutlet weak var moviePosterImageView: UIImageView! {
        didSet {
            moviePosterImageView.roundImage()
        }
    }

    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        contentView.bringSubviewToFront(moviePosterImageView)
        configureProductionCompaniesDataSource()
        configureMatchingMoviesDataSource()
        getMovieDetail()
        getSimilarMovies()
        getRecommendMovies()
    }

    // MARK: - configuration
    
    func configureMatchingMoviesDataSource() {
        matchingMoviesDataSource = UICollectionViewDiffableDataSource(collectionView: matchingMoviesCollectionView) { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as! TMDBPreviewItemCell
            cell.configure(item: movie, with: self.repository)
            return cell
        }
        
        matchingMoviesDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                         for: indexPath) as? TMDBPreviewHeaderView
            header?.segmentControl.removeAllSegments()
            if indexPath.section == 0 {
                header?.label.text = NSLocalizedString("Similar", comment: "")
            } else {
                header?.label.text = NSLocalizedString("Recommend", comment: "")
            }
            return header
        }
        
        var snapshot = matchingMoviesDataSource.snapshot()
        snapshot.appendSections([.SimilarMovie, .RecommendMovie])
        matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func configureProductionCompaniesDataSource() {
        productionCompanyDataSource = UICollectionViewDiffableDataSource(collectionView: productionCompaniesCollectionView) { collectionView, indexPath, productionCompany in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as! TMDBPreviewItemCell
            cell.configure(item: productionCompany, with: self.repository)
            return cell
        }
        productionCompanyDataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                         for: indexPath) as? TMDBPreviewHeaderView
            header?.label.text = NSLocalizedString("Produce by", comment: "")
            header?.segmentControl.removeAllSegments()
            return header
        }
    }

    // MARK: - service call

    func getMovieDetail() {
        guard let id = movieId else { return }
        repository.getMovieDetail(id: id) { result in
            switch result {
            case .success(let movie):
                self.displayMovieDetail(movie)
                self.displayProductionCompanies(movie: movie)
                self.getPosterImage(movie: movie)
                self.getBackdropImage(movie: movie)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func getSimilarMovies() {
        guard let id = movieId else { return }
        repository.getSimilarMovies(from: id, page: 1) { result in
            switch result {
            case .success(let movie):
                self.displaySimilarMovies(movie)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func getRecommendMovies() {
        guard let id = movieId else { return }
        repository.getRecommendMovies(from: id, page: 1) { result in
            switch result {
            case .success(let movie):
                self.displayRecommendMovies(movie)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func getPosterImage(movie: Movie) {
        if let posterPath = movie.posterPath, let url = self.repository.getImageURL(from: posterPath) {
            self.moviePosterImageView.sd_setImage(with: url) { image, _, _, _ in
                image?.getColors { colors in
                    self.moviePosterImageView.layer.borderColor = colors?.secondary.cgColor
                }
            }
        }
    }
    
    func getBackdropImage(movie: Movie) {
        if let backdropPath = movie.backdropPath, let url = self.repository.getImageURL(from: backdropPath) {
            self.backdropImageView.sd_setImage(with: url)
        }
    }
    // MARK: - display

    func displayRecommendMovies(_ popularMovie: PopularMovie) {
        var snapshot = matchingMoviesDataSource.snapshot()
        if popularMovie.movies.isEmpty {
            snapshot.deleteSections([.RecommendMovie])
            matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
            return
        }
        let recommendMovies = Array(popularMovie.movies)
        snapshot.appendItems(recommendMovies, toSection: .RecommendMovie)
        matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func displaySimilarMovies(_ popularMovie: PopularMovie) {
        var snapshot = matchingMoviesDataSource.snapshot()
        if popularMovie.movies.isEmpty {
            snapshot.deleteSections([.SimilarMovie])
            matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
            return
        }
        let similarMovies = Array(popularMovie.movies)
        snapshot.appendItems(similarMovies, toSection: .SimilarMovie)
        matchingMoviesDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayProductionCompanies(movie: Movie) {
        var snapshot = productionCompanyDataSource.snapshot()
        if movie.productionCompanies.isEmpty {
            productionCompanyCollectionViewTopConstraint.constant = 0
            productionCompanyCollectionViewHeightConstraint.constant = 0
            matchingMoviesCollectionViewTopConstraint.constant = 0
            return
        }
        let productionCompanies = Array(movie.productionCompanies)
        snapshot.appendSections([.ProductionCompanies])
        snapshot.appendItems(productionCompanies)
        productionCompanyDataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayMovieDetail(_ movie: Movie) {
        if movie.overview == nil || movie.overview == "" {
            overviewDetailTopConstraint.constant = 0
            productionCompaniesCollectionViewTopConstraint.constant = 0
            overviewTopConstraint.constant = 0
            overviewLabel.isHidden = true
            overviewDetail.isHidden = true
        }
        
        if movie.tagline == nil || movie.tagline == "" {
            taglineTopConstraint.constant = 0
            taglineLabel.isHidden = true
        }

        title = movie.originalTitle
        taglineLabel.text = movie.tagline
        
        if movie.tagline == "" {
            taglineTopConstraint.constant = 0
        }

        movieDetail.displayTitle(label: titleLabel, movie: movie)
        movieDetail.displayBudget(label: budgetLabel, movie: movie)
        movieDetail.displayGenere(label: generes, movie: movie)
        movieDetail.displayOriginalLanguage(label: originalLanguageLabel, movie: movie)
        movieDetail.displayOverview(label: overviewLabel)
        movieDetail.displayOverviewDetail(label: overviewDetail, movie: movie)
        movieDetail.displayRevenue(label: revenueLabel, movie: movie)
        movieDetail.displayRuntime(label: runtimeLabel, movie: movie)
        movieDetail.displayStatus(label: statusLabel, movie: movie)
        movieDetail.displayTitle(label: titleLabel, movie: movie)
    }
}

extension TMDBMovieDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TMDBPreviewItemCell
        
        for item in matchingMoviesDataSource.snapshot().itemIdentifiers {
            if let movie = item as? Movie, movie.originalTitle == cell?.title.text {
                coordinator?.navigateToMovieDetail(id: movie.id)
                break
            }
        }
    }
}
