//
//  ShowBarOrPubPresenterTests.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 23/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class ShowBarOrPubPresenterTests: XCTestCase {
  
    // MARK: Subject under test
  
    var sut: ShowBarOrPubPresenter!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupShowBarOrPubPresenter()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupShowBarOrPubPresenter() {
        sut = ShowBarOrPubPresenter()
    }
  
    // MARK: Test doubles
    
    class ShowBarOrPubDisplayLogicSpy: ShowBarOrPubDisplayLogic {
        var displayMapCalled = false
        var displayDetailsCalled = false
        
        func displayMap(viewModel: ShowBarOrPub.ShowMap.ViewModel) {
            displayMapCalled = true
        }
        
        func displayDetails(viewModel: ShowBarOrPub.ShowDetails.ViewModel) {
            displayDetailsCalled = true
        }
    }
  
    // MARK: Tests
  
    func testPresentMap() {
        // Given
        let spy = ShowBarOrPubDisplayLogicSpy()
        sut.viewController = spy
        let response = ShowBarOrPub.ShowMap.Response(barOrPub: Seeds.BarsAndPubs.excelentBar)
    
        // When
        sut.presentMap(response: response)
    
        // Then
        XCTAssertTrue(spy.displayMapCalled, "presentMap(response:) should ask the view controller to display the result map")
    }
    
    func testPresentDetails() {
        // Given
        let spy = ShowBarOrPubDisplayLogicSpy()
        sut.viewController = spy
        let response = ShowBarOrPub.ShowDetails.Response(barOrPub: Seeds.BarsAndPubs.excelentBar)
        
        // When
        sut.presentDetails(response: response)
        
        // Then
        XCTAssertTrue(spy.displayDetailsCalled, "presentDetails(response:) should ask the view controller to display the result map")
    }
}
