//
//  ListBarsInteractorTests.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class ListBarsInteractorTests: XCTestCase {
    // MARK: Subject under test
    var sut: ListBarsInteractor!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupListBarsInteractor()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupListBarsInteractor() {
        sut = ListBarsInteractor()
    }
  
    // MARK: Test doubles
  
    class ListBarsPresentationLogicSpy: ListBarsPresentationLogic {
        var presentBarsCalled = false
    
        func presentBars(response: ListBars.List.Response) {
            presentBarsCalled = true
        }
    }
  
    class ListBarsWorkerSpy: ListBarsWorker {
        // MARK: Method call expectations
        
        var fetchBarsCalled = false
        
        // MARK: Spied methods
        
        override func fetchBars(category: Categories = .bars, sort: SortBy = .rating, order: SortOrder = .desc, count: Int = 15, startAt: Int, completionHandler: @escaping (() throws -> SearchBarsResponse) -> Void) {
            fetchBarsCalled = true
            completionHandler{ return SearchBarsResponse(resultsFound: 0, resultsStart: 0, resultsShown: 0, barsArrayOfDictionaries: []) }
        }
    }

    // MARK: Tests
  
    func testListBars() {
        // Given
        let listBarsPresentationLogicSpy = ListBarsPresentationLogicSpy()
        sut.presenter = listBarsPresentationLogicSpy
        let listBarsWorkerSpy = ListBarsWorkerSpy()
        sut.worker = listBarsWorkerSpy

        // When
        sut.listBars()
    
        // Then
        XCTAssert(listBarsWorkerSpy.fetchBarsCalled, "FetchBars() should ask worker to fetch bars")
        XCTAssert(listBarsPresentationLogicSpy.presentBarsCalled, "FetchBars() should ask presenter to format bars result")
    }
}

