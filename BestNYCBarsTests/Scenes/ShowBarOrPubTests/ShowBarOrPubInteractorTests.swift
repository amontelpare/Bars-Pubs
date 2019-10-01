//
//  ShowBarOrPubInteractorTests.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 23/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class ShowBarOrPubInteractorTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ShowBarOrPubInteractor!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupShowBarOrPubInteractor()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupShowBarOrPubInteractor() {
        sut = ShowBarOrPubInteractor()
        sut.barOrPub = Seeds.BarsAndPubs.badBar
    }
  
    // MARK: Test doubles
  
    class ShowBarOrPubPresentationLogicSpy: ShowBarOrPubPresentationLogic {
        var presentMapCalled = false
        var presentDetailsCalled = false
        
        func presentMap(response: ShowBarOrPub.ShowMap.Response) {
            presentMapCalled = true
        }
        
        func presentDetails(response: ShowBarOrPub.ShowDetails.Response) {
            presentDetailsCalled = true
        }
    }
  
    // MARK: Tests
  
    func testShowMap() {
        // Given
        let spy = ShowBarOrPubPresentationLogicSpy()
        sut.presenter = spy
    
        // When
        sut.showMap()
    
        // Then
        XCTAssertTrue(spy.presentMapCalled, "showMap() should ask the presenter to format the result")
    }

    func testShowDetails() {
        // Given
        let spy = ShowBarOrPubPresentationLogicSpy()
        sut.presenter = spy
        
        // When
        sut.showDetails()
        
        // Then
        XCTAssertTrue(spy.presentDetailsCalled, "showDetails() should ask the presenter to format the result")
    }
}
