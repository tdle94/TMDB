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
    
    var userSetting: TMDBUserSettingProtocol = TMDBUserSetting()

    var repository: TMDBRepository = TMDBRepository.share
    
    lazy var releaseDate: ReleaseDateResults? = {
        guard let id = movieId else { return nil }
        return repository.getMovieReleaseDates(from: id)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Release Date", comment: "")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let id = movieId else { return 0 }
        return repository.getMovieReleaseDates(from: id)?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.releaseDateCell, for: indexPath)
        let countryCode = releaseDate?.results[indexPath.row].iso31661 ?? ""
        let countryName = userSetting.countriesCode.first(where: { $0.iso31661 == countryCode })?.name ?? ""
        let certification = releaseDate?.results[indexPath.row].releaseDates.first?.certification ?? ""
        let certificateLabel = UILabel()
        certificateLabel.font = UIFont(name: certificateLabel.font.fontName, size: 12)
        certificateLabel.text = certification != "" ? "Rated \(certification)" : ""
        certificateLabel.sizeToFit()

        cell.imageView?.image = UIImage(named: "CountryFlags/\(countryName)")?.sd_roundedCornerImage(withRadius: 5, corners: .allCorners, borderWidth: 0, borderColor: nil)?.sd_resizedImage(with: CGSize(width: 30, height: 30), scaleMode: .aspectFill)
        cell.textLabel?.text = countryName
        cell.detailTextLabel?.text = String(releaseDate?.results[indexPath.row].releaseDates.first?.releaseDate.split(separator: "T").first ?? "")
        cell.accessoryView = certificateLabel
        return cell
    }
}
