//
//  TMDBLanguageSettingViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 6/23/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBLanguageSettingViewController: UITableViewController {
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    let header: [String] =  [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "K", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
    ]

    var languages: [[String]] = [
        [
            "Afar",
            "Abkhazian",
            "Afrikaans",
            "Akan",
            "Albanian",
            "Amharic",
            "Arabic",
            "Aragonese",
            "Armenian",
            "Assamese",
            "Avaric",
            "Avestan",
            "Aymara",
            "Azerbaijani"
        ],
        [
            "Bashkir",
            "Bambara",
            "Basque",
            "Belarusian",
            "Bengali",
            "Bihari languages",
            "Bislama",
            "Bosnian",
            "Breton",
            "Bulgarian",
            "Burmese"
        ],
        [
            "Catalan; Valencian",
            "Chamorro",
            "Chechen",
            "Chichewa",
            "Chinese",
            "Chuvash",
            "Cornish",
            "Corsican",
            "Cree",
            "Croatian",
            "Czech",
            "Central Khmer",
            "Church Slavic"
        ],
        [
            "Danish",
            "Divehi",
            "Dutch",
            "Dzongkha"
        ],
        [
            "English",
            "Esperanto",
            "Estonian",
            "Ewe"
        ],
        [
            "Faroese",
            "Fijian",
            "Finish",
            "French",
            "Fulah"
        ],
        [
            "Galician",
            "Georgian",
            "German",
            "Greek",
            "Guarani",
            "Gujarati",
            "Ganda",
        ],
        [
            "Haitian",
            "Hausa",
            "Hebrew",
            "Herero",
            "Hindi",
            "Hiri Motu",
            "Hungarian"
        ],
        [
            "Icelandic",
            "Idonesian",
            "Igbo",
            "Indonesian",
            "Inuktitut"
        ],
        [
            "Japanese",
            "Javanese"
        ],
        [
            "Kalaallisut",
            "Kannada",
            "Kanuri",
            "Kashmiri",
            "Kazakh"
        ],
        [
            "Latin",
            "Luxembourgish"
        ],
        [
            "Manx",
            "Macedonian",
            "Malagasy",
            "Malay",
            "Malayalam",
            "Maltese",
            "Maori",
            "Marathi",
            "Marshallese",
            "Mongolian"
        ],
        [
            "Naru",
            "Navajo",
            "North Ndebele",
            "Nepali",
            "Ndonga",
            "Norwegian Bokmal",
            "Norwegian Nynorsk",
            "Norwegian",
            "Northern Sami"
        ],
        [
            "Occitan",
            "Ojibwa",
            "Oromo",
            "Oriya",
            "Ossetian"
        ],
        [
            "Punjabi",
            "Pali",
            "Persian",
            "Polish",
            "Pashto",
            "Portuguese"
        ],
        [
            "Quechua"
        ],
        [
            "Romansh",
            "Rundi",
            "Romanian",
            "Russian"
        ],
        [
            "Sichuan Yi",
            "South Ndebele",
            "Sanskrit",
            "Sardinian",
            "Sindhi",
            "Samoan",
            "Sango",
            "Serbian",
            "Shona",
            "Sinhala",
            "Slovak",
            "Slovenian",
            "Somali",
            "Southern Sotho",
            "Spanish",
            "Sundanese",
            "Swahili",
            "Swati",
            "Swedish"
        ],
        [
            "Tamil",
            "Telugu",
            "Tajik",
            "Thai",
            "Tigrinya",
            "Tibetan",
            "Turkmen",
            "Tagalog",
            "Tswana",
            "Tonga",
            "Turkish",
            "Tsonga",
            "Tatar",
            "Twi",
            "Tahitian"
        ],
        [
            "Uighur",
            "Ukrainian",
            "Urdu",
            "Uzbek"
        ],
        [
            "Venda",
            "Vietnamese",
            "Volapuk"
        ],
        [
            "Walloon",
            "Welsh",
            "Wolof",
            "Western Frisian"
        ],
        [
            "Xhosa"
        ],
        [
            "Yiddish",
            "Yoruba"
        ],
        [
            "Zhuang",
            "Zulu"
        ]
    ]
    
    var selectedIndexPath: IndexPath?
    
    let languageSearchResultController: TMDBSearchResultController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.ViewControllerIdentifier.tmdbSearchController) as! TMDBSearchResultController
    
    lazy var searchController: UISearchController = {
       let searchController = UISearchController(searchResultsController: languageSearchResultController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "language"
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
        scrollToUserSettingLanguage()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return languages.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages[section].count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return header
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.languageCell, for: indexPath)
        cell.textLabel?.text = languages[indexPath.section][indexPath.row]

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
    
    func scrollToUserSettingLanguage() {
        guard
            let userSettingLanguageCode = userSetting.language?.uppercased(),
            let languageSelected = Constant.languageCode[userSettingLanguageCode] else { return }

        for (section, group) in languages.enumerated() {
            for (row, language) in group.enumerated() {
                if language == languageSelected {
                    selectedIndexPath = IndexPath(row: row, section: section)
                    tableView.scrollToRow(at: selectedIndexPath!, at: .middle, animated: true)
                }
            }
        }
    }
    
    @objc func doneButtonTap() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension TMDBLanguageSettingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        let countries = Array(Constant.languages.keys).filter { $0.contains(searchText) }

        languageSearchResultController.searches = countries
        languageSearchResultController.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}

extension TMDBLanguageSettingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        doneButtonTap()
    }
}
