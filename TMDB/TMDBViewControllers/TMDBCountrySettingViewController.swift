//
//  TMDBCountrySettingViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 20.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBCountrySettingViewController: UITableViewController {
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    var selectedIndexPath: IndexPath?
    
    lazy var searchController: UISearchController = {
       let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "region, country"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTap)), animated: false)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        scrollToUserSettingCountry()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constant.countryCode.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = "\(Constant.countryName[Constant.countryCode[indexPath.row]] ?? "") (\(Constant.countryCode[indexPath.row]))"
        
        if let image = UIImage(named: "CountryFlags/\(Constant.countryName[Constant.countryCode[indexPath.row]] ?? "")") {
            cell.imageView?.image = image.resize(newWidth: 30)
        }

        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        if let selectedIndexPath = selectedIndexPath {
            tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .none
        }
        selectedIndexPath = indexPath
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return [
            "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "K", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
        ]
    }
    
    func scrollToUserSettingCountry() {
        let userSettingCountryCode = userSetting.region?.uppercased()
        if let row = Constant.countryCode.firstIndex(where: { $0 == userSettingCountryCode }) {
            selectedIndexPath = IndexPath(row: row, section: 0)
            tableView.selectRow(at: selectedIndexPath!, animated: true, scrollPosition: .top)
        }
    }

    @objc func doneButtonTap() {

    }
}

extension TMDBCountrySettingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
