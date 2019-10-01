//
//  RatingWorker.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit
import Foundation

class RatingWorker {
    
    func roundToDisplayStars(rating: CGFloat) -> CGFloat {
        let roundedRating = (rating*2).rounded()/2.0
        
        return roundedRating
    }
}
