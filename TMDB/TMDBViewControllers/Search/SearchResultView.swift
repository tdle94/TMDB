//
//  SearchResultView.swift
//  TMDB
//
//  Created by Tuyen Le on 12/25/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit

class SearchResultView: UIViewController {
    var loadingIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    @IBOutlet var searchResultTableView: UITableView! {
        didSet {
            searchResultTableView.register(UINib(nibName: String(describing: TMDBCustomTableViewCell.self), bundle: nil),
                                           forCellReuseIdentifier: Constant.Identifier.searchResultCell)
            searchResultTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            searchResultTableView.rowHeight = 150
            
            searchResultTableView.tableFooterView?.addSubview(loadingIndicatorView)
            
            loadingIndicatorView.hidesWhenStopped = true
            loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            loadingIndicatorView.widthAnchor.constraint(equalTo: searchResultTableView.tableFooterView!.widthAnchor).isActive = true
            loadingIndicatorView.heightAnchor.constraint(equalTo: searchResultTableView.tableFooterView!.heightAnchor).isActive = true
            loadingIndicatorView.centerXAnchor.constraint(equalTo: searchResultTableView.tableFooterView!.centerXAnchor).isActive = true
            loadingIndicatorView.centerYAnchor.constraint(equalTo: searchResultTableView.tableFooterView!.centerYAnchor).isActive = true
        }
    }
}
