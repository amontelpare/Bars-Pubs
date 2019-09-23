//
//  BarsAndPubsApiStore.swift
//  Bars&PubsTests
//
//  Created by Andrés Montelpare on 23/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

@testable import Bars_Pubs
import XCTest

class BarsAndPubsAPIStoreTests: XCTestCase {
    var sut: BarsAndPubsAPIStore!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupBarsAndPubsAPIStore()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test setup

    func setupBarsAndPubsAPIStore() {
        sut = BarsAndPubsAPIStore()
    }

    func testFetchOrdersShouldReturnListOfOrders_InnerClosure() {
        // When
        var fetchedBarsAndPubs = [BarOrPub]()
        var fetchedResponse: SearchBarsAndPubsResponse? = nil
        let fetchBarsAndPubsError: ListBarsAndPubsStoreError? = nil
        let expect = expectation(description: "Wait for fetchBarsAndPubs() to return")
        
        sut.fetchBarsAndPubs(category: .barsAndPubs, sort: .rating, order: .asc, count: 15, startAt: 0) { (searchBarsAndPubsResponse: () throws -> SearchBarsAndPubsResponse) -> Void in
            do {
                fetchedResponse = try searchBarsAndPubsResponse()
                fetchedBarsAndPubs = fetchedResponse!.barsAndPubs
            } catch {}
            expect.fulfill()
        }

        waitForExpectations(timeout: 2.0)

        // Then
        XCTAssertEqual(fetchedBarsAndPubs.count, 15, "fetchBarsAndPubs() should return a list of bars and pubs")
        XCTAssertNil(fetchBarsAndPubsError, "fetchBarsAndPubs() should not return an error")
    }
}
