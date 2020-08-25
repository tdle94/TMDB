//
//  TMDBFilterViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBFilterViewController: UITableViewController {
    // MARK: - property

    enum FilterChoice {
        case movie
        case tvShow
    }

    var filterChoice: FilterChoice = .movie

    var languageSelected: String?
    
    var yearSelected: String?

    // MARK: - filter movie delegate
    weak var delegate: TMDBFilterDelegate?

    // MARK: - user setting
    var setting: TMDBUserSettingProtocol = TMDBUserSetting()

    // MARK: - data source
    var query: DiscoverQuery?

    lazy var years: [Int] = {
        var initialYear = 1950
        var currentYear = Calendar.current.component(.year, from: Date())
        var years: [Int] = []
        for i in initialYear...currentYear {
            years.append(i)
        }
        return years
    }()

    var genreDataSource: UICollectionViewDiffableDataSource<Section, Genre>!

    var languageDataSource: UICollectionViewDiffableDataSource<Section, LanguageCode>!
    
    var yearDataSource: UICollectionViewDiffableDataSource<Section, Int>!

    // MARK: - ui
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var yearCollectionView: UICollectionView! {
        didSet {
            yearCollectionView.register(TMDBFilterCell.self, forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            yearDataSource = UICollectionViewDiffableDataSource(collectionView: yearCollectionView) { collectionView, indexPath, year in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBFilterCell
                let keyword = Keyword()
                keyword.name = String(year)

                if self.query?.primaryReleaseYear == year {
                    self.yearSelected = String(year)
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    cell?.isSelected = true
                }
                cell?.configure(keyword: keyword)
                return cell
            }
            
            var snapshot = yearDataSource.snapshot()
            snapshot.appendSections([.year])
            snapshot.appendItems(years)
            yearDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @IBOutlet weak var genreCollectionView: UICollectionView! {
        didSet {
            genreCollectionView.allowsMultipleSelection = true
            genreCollectionView.register(TMDBFilterCell.self, forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            genreDataSource = UICollectionViewDiffableDataSource(collectionView: genreCollectionView) { collectionView, indexPath, genre in
                let genres = self.query?.withGenres?.components(separatedBy: ",")
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBFilterCell
                let keyword = Keyword()
                keyword.name = genre.name
                if genres?.contains(String(genre.id)) ?? false {
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    cell?.isSelected = true
                }
                cell?.configure(keyword: keyword)
                return cell
            }
            var snapshot = genreDataSource.snapshot()
            snapshot.appendSections([.genres])
            snapshot.appendItems( filterChoice == .movie ? setting.movieGenres : setting.tvShowGenres)
            genreDataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    @IBOutlet weak var languageCollectionView: UICollectionView! {
        didSet {
            languageCollectionView.register(TMDBFilterCell.self, forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            languageDataSource = UICollectionViewDiffableDataSource(collectionView: languageCollectionView) { collectionView, indexPath, language in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBFilterCell
                let keyword = Keyword()
                keyword.name = language.name
                
                if language.iso6391 == self.query?.withOriginalLanguage {
                    self.languageSelected = language.name
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    cell?.isSelected = true
                }

                cell?.configure(keyword: keyword)
                return cell
            }
            var snapshot = languageDataSource.snapshot()
            snapshot.appendSections([.languages])
            snapshot.appendItems(setting.languagesCode)
            languageDataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Filter", comment: "")
        navigationController?.navigationBar.barTintColor = Constant.Color.primaryColor
        navigationController?.navigationBar.tintColor = Constant.Color.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.Color.backgroundColor]
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneFiltering)), animated: false)
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelFiltering)), animated: false)
    }

    @objc func cancelFiltering() {
        dismiss(animated: true, completion: nil)
    }

    @objc func doneFiltering() {
        var selectedlanguage: LanguageCode?
        var selectedYear: Int?
        let selectedGenreIndexPaths = genreCollectionView.indexPathsForSelectedItems
        let selectedLanguageIndexPath = languageCollectionView.indexPathsForSelectedItems?.first
        let selectedYearIndexPath = yearCollectionView.indexPathsForSelectedItems?.first

        if let indexPath = selectedLanguageIndexPath, let language = languageDataSource.itemIdentifier(for: indexPath) {
            selectedlanguage = language
        }
        
        if let indexPath = selectedYearIndexPath, let year = yearDataSource.itemIdentifier(for: indexPath) {
            selectedYear = year
        }

        query?.withGenres = selectedGenreIndexPaths?.compactMap({ self.genreDataSource.itemIdentifier(for: $0) }).map({ "\($0.id)" }).joined(separator: ",")
        query?.withOriginalLanguage = selectedlanguage?.iso6391
        query?.primaryReleaseYear = selectedYear
        query?.page = 1

        if query?.withGenres == "" {
            query?.withGenres = nil
        }

        dismiss(animated: true) {
            self.delegate?.filter(query: self.query!)
        }
    }
}
