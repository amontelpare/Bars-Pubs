//
//  ManagedBarOrPub+Properties.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import Foundation
import CoreData

extension ManagedBarOrPub {
    
    func toBarOrPub() -> BarOrPub {
        return BarOrPub(name: name!, timings: timings!, cuisines: cuisines!, thumb: thumb!, averageCostForTwo: Int(averageCostForTwo), location: Location(latitude: latitude!, longitude: longitude!), rating: BarOrPubRating(aggregateRating: aggregateRating!, ratingText: ratingText!))
    }
    
    func fromBarOrPub(barOrPub: BarOrPub) {
        name = barOrPub.name
        timings = barOrPub.timings
        cuisines = barOrPub.cuisines
        thumb = barOrPub.thumb
        averageCostForTwo = Int16(barOrPub.averageCostForTwo)
        latitude = barOrPub.location.latitude
        longitude = barOrPub.location.longitude
        ratingText = barOrPub.rating.ratingText
        aggregateRating = barOrPub.rating.aggregateRating
    }
}
