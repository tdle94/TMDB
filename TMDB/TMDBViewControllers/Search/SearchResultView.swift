//
//  SearchResultView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/25/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

class SearchResultView: UIViewController {
    let footerLoadIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)

    let loadBackgroundView = UIActivityIndicatorView(style: .medium)
    
    let emptyLabel = UILabel()
    
    @IBOutlet weak var filterButtonView: FilterButtonView!

    @IBOutlet var searchResultTableView: UITableView! {
        didSet {
            searchResultTableView.register(UINib(nibName: String(describing: TMDBCustomTableViewCell.self), bundle: nil),
                                           forCellReuseIdentifier: Constant.Identifier.searchResultCell)
            searchResultTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            
            filterButtonView.isHidden = true

            searchResultTableView.rowHeight = 150
            
            searchResultTableView.tableFooterView?.addSubview(footerLoadIndicatorView)
            
            loadBackgroundView.startAnimating()
            
            let backgroundView = UIView()

            backgroundView.addSubview(loadBackgroundView)
            backgroundView.addSubview(emptyLabel)
            
            emptyLabel.textAlignment = .center
            emptyLabel.setHeader(title: NSLocalizedString("No item found", comment: ""))
            emptyLabel.isHidden = true
            emptyLabel.translatesAutoresizingMaskIntoConstraints = false
            emptyLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
            emptyLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
            emptyLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
            emptyLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            loadBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            loadBackgroundView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
            loadBackgroundView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
            loadBackgroundView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            loadBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            searchResultTableView.backgroundView = backgroundView

            footerLoadIndicatorView.hidesWhenStopped = true
            footerLoadIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            footerLoadIndicatorView.widthAnchor.constraint(equalTo: searchResultTableView.tableFooterView!.widthAnchor).isActive = true
            footerLoadIndicatorView.heightAnchor.constraint(equalTo: searchResultTableView.tableFooterView!.heightAnchor).isActive = true
            footerLoadIndicatorView.centerXAnchor.constraint(equalTo: searchResultTableView.tableFooterView!.centerXAnchor).isActive = true
            footerLoadIndicatorView.centerYAnchor.constraint(equalTo: searchResultTableView.tableFooterView!.centerYAnchor).isActive = true
        }
    }
    
    func showEmptyLabel(message: String) {
        emptyLabel.isHidden = false
        emptyLabel.setHeader(title: message)
    }
}
