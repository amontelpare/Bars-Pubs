//
//  BarOrPub.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

struct BarOrPub {
    let name: String
    let timings: String
    let cuisines: String
    let thumb: String
    let averageCostForTwo: Int
    let location: Location
    var rating: BarOrPubRating
    
    mutating func roundRating(ratingRounded: CGFloat) {
        rating.roundAggregateRating(_aggregateRatingCGFloat: ratingRounded)
    }
}

extension BarOrPub: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case timings
        case cuisines
        case thumb
        case location
        case averageCostForTwo = "average_cost_for_two"
        case rating = "user_rating"
    }
}

extension BarOrPub: Equatable {
    
    static func ==(lhs: BarOrPub, rhs: BarOrPub) -> Bool {
        return lhs.name == rhs.name
            && lhs.timings == rhs.timings
            && lhs.averageCostForTwo == rhs.averageCostForTwo
            && lhs.cuisines == rhs.cuisines
            && lhs.thumb == rhs.thumb
    }
}

