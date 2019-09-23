//
//  Seeds.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import Bars_Pubs
import XCTest

struct Seeds {
    
    struct BarsAndPubs {
        static let location = Location(latitude: "40.6976701", longitude: "-74.2598694")
        static let rating = BarOrPubRating(aggregateRating: "4.3", ratingText: "Very good")
    
        static let excelentBar = BarOrPub(name: "Bar 1", timings: "10:00-22:00", cuisines: "Argentina", thumb: "https://image.jpg", averageCostForTwo: 2500, location: location, rating: rating)
        static let goodBar =  BarOrPub(name: "Bar 1", timings: "10:00-22:00", cuisines: "Argentina", thumb: "https://image.jpg", averageCostForTwo: 2000, location: location, rating: rating)
        static let badBar =  BarOrPub(name: "Bar 1", timings: "10:00-22:00", cuisines: "Argentina", thumb: "https://image.jpg", averageCostForTwo: 1800, location: location, rating: rating)
    }
}
