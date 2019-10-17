//
//  BarsApiStore.swift
//  BestNYCBarsTests
//
//  Created by Andrés Montelpare on 23/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class BarsAPIStoreTests: XCTestCase {
    var sut: BarsAPIStore!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupBarsAPIStore()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test setup

    func setupBarsAPIStore() {
        sut = BarsAPIStore()
    }

    func testFetchOrdersShouldReturnListOfOrders_InnerClosure() {
        // When
        var fetchedBars = [Bar]()
        var fetchedResponse: SearchBarsResponse? = nil
        let fetchBarsError: ListBarsStoreError? = nil
        let expect = expectation(description: "Wait for fetchBars() to return")
        
        sut.fetchBars(category: .bars, sort: .rating, order: .asc, count: 15, startAt: 0) { (searchBarsResponse: () throws -> SearchBarsResponse) -> Void in
            do {
                fetchedResponse = try searchBarsResponse()
                fetchedBars = fetchedResponse!.bars
            } catch {}
            expect.fulfill()
        }

        waitForExpectations(timeout: 6.0)

        // Then
        XCTAssertEqual(fetchedBars.count, 15, "fetchBars() should return a list of bars")
        XCTAssertNil(fetchBarsError, "fetchBars() should not return an error")
    }
}
