//
//  TMDBTableViewHeader.swift
//  TMDB
//
//  Created by Tuyen Le on 8/7/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

enum Section: String {
    case season
    case episode
    case popular
    case trending
    case productionCompanies
    case more
    case credit
    case video
    case keyword
    case image
    case creator
    case network
    case matching
    case backdrop
    case appearIn

    var header: String {
        switch self {
        case .season: return NSLocalizedString("Season", comment: "")
        case .episode: return NSLocalizedString("Episode", comment: "")
        case .popular: return NSLocalizedString("Popular", comment: "")
        case .trending: return NSLocalizedString("Trends", comment: "")
        case .productionCompanies: return NSLocalizedString("Produce by", comment: "")
        case .more: return NSLocalizedString("More", comment: "")
        case .credit: return NSLocalizedString("Credit", comment: "")
        case .video: return NSLocalizedString("Video", comment: "")
        case .keyword: return NSLocalizedString("Keyword", comment: "")
        case .image: return NSLocalizedString("Images", comment: "")
        case .creator: return NSLocalizedString("Creator", comment: "")
        case .network: return NSLocalizedString("Network", comment: "")
        case .matching: return NSLocalizedString("More", comment: "")
        case .backdrop: return NSLocalizedString("Images", comment: "")
        case .appearIn: return NSLocalizedString("Appear In", comment: "")
        }
    }
}

class TMDBTableDataSource: UITableViewDiffableDataSource<Section, Object> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.snapshot().sectionIdentifiers[section].header
    }
}

class TMDBCollectionDataSource: UICollectionViewDiffableDataSource<Section, Object> {
    init(cellIdentifier: String, collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? TMDBPreviewItemCell
            cell?.configure(item: item)
            return cell
        }
    }
    
    override init(collectionView: UICollectionView, cellProvider: @escaping UICollectionViewDiffableDataSource<Section, Object>.CellProvider) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
}
