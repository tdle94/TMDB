//
//  TMDBReviewTableViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 7/8/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBReivewTableViewController: UITableViewController {
    var review: [Review] = []
    
    private var selectedIndexPahths: [IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Review", comment: "")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.reviewCell, for: indexPath)
        cell.textLabel?.text = review[indexPath.row].author
        
        if selectedIndexPahths.contains(indexPath) {
            cell.detailTextLabel?.numberOfLines = 0
        }
        
        cell.detailTextLabel?.text = review[indexPath.row].content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !selectedIndexPahths.contains(indexPath) {
            selectedIndexPahths.append(indexPath)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
