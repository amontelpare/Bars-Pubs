//
//  ListBarsAndPubsInteractorTests.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import Bars_Pubs
import XCTest

class ListBarsAndPubsInteractorTests: XCTestCase {
    // MARK: Subject under test
    var sut: ListBarsAndPubsInteractor!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupListBarsAndPubsInteractor()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupListBarsAndPubsInteractor() {
        sut = ListBarsAndPubsInteractor()
    }
  
    // MARK: Test doubles
  
    class ListBarsAndPubsPresentationLogicSpy: ListBarsAndPubsPresentationLogic {
        var presentBarsAndPubsCalled = false
    
        func presentBarsAndPubs(response: ListBarsAndPubs.List.Response) {
            presentBarsAndPubsCalled = true
        }
    }
  
    class ListBarsAndPubsWorkerSpy: ListBarsAndPubsWorker {
        // MARK: Method call expectations
        
        var fetchBarsAndPubsCalled = false
        
        // MARK: Spied methods
        
        override func fetchBarsAndPubs(category: Categories = .barsAndPubs, sort: SortBy = .rating, order: SortOrder = .desc, count: Int = 15, startAt: Int, completionHandler: @escaping (() throws -> SearchBarsAndPubsResponse) -> Void) {
            fetchBarsAndPubsCalled = true
            completionHandler{ return SearchBarsAndPubsResponse(resultsFound: 0, resultsStart: 0, resultsShown: 0, barsAndPubsArrayOfDictionaries: []) }
        }
    }

    // MARK: Tests
  
    func testListBarsAndPubs() {
        // Given
        let listBarsAndPubsPresentationLogicSpy = ListBarsAndPubsPresentationLogicSpy()
        sut.presenter = listBarsAndPubsPresentationLogicSpy
        let listBarsAndPubsWorkerSpy = ListBarsAndPubsWorkerSpy()
        sut.worker = listBarsAndPubsWorkerSpy

        // When
        sut.listBarsAndPubs()
    
        // Then
        XCTAssert(listBarsAndPubsWorkerSpy.fetchBarsAndPubsCalled, "FetchBarsAndPubs() should ask worker to fetch bars and pubs")
        XCTAssert(listBarsAndPubsPresentationLogicSpy.presentBarsAndPubsCalled, "FetchBarsAndPubs() should ask presenter to format bars and pubs result")
    }
}

