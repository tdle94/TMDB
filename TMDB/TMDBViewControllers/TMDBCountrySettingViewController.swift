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
    
    var countries: [[String]] = [
        [
            "Afghanistan",
            "Aland Islands",
            "Albania",
            "Algeria",
            "American Samoa",
            "Andorra",
            "Angola",
            "Anguilla",
            "Antigua and Barbuda",
            "Argentina",
            "Armenia",
            "Aruba",
            "Australia",
            "Austria",
            "Azerbaijan",
        ],
        [
            "Bahamas",
            "Bahrain",
            "Bangladesh",
            "Barbados",
            "Belarus",
            "Belgium",
            "Belize",
            "Benin",
            "Bermuda",
            "Bhutan",
            "Bolivia",
            "Bosnia and Herzegovina",
            "Botswana",
            "Brazil",
            "British Indian Ocean Territory",
            "Brunei",
            "Bulgaria",
            "Burkina Faso",
            "Burundi",
            "British Virgin Islands"
        ],
        [
            "Cambodia",
            "Cameroon",
            "Canada",
            "Cape Verde",
            "Cayman Islands",
            "Central African Republic",
            "Chad",
            "Chile",
            "China",
            "Christmas Island",
            "Colombia",
            "Comoros",
            "Congo",
            "Democratic Republic of Congo",
            "Cook Islands",
            "Costa Rica",
            "Croatia",
            "Cuba",
            "Curacao",
            "Cyprus",
            "Czech Republic",
        ],
        [
            "Denmark",
            "Djibouti",
            "Dominica",
            "Dominican Republic",
        ],
        [
            "Ecuador",
            "Egypt",
            "El Salvador",
            "Equatorial Guinea",
            "Eritrea",
            "Estonia",
            "Ethiopia",
        ],
        [
            "Falkland Islands",
            "Faroe Islands",
            "Fiji",
            "Finland",
            "France",
            "French Polynesia",
        ],
         [
            "Gabon",
            "Gambia",
            "Georgia",
            "Germany",
            "Ghana",
            "Gibraltar",
            "Greece",
            "Greenland",
            "Grenada",
            "Guam",
            "Guatemala",
            "Guernsey",
            "Guinea",
            "Guinea Bissau",
            "Guyana",
        ],
        [
            "Haiti",
            "Holy See (Vatican City State)",
            "Honduras",
            "Hong Kong",
            "Hungary",
        ],
        [
            "Iceland",
            "India",
            "Indonesia",
            "Iran",
            "Iraq",
            "Ireland",
            "Isle of Man",
            "Israel",
            "Italy",
        ],
        [
            "Jamaica",
            "Japan",
            "Jersey",
            "Jordan",
        ],
        [
            "Kazakhstan",
            "Kenya",
            "Kiribati",
            "South Korea",
            "Kuwait",
            "Kyrgyzstan",
        ],
        [
            "Laos",
            "Latvia",
            "Lebanon",
            "Lesotho",
            "Liberia",
            "Libya",
            "Liechtenstein",
            "Lithuania",
            "Luxembourg",
        ],
        [
            "Macao",
            "Republic of Macedonia",
            "Madagascar",
            "Malawi",
            "Malaysia",
            "Maldives",
            "Mali",
            "Malta",
            "Marshall Islands",
            "Martinique",
            "Mauritania",
            "Mauritius",
            "Mexico",
            "Moldova",
            "Monaco",
            "Mongolia",
            "Montenegro",
            "Montserrat",
            "Morocco",
            "Mozambique",
            "Myanmar",
        ],
        [
            "Namibia",
            "Nauru",
            "Nepal",
            "Netherlands",
            "New Zealand",
            "Nicaragua",
            "Niger",
            "Nigeria",
            "Niue",
            "Norfolk Island",
            "Northern Mariana Islands",
            "Norway",
        ],
        [
            "Oman",
        ],
        [
            "Pakistan",
            "Palau",
            "Palestine",
            "Panama",
            "Papua New Guinea",
            "Paraguay",
            "Peru",
            "Philippines",
            "Pitcairn Islands",
            "Poland",
            "Portugal",
            "Puerto Rico",
        ],
        [
            "Qatar",
        ],
         [
            "Romania",
            "Russia",
            "Rwanda",
        ],
         [
            "Saint Barts",
            "Saint Kitts and Nevis",
            "Saint Lucia",
            "Saint Vincent and the Grenadines",
            "Samoa",
            "San Marino",
            "Sao Tome and Principe",
            "Saudi Arabia",
            "Senegal",
            "Serbia",
            "Seychelles",
            "Sierra Leone",
            "Singapore",
            "Sint Maarten",
            "Slovakia",
            "Slovenia",
            "Solomon Islands",
            "Somalia",
            "South Africa",
            "South Sudan",
            "Spain",
            "Sri Lanka",
            "Sudan",
            "Suriname",
            "Swaziland",
            "Sweden",
            "Switzerland",
        ],
        [
            "Taiwan",
            "Tajikistan",
            "Tanzania",
            "Thailand",
            "East Timor",
            "Togo",
            "Tokelau",
            "Tonga",
            "Trinidad and Tobago",
            "Tunisia",
            "Turkey",
            "Turkmenistan",
            "Turks and Caicos Islands",
            "Tuvalu",
        ],
        [
            "Uganda",
            "Ukraine",
            "United Arab Emirates",
            "United Kingdom",
            "United States of America",
            "Uruguay",
            "Uzbekistan",
        ],
        [
            "Vanuatu",
            "Venezuela",
            "Viet Nam",
            "Virgin Islands, U.S."
        ],
        [
            "Western Sahara"
        ],
        [
            "Yemen"
        ],
        [
            "Zambia",
            "Zimbabwe"
        ]
    ]
    
    let countrySearchResultController: TMDBCountrySearchResultController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.ViewControllerIdentifier.tmdbCountrySearch) as! TMDBCountrySearchResultController

    lazy var searchController: UISearchController = {
       let searchController = UISearchController(searchResultsController: countrySearchResultController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "region, country"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.delegate = self
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.section][indexPath.row]

        if let image = UIImage(named: "CountryFlags/\(countries[indexPath.section][indexPath.row])") {
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
        guard
            let userSettingCountryCode = userSetting.region?.uppercased(),
            let countrySelected = Constant.countryName[userSettingCountryCode] else { return }

        for (section, group) in countries.enumerated() {
            for (row, country) in group.enumerated() {
                if country == countrySelected {
                    selectedIndexPath = IndexPath(row: row, section: section)
                    tableView.selectRow(at: selectedIndexPath!, animated: true, scrollPosition: .top)
                    return
                }
            }
        }
    }

    @objc func doneButtonTap() {
        if
            let indexPath = countrySearchResultController.selectedIndexPath,
            let countryCode = Constant.reverseCountryName[countrySearchResultController.searchCountries[indexPath.row]] {
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

extension TMDBCountrySettingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        doneButtonTap()
    }
}
