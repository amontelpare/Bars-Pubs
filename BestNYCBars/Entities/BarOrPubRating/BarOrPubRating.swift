//
//  BarOrPubRating.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

struct BarOrPubRating {
    var aggregateRating: String
    let ratingText: String
    
    var aggregateRatingCGFloat: CGFloat { get { return CGFloat((aggregateRating as NSString).floatValue)} }
    
    mutating func roundAggregateRating(_aggregateRatingCGFloat: CGFloat) {
        aggregateRating = String(format: "%.1f", _aggregateRatingCGFloat)
    }
}

extension BarOrPubRating: Decodable {
    enum CodingKeys: String, CodingKey {
        case aggregateRating = "aggregate_rating"
        case ratingText = "rating_text"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            aggregateRating = try container.decodeIfPresent(String.self, forKey: .aggregateRating)!
        } catch {
            let agregateRatingDouble = try container.decodeIfPresent(Double.self, forKey: .aggregateRating)
            aggregateRating = String(format: "%.1f", agregateRatingDouble!)
        }
        ratingText = try container.decodeIfPresent(String.self, forKey: .ratingText)!
    }
}
