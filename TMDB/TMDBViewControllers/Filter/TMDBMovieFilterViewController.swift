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
    // MARK: - property
    var languageSelected: String?

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
            genreCollectionView.allowsMultipleSelection = true
            genreCollectionView.register(TMDBFilterCell.self, forCellWithReuseIdentifier: Constant.Identifier.previewItem)
            genreDataSource = UICollectionViewDiffableDataSource(collectionView: genreCollectionView) { collectionView, indexPath, genre in
                let genres = self.movieQuery?.withGenres?.components(separatedBy: ",")
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
            snapshot.appendItems(setting.movieGenres)
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
                
                if language.iso6391 == self.movieQuery?.withOriginalLanguage {
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
        
        if movieQuery?.withGenres == "" {
            movieQuery?.withGenres = nil
        }
        dismiss(animated: true) {
            self.delegate?.filter(query: self.movieQuery!)
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
        return CGSize(width: label.intrinsicContentSize.width, height: 30)
    }
}

extension TMDBMovieFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == languageCollectionView else { return }

        let cell = collectionView.cellForItem(at: indexPath) as? TMDBFilterCell

        if cell?.label.text == languageSelected {
            collectionView.deselectItem(at: indexPath, animated: false)
            languageSelected = nil
        } else {
            languageSelected = cell?.label.text
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TMDBFilterCell

        if collectionView == languageCollectionView {
            movieQuery?.withOriginalLanguage = nil
        } else {
            var genres = movieQuery?.withGenres?.components(separatedBy: ",")
            let genreId = setting.movieGenres.first(where: { $0.name == cell.label.text })!.id
            genres?.removeAll(where: { $0 == String(genreId) })
            movieQuery?.withGenres = genres?.joined(separator: ",")
        }
    }
    
}

class TMDBFilterCell: TMDBKeywordCell {
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
