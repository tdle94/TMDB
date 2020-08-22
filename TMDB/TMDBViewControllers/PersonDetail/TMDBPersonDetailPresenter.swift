//
//  TMDBPersonDetailDisplay.swift
//  TMDB
//
//  Created by Tuyen Le on 14.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

protocol TMDBPersonDetailDelegate: NSObjectProtocol {
    func displayPerson(person: People)
    func displayMovieCredit(movies: [Movie])
    func displayTVShowCredit(tvShows: [TVShow])
}

class TMDBPersonDetailPresenter {
    let repository: TMDBRepository = TMDBRepository.share

    private weak var personDetailDelegate: TMDBPersonDetailDelegate?

    init(delegate: TMDBPersonDetailDelegate) {
        personDetailDelegate = delegate
    }

    func getPersonDetail(id: Int) {
        repository.getPersonDetail(id: id) { result in
            switch result {
            case .failure(let error):
                debugPrint(error.localizedDescription)
            case .success(let person):
                self.personDetailDelegate?.displayPerson(person: person)
            }
        }
    }

    func getMovieCredit(personId: Int) {
        let movies = repository.getMovieCredits(from: personId)
        personDetailDelegate?.displayMovieCredit(movies: movies)
    }

    func getTVShowCredit(personId: Int) {
        let tvShows = repository.getTVCredits(from: personId)
        personDetailDelegate?.displayTVShowCredit(tvShows: tvShows)
    }
}
