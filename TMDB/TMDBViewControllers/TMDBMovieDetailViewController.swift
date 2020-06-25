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

    // MARK: - repository
    let userSetting: TMDBUserSetting = TMDBUserSetting()

    lazy var repository: TMDBRepositoryProtocol = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                                                        urlRequestBuilder: TMDBURLRequestBuilder(),
                                                                                        userSetting: self.userSetting),
                                                                 localDataSource: TMDBLocalDataSource(),
                                                                 userSetting: self.userSetting)
    
    // MARK: - ui views
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
            productionCompaniesCollectionView.collectionViewLayout = UICollectionViewLayout.customLayout()
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
        contentView.bringSubviewToFront(moviePosterImageView)
        configureProductionCompaniesDataSource()
        getMovieDetail()
    }
    
    func configureProductionCompaniesDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: productionCompaniesCollectionView) { collectionView, indexPath, productionCompany in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.preview, for: indexPath) as! TMDBPreviewItemCell
            cell.title.text = productionCompany.name
            cell.releaseDate.text = ""
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
                self.displayMovie(movie)
                self.displayProductionCompanies(movie: movie)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    func displayProductionCompanies(movie: Movie) {
        let productionCompanies = Array(movie.productionCompanies)
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.ProductionCompanies])
        snapshot.appendItems(productionCompanies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func displayMovie(_ movie: Movie) {
        let textAttrs = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        let numberFormatter = NumberFormatter()
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 3
        numberFormatter.numberStyle = .decimal

        navigationController?.navigationBar.titleTextAttributes = textAttrs
        title = movie.originalTitle
        statusLabel.attributedText = constructAttrsString(title: "Status: ", subTitle: movie.status ?? "unknown")
        originalLanguageLabel.attributedText = constructAttrsString(title: "Original Language: ", subTitle: Constant.languageCode[movie.originalLanguage] ?? "None")
        budgetLabel.attributedText = constructAttrsString(title: "Budget: ", subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.budget)) ?? "0.0")")
        revenueLabel.attributedText = constructAttrsString(title: "Revenue: ", subTitle: "$\(numberFormatter.string(from: NSNumber(value: movie.revenue)) ?? "0.0")")
        titleLabel.attributedText = NSAttributedString(string: movie.originalTitle, attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.labelFontSize)!])
        overviewLabel.attributedText = NSAttributedString(string: "Overview", attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!])
        overviewDetail.attributedText = NSAttributedString(string: movie.overview ?? "", attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!, NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        taglineLabel.text = movie.tagline

        var productionCountries = ""
        if movie.productionCountries.count == 1 {
            productionCountries = movie.productionCountries.first!.ios31661
        } else {
            for country in movie.productionCountries {
                if country == movie.productionCountries.last {
                    productionCountries += " \(country.ios31661)"
                } else {
                    productionCountries += "\(country.ios31661), "
                }
            }
        }
        
        
        runtimeLabel.attributedText = NSAttributedString(string: "\(movie.runtime / 60)h \(movie.runtime % 60)mins \u{2022} \(movie.releaseDate ?? "") (\(productionCountries))",
                                                         attributes: [
                                                            NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!,
                                                            NSAttributedString.Key.foregroundColor: UIColor.darkGray
                                                         ])
        
        var genres = ""
        for genre in movie.genres {
            if genre == movie.genres.last {
                genres += " \(genre.name)"
            } else {
                genres += "\(genre.name), "
            }
        }
        generes.attributedText = NSAttributedString(string: genres, attributes: [NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!])

        if let posterPath = movie.posterPath, let url = repository.getImageURL(from: posterPath) {
            moviePosterImageView.sd_setImage(with: url) { image, _, _, _ in
                image?.getColors { colors in
                    self.moviePosterImageView.layer.borderColor = colors?.secondary.cgColor
                }
            }
        }
        if let backdropPath = movie.backdropPath, let url = repository.getImageURL(from: backdropPath) {
            backdropImageView.sd_setImage(with: url)
        }
    }
    
    func constructAttrsString(title: String, subTitle: String) -> NSAttributedString {
        let firstString = NSMutableAttributedString(string: title, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Circular-Black", size: UIFont.smallSystemFontSize)!,
        ])
        let secondString = NSMutableAttributedString(string: subTitle, attributes: [
            NSAttributedString.Key.font: UIFont(name: "Circular-Book", size: UIFont.smallSystemFontSize)!,
        ])
        firstString.append(secondString)
        return firstString
    }
}
