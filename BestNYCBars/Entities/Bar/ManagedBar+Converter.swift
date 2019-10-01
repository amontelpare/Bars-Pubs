//
//  ManagedBar+Properties.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import Foundation
import CoreData

extension ManagedBar {
    
    func toBar() -> Bar {
        return Bar(name: name!, timings: timings!, cuisines: cuisines!, thumb: thumb!, averageCostForTwo: Int(averageCostForTwo), location: Location(latitude: latitude!, longitude: longitude!), rating: BarRating(aggregateRating: aggregateRating!, ratingText: ratingText!))
    }
    
    func fromBar(bar: Bar) {
        name = bar.name
        timings = bar.timings
        cuisines = bar.cuisines
        thumb = bar.thumb
        averageCostForTwo = Int16(bar.averageCostForTwo)
        latitude = bar.location.latitude
        longitude = bar.location.longitude
        ratingText = bar.rating.ratingText
        aggregateRating = bar.rating.aggregateRating
    }
}
