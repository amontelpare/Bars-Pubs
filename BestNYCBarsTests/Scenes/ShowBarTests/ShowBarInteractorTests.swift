//
//  ShowBarInteractorTests.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 23/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class ShowBarInteractorTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ShowBarInteractor!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupShowBarInteractor()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupShowBarInteractor() {
        sut = ShowBarInteractor()
        sut.bar = Seeds.Bars.badBar
    }
  
    // MARK: Test doubles
  
    class ShowBarPresentationLogicSpy: ShowBarPresentationLogic {
        var presentMapCalled = false
        var presentDetailsCalled = false
        
        func presentMap(response: ShowBar.ShowMap.Response) {
            presentMapCalled = true
        }
        
        func presentDetails(response: ShowBar.ShowDetails.Response) {
            presentDetailsCalled = true
        }
    }
  
    // MARK: Tests
  
    func testShowMap() {
        // Given
        let spy = ShowBarPresentationLogicSpy()
        sut.presenter = spy
    
        // When
        sut.showMap()
    
        // Then
        XCTAssertTrue(spy.presentMapCalled, "showMap() should ask the presenter to format the result")
    }

    func testShowDetails() {
        // Given
        let spy = ShowBarPresentationLogicSpy()
        sut.presenter = spy
        
        // When
        sut.showDetails()
        
        // Then
        XCTAssertTrue(spy.presentDetailsCalled, "showDetails() should ask the presenter to format the result")
    }
}
