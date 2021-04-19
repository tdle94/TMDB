//
//  TMDBObject.swift
//  TMDB
//
//  Created by Tuyen Le on 2/19/21.
//  Copyright © 2021 Tuyen Le. All rights reserved.
//

import RealmSwift

extension Object {
    
    var displayTitle: String {
        if self is Movie {
            return (self as? Movie)?.originalTitle ?? ""
        } else if self is Trending {
            return (self as? Trending)?.movie?.originalTitle ?? (self as? Trending)?.tv?.originalName ?? (self as? Trending)?.people?.name ?? ""
        } else if self is TVShow {
            return (self as? TVShow)?.originalName ?? ""
        } else if self is People {
            return (self as? People)?.name ?? ""
        } else if self is Crew {
            return (self as? Crew)?.name ?? ""
        } else if self is Cast {
            return (self as? Cast)?.name ?? ""
        } else if self is CreatedBy {
            return (self as? CreatedBy)?.name ?? ""
        }
        return ""
    }
    
    var displaySubtitle: String {
        if self is Movie {
            return (self as? Movie)?.releaseDate ?? ""
        } else if self is Trending {
            return (self as? Trending)?.movie?.releaseDate ?? (self as? Trending)?.tv?.firstAirDate ?? (self as? Trending)?.people?.knownForDepartment ?? ""
        } else if self is TVShow {
            return (self as? TVShow)?.firstAirDate ?? ""
        } else if self is People {
            return (self as? People)?.knownForDepartment ?? ""
        } else if self is Crew {
            return (self as? Crew)?.job ?? ""
        } else if self is Cast {
            return (self as? Cast)?.character ?? ""
        } else if self is CreatedBy {
            return (self as? CreatedBy)?.name ?? ""
        }
        return ""
    }
    
    var displayRating: Double {
        if self is Movie {
            return (self as? Movie)?.voteAverage ?? 0.0
        } else if self is Trending {
            return (self as? Trending)?.movie?.voteAverage ?? (self as? Trending)?.tv?.voteAverage ?? (self as? Trending)?.people?.popularity ?? 0.0
        } else if self is TVShow {
            return (self as? TVShow)?.voteAverage ?? 0.0
        } else if self is People {
            return (self as? People)?.popularity ?? 0.0
        } else if self is Crew {
            return (self as? Crew)?.popularity ?? 0.0
        } else if self is Cast {
            return (self as? Cast)?.popularity ?? 0.0
        }
        return 0.0
    }
    
    var imagePath: String? {
        if self is Movie {
            return (self as? Movie)?.posterPath
        } else if self is Trending {
            return (self as? Trending)?.movie?.posterPath ?? (self as? Trending)?.tv?.posterPath ?? (self as? Trending)?.people?.profilePath
        } else if self is TVShow {
            return (self as? TVShow)?.posterPath
        } else if self is People {
            return (self as? People)?.profilePath
        } else if self is Crew {
            return (self as? Crew)?.profilePath
        } else if self is Cast {
            return (self as? Cast)?.profilePath
        } else if self is CreatedBy {
            return (self as? CreatedBy)?.profilePath
        } else if self is ProductionCompany {
            return (self as? ProductionCompany)?.logoPath
        } else if self is Images {
            return (self as? Images)?.filePath
        }
        return nil
    }
    
    var hideRatingLabel: Bool {
        return self is ProductionCompany || self is CreatedBy || self is Images
    }
}
