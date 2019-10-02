//
//  Bar.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

struct Bar {
    let name: String
    let timings: String
    let cuisines: String
    let thumb: String
    let averageCostForTwo: Int
    let location: Location
    var rating: BarRating
    
    mutating func roundRating(ratingRounded: CGFloat) {
        rating.roundAggregateRating(_aggregateRatingCGFloat: ratingRounded)
    }
}

extension Bar: Decodable {
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

extension Bar: Equatable {
    
    static func ==(lhs: Bar, rhs: Bar) -> Bool {
        return lhs.name == rhs.name
            && lhs.timings == rhs.timings
            && lhs.averageCostForTwo == rhs.averageCostForTwo
            && lhs.cuisines == rhs.cuisines
            && lhs.thumb == rhs.thumb
    }
}

