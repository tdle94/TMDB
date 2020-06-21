//
//  TMDBCountrySettingViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 20.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBCountrySearchResultController: UITableViewController {
    var selectedIndexPath: IndexPath?

    var searchCountries: [String] = []
    
    override func viewWillDisappear(_ animated: Bool) {
        selectedIndexPath = nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCountries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.countrySearch, for: indexPath)
        cell.textLabel?.text = searchCountries[indexPath.row]
        if let image = UIImage(named: "CountryFlags/\(searchCountries[indexPath.row])") {
            cell.imageView?.image = image.resize(newWidth: 30)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedIndexPath = indexPath
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

class TMDBCountrySettingViewController: UITableViewController {
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    var selectedIndexPath: IndexPath?
    
    let countrySearchResultController: TMDBCountrySearchResultController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.ViewControllerIdentifier.tmdbCountrySearch) as! TMDBCountrySearchResultController

    lazy var searchController: UISearchController = {
       let searchController = UISearchController(searchResultsController: countrySearchResultController)
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
        cell.textLabel?.text = "\(Constant.countryName[Constant.countryCode[indexPath.row]] ?? "")"

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
        if
            let indexPath = countrySearchResultController.selectedIndexPath,
            let countryCode = Constant.reverseCountryName[countrySearchResultController.searchCountries[indexPath.row]]  {
            userSetting.region = countryCode
        } else if
            let indexPath = selectedIndexPath,
            let country = tableView.cellForRow(at: indexPath)?.textLabel?.text,
            let countryCode = Constant.reverseCountryName[country] {
            userSetting.region = countryCode
        }
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension TMDBCountrySettingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        let countries = Array(Constant.countryName.values).filter { $0.contains(searchText) }

        countrySearchResultController.searchCountries = countries
        countrySearchResultController.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
