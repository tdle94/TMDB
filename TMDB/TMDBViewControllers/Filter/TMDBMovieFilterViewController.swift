//
//  TMDBFilterViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 22.08.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBMovieFilterViewController: UITableViewController {
    // MARK: - filter movie delegate
    weak var delegate: TMDBMovieFilterDelegate?

    // MARK: - user setting
    var setting: TMDBUserSettingProtocol = TMDBUserSetting()

    // MARK: - data source
    var movieQuery: DiscoverQuery?

    var genreDataSource: UICollectionViewDiffableDataSource<Section, Genre>!

    var languageDataSource: UICollectionViewDiffableDataSource<Section, LanguageCode>!

    // MARK: - ui
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!

    @IBOutlet weak var genreCollectionView: UICollectionView! {
        didSet {
            let genres = movieQuery?.withGenres?.components(separatedBy: ",")
            genreCollectionView.allowsMultipleSelection = true
            genreCollectionView.register(TMDBGenreCell.self, forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            genreDataSource = UICollectionViewDiffableDataSource(collectionView: genreCollectionView) { collectionView, indexPath, genre in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBGenreCell
                let keyword = Keyword()
                keyword.name = genre.name
                if genres?.contains(String(genre.id)) ?? false {
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
                }
                cell?.configure(keyword: keyword)
                return cell
            }
            var snapshot = genreDataSource.snapshot()
            snapshot.appendSections([.genres])
            snapshot.appendItems(setting.movieGenres)
            genreDataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    @IBOutlet weak var languageCollectionView: UICollectionView! {
        didSet {
            languageCollectionView.register(TMDBGenreCell.self, forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            languageDataSource = UICollectionViewDiffableDataSource(collectionView: languageCollectionView) { collectionView, indexPath, language in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.previewItem, for: indexPath) as? TMDBGenreCell
                let keyword = Keyword()
                keyword.name = language.name
                
                if language.iso6391 == self.movieQuery?.language {
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
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
        var selectedGenres: [Genre] = []
        var selectedlanguage: LanguageCode?
        let selectedGenreIndexPaths = genreCollectionView.indexPathsForSelectedItems
        let selectedLanguageIndexPaths = languageCollectionView.indexPathsForSelectedItems?.first

        for indexPath in selectedGenreIndexPaths ?? [] {
            if let genre = genreDataSource.itemIdentifier(for: indexPath) {
                selectedGenres.append(genre)
            }
        }
        

        if let indexPath = selectedLanguageIndexPaths, let language = languageDataSource.itemIdentifier(for: indexPath) {
            selectedlanguage = language
        }
        
        movieQuery?.withGenres = selectedGenres.map({ "\($0.id)" }).joined(separator: ",")
        movieQuery?.withOriginalLanguage = selectedlanguage?.iso6391
        movieQuery?.page = 1

        dismiss(animated: true) {
            self.delegate?.filter(movieQuery: self.movieQuery!)
        }
    }
}

extension TMDBMovieFilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let label = UILabel()
        label.text = collectionView == genreCollectionView ? setting.movieGenres[indexPath.row].name : setting.languagesCode[indexPath.row].name
        label.sizeToFit()
        return CGSize(width: label.intrinsicContentSize.width, height: 20)
    }
}

extension TMDBMovieFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TMDBGenreCell
        cell?.isSelected = !(cell?.isSelected ?? true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? TMDBGenreCell
        cell?.isSelected = false
    }
}

class TMDBGenreCell: TMDBKeywordCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.backgroundColor = Constant.Color.primaryColor.cgColor
                label.textColor = .white
            } else {
                layer.backgroundColor = nil
                label.textColor = UIColor(white: 0.333333, alpha: 1)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 0
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
