//
//  TMDBPeopleDetailViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 13.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBPersonDetailViewController: UIViewController {
    var repository: TMDBRepositoryProtocol!
    var personId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        repository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                           urlRequestBuilder: TMDBURLRequestBuilder()),
                                    localDataSource: TMDBLocalDataSource(),
                                    userSetting: TMDBUserSetting())
    }

    func getPersonDetail() {
        guard let id = personId else { return }
        repository.getPersonDetail(id: id) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let person):
                break
            }
        }
    }
}
