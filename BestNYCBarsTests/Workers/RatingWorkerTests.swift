//
//  RatingWorkerTests.swift
//  BestNYCBarsTests
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class RatingWorkerTests: XCTestCase {

    func testRoundDown() {
        let ratingWorker = RatingWorker()
        let rating:CGFloat = 4.1
        let roundedRating = ratingWorker.roundToDisplayStars(rating: rating)
        
        XCTAssertEqual(roundedRating, 4.0)
    }
    
    func testRounpUp() {
        let ratingWorker = RatingWorker()
        let rating:CGFloat = 4.9
        let roundedRating = ratingWorker.roundToDisplayStars(rating: rating)
        
        XCTAssertEqual(roundedRating, 5.0)
    }

    func testRounpMiddle() {
        let ratingWorker = RatingWorker()
        let rating:CGFloat = 4.6
        let roundedRating = ratingWorker.roundToDisplayStars(rating: rating)
        
        XCTAssertEqual(roundedRating, 4.5)
    }
}
