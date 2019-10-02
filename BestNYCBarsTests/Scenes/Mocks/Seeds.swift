//
//  Seeds.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

struct Seeds {
    
    struct Bars {
        static let location = Location(latitude: "40.6976701", longitude: "-74.2598694")
        static let rating = BarRating(aggregateRating: "4.3", ratingText: "Very good")
    
        static let excelentBar = Bar(name: "Bar 1", timings: "10:00-22:00", cuisines: "Argentina", thumb: "https://image.jpg", averageCostForTwo: 2500, location: location, rating: rating)
        static let goodBar =  Bar(name: "Bar 1", timings: "10:00-22:00", cuisines: "Argentina", thumb: "https://image.jpg", averageCostForTwo: 2000, location: location, rating: rating)
        static let badBar =  Bar(name: "Bar 1", timings: "10:00-22:00", cuisines: "Argentina", thumb: "https://image.jpg", averageCostForTwo: 1800, location: location, rating: rating)
    }
}
