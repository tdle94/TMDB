//
//  TMDBMovieDetail.swift
//  TMDB
//
//  Created by Tuyen Le on 6/24/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBMovieDetailViewController: UIViewController {
    // MARK: - properties

    enum Section: String, CaseIterable {
        case ProductionCompanies = "Produced By"
    }

    var movieId: Int?

    var dataSource: UICollectionViewDiffableDataSource<Section, ProductionCompany>!
    
    var movieDetail: TMDBMovieDetailDisplayProtocol = TMDBMovieDetailDisplay()

    // MARK: - repository
    let userSetting: TMDBUserSetting = TMDBUserSetting()

    lazy var repository: TMDBRepositoryProtocol = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                                                        urlRequestBuilder: TMDBURLRequestBuilder(),
                                                                                        userSetting: self.userSetting),
                                                                 localDataSource: TMDBLocalDataSource(),
                                                                 userSetting: self.userSetting)
    
    // MARK: - ui views
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
    @IBOutlet weak var productionCompaniesCollectionView: UICollectionView! {
        didSet {
            productionCompaniesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout(fractionWidth: 0.5, fractionHeight: 0.5)
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
        getMovieDetail()
    }

    // MARK: - movie detail display and configuration

    func configureProductionCompaniesDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: productionCompaniesCollectionView) { collectionView, indexPath, productionCompany in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as! TMDBPreviewItemCell
            cell.title.text = productionCompany.name
            cell.imageView.contentMode = .scaleAspectFit
            cell.imageView.layer.borderColor = .none
            cell.imageView.layer.borderWidth = 0

            if let path = productionCompany.logoPath, let url = self.repository.getImageURL(from: path) {
                cell.imageView.sd_setImage(with: url) { image, error, _, _ in
                    if error != nil || image == nil {
                        cell.imageView.image = UIImage(named: "NoImage")
                    }
                    cell.imageLoadingIndicator.stopAnimating()
                }
            } else {
                cell.imageView.image = UIImage(named: "NoImage")
                cell.imageLoadingIndicator.stopAnimating()
            }
            return cell
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: Constant.Identifier.previewHeader,
                                                                         for: indexPath) as? TMDBPreviewHeaderView
            header?.label.text = "Produced by"
            header?.segmentControl.removeAllSegments()
            return header
        }
    }

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
    
    func displayProductionCompanies(movie: Movie) {
        let productionCompanies = Array(movie.productionCompanies)
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.ProductionCompanies])
        snapshot.appendItems(productionCompanies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayMovieDetail(_ movie: Movie) {

        title = movie.originalTitle
        taglineLabel.text = movie.tagline

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
