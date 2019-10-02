//
//  ListBarsWorkerTests.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class ListBarsWorkerTests: XCTestCase {
    // MARK: Subject under test
    var sut: ListBarsWorker!
    static var testBars: [[String:Bar]]!

    // MARK: Test lifecycle
    
    override func setUp() {
      super.setUp()
      setupListBarsWorker()
    }
    
    override func tearDown() {
      super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListBarsWorker() {
        sut = ListBarsWorker(listBarsStore: BarsApiStoreSpy())
        ListBarsWorkerTests.testBars = [["restaurant":Seeds.Bars.excelentBar], ["restaurant":Seeds.Bars.goodBar], ["restaurant":Seeds.Bars.badBar]]

    }
    
    // MARK: Test doubles
    
    class BarsApiStoreSpy: BarsAPIStore {
        // MARK: Method call expectations
        
        var fetchBarsCalled = false
        
        // MARK: Spied methods
        
        override func fetchBars(category: Categories, sort: SortBy, order: SortOrder, count: Int, startAt: Int, completionHandler: @escaping (() throws -> SearchBarsResponse) -> Void) {
            fetchBarsCalled = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                completionHandler { () -> SearchBarsResponse in
                    return SearchBarsResponse(resultsFound: 100, resultsStart: startAt, resultsShown: count, barsArrayOfDictionaries: ListBarsWorkerTests.testBars)
                }
            }
        }
    }

    
    // MARK: Tests
    
    func testFetchBarsShouldReturnSearchBarsResponse() {
        // Given
        let barsApiStoreSpy = sut.listBarsStore as! BarsApiStoreSpy
        
        // When
        var fetchedSearchResponse: SearchBarsResponse? = nil
        let expect = expectation(description: "Wait for fetchedBars() to return")
        sut.fetchBars(startAt: 0, completionHandler: { (response) in
            do {
                fetchedSearchResponse = try response()
                expect.fulfill()
            } catch {
            }
        })
        
        waitForExpectations(timeout: 1.1)
        
        // Then
        XCTAssert(barsApiStoreSpy.fetchBarsCalled, "Calling fetchBars() should ask the data store for a SearchBarsResponse object")
        XCTAssertEqual(fetchedSearchResponse?.bars.count, ListBarsWorkerTests.testBars.count, "fetchBars().bars should return a list of bars")
        for bar in fetchedSearchResponse!.bars {
            let bars = ListBarsWorkerTests.testBars.flatMap {[Bar]($0.values)}
            XCTAssert(bars.contains(bar), "Fetched bars should match the bars in the data store")
        }
    }
}
