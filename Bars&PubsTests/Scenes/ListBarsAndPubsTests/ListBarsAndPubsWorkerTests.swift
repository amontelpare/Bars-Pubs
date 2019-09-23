//
//  ListBarsAndPubsWorkerTests.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import Bars_Pubs
import XCTest

class ListBarsAndPubsWorkerTests: XCTestCase {
    // MARK: Subject under test
    var sut: ListBarsAndPubsWorker!
    static var testBarsAndPubs: [[String:BarOrPub]]!

    // MARK: Test lifecycle
    
    override func setUp() {
      super.setUp()
      setupListBarsAndPubsWorker()
    }
    
    override func tearDown() {
      super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListBarsAndPubsWorker() {
        sut = ListBarsAndPubsWorker(listBarsAndPubsStore: BarsAndPubsApiStoreSpy())
        ListBarsAndPubsWorkerTests.testBarsAndPubs = [["restaurant":Seeds.BarsAndPubs.excelentBar], ["restaurant":Seeds.BarsAndPubs.goodBar], ["restaurant":Seeds.BarsAndPubs.badBar]]

    }
    
    // MARK: Test doubles
    
    class BarsAndPubsApiStoreSpy: BarsAndPubsAPIStore {
        // MARK: Method call expectations
        
        var fetchBarsAndPubsCalled = false
        
        // MARK: Spied methods
        
        override func fetchBarsAndPubs(category: Categories, sort: SortBy, order: SortOrder, count: Int, startAt: Int, completionHandler: @escaping (() throws -> SearchBarsAndPubsResponse) -> Void) {
            fetchBarsAndPubsCalled = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler { () -> SearchBarsAndPubsResponse in
                    return SearchBarsAndPubsResponse(resultsFound: 100, resultsStart: startAt, resultsShown: count, barsAndPubsArrayOfDictionaries: ListBarsAndPubsWorkerTests.testBarsAndPubs)
                }
            }
        }
    }

    
    // MARK: Tests
    
    func testFetchBarsAndPubsShouldReturnSearchBarsAndPubsResponse() {
        // Given
        let barsAndPubsApiStoreSpy = sut.listBarsAndPubsStore as! BarsAndPubsApiStoreSpy
        
        // When
        var fetchedSearchResponse: SearchBarsAndPubsResponse? = nil
        let expect = expectation(description: "Wait for fetchedBarsAndPubs() to return")
        sut.fetchBarsAndPubs(startAt: 0, completionHandler: { (response) in
            do {
                fetchedSearchResponse = try response()
                expect.fulfill()
            } catch {
            }
        })
        
        waitForExpectations(timeout: 1.1)
        
        // Then
        XCTAssert(barsAndPubsApiStoreSpy.fetchBarsAndPubsCalled, "Calling fetchBarsAndPubs() should ask the data store for a SearchBarsAndPubsResponse object")
        XCTAssertEqual(fetchedSearchResponse?.barsAndPubs.count, ListBarsAndPubsWorkerTests.testBarsAndPubs.count, "fetchBarsAndPubs().barsAndPubs should return a list of bars and pubs")
        for barOrPub in fetchedSearchResponse!.barsAndPubs {
            let barsAndPubs = ListBarsAndPubsWorkerTests.testBarsAndPubs.flatMap {[BarOrPub]($0.values)}
            XCTAssert(barsAndPubs.contains(barOrPub), "Fetched bars and pubs should match the bars and pubs in the data store")
        }
    }
}
