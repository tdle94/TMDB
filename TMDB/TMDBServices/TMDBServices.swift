//
//  Services.swift
//  TMDB
//
//  Created by Tuyen Le on 06.06.20.
//  Copyright © 2020 Tuyen Le. All rights reserved.
//

import Foundation

struct TMDBServices {
    let session: TMDBSessionProtocol
    let urlRequestBuilder: TMDBURLRequestBuilderProtocol
}
