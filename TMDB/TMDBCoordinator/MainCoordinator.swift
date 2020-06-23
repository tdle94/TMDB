//
//  MainCoordinator.swift
//  TMDB
//
//  Created by Tuyen Le on 6/9/20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation
import UIKit

struct MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    func navigateToCountryVC() {
        let countryVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbCountryNavigation)
        navigationController.present(countryVC, animated: true, completion: nil)
    }
    
    func navigateToLanuageVC() {
        let languageVC = storyboard.instantiateViewController(identifier: Constant.ViewControllerIdentifier.tmdbLanguageNavigation)
        navigationController.present(languageVC, animated: true, completion: nil)
    }
}
