//
//  GenreTableViewCell.swift
//  TMDB
//
//  Created by Tuyen Le on 1/8/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import UIKit
import RxSwift

class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var genreCollectionView: UICollectionView! {
        didSet {
            genreCollectionView.allowsMultipleSelection = true
            genreCollectionView.register(TMDBKeywordCell.self,
                                         forCellWithReuseIdentifier: Constant.Identifier.keywordCell)
        }
    }
    
    enum MediaType {
        case movie
        case tvShow
    }
    
    func setup(viewModel: FilterViewModelProtocol, mediaType: MediaType, selection: @escaping (Int, Bool) -> Void) {

        let genres: [Genre]
        
        if mediaType == .movie {
            genres = viewModel.userSetting.movieGenres
        } else {
            genres = viewModel.userSetting.tvShowGenres
        }

        if genreCollectionView.numberOfItems(inSection: 0) == 0 {

            (genreCollectionView.collectionViewLayout as? TMDBKeywordLayout)?.texts = genres.map { $0.name }

            genreCollectionView
                .rx
                .itemSelected
                .asDriver()
                .drive(onNext: { indexPath in
                    selection(genres[indexPath.row].id, true)
                })
                .disposed(by: rx.disposeBag)
            
            genreCollectionView
                .rx
                .itemDeselected
                .asDriver()
                .drive(onNext: { indexPath in
                    selection(genres[indexPath.row].id, false)
                })
                .disposed(by: rx.disposeBag)

            Observable<[Genre]>
                .just(genres)
                .bind(to: genreCollectionView.rx.items(cellIdentifier: Constant.Identifier.keywordCell)) { _, genre, cell in
                    (cell as? TMDBKeywordCell)?.configure(item: genre)
                }
                .disposed(by: rx.disposeBag)
        }
    }
}
