//
//  ViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 04.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import UIKit
import RealmSwift
class TMDBHomeViewController: UIViewController {
    
    // MARK: - coordinator
    var coordinator: MainCoordinator?

    // MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constant.Color.backgroundColor
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}

