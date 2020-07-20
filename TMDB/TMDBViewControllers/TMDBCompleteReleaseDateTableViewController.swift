//
//  TMDBCompleteReleaseDateViewController.swift
//  TMDB
//
//  Created by Tuyen Le on 19.07.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

class TMDBCompleteReleaseDateTableViewController: UITableViewController {
    var movieId: Int?
    
    var repository: TMDBRepositoryProtocol!
    
    lazy var releaseDate: ReleaseDateResults? = {
        guard let id = movieId else { return nil }
        return repository.getMovieReleaseDates(from: id)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Release Date", comment: "")
        repository = TMDBRepository(services: TMDBServices(session: TMDBSession(session: URLSession.shared),
                                                           urlRequestBuilder: TMDBURLRequestBuilder()),
                                    localDataSource: TMDBLocalDataSource(),
                                    userSetting: TMDBUserSetting())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let id = movieId else { return 0 }
        return repository.getMovieReleaseDates(from: id)?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.releaseDateCell, for: indexPath)
        let countryCode = releaseDate?.results[indexPath.row].iso31661 ?? ""
        let countryName = Constant.countryName[countryCode] ?? ""
        cell.imageView?.image = UIImage(named: "CountryFlags/\(countryName)")?.sd_roundedCornerImage(withRadius: 5, corners: .allCorners, borderWidth: 0, borderColor: nil)?.sd_resizedImage(with: CGSize(width: 30, height: 30), scaleMode: .aspectFill)
        cell.textLabel?.text = String(releaseDate?.results[indexPath.row].releaseDates.first?.releaseDate.split(separator: "T").first ?? "")
        cell.detailTextLabel?.text = releaseDate?.results[indexPath.row].releaseDates.first?.certification
        return cell
    }
}
