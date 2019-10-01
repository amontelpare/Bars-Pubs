//
//  ShowBarPresenterTests.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 23/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class ShowBarPresenterTests: XCTestCase {
  
    // MARK: Subject under test
  
    var sut: ShowBarPresenter!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupShowBarPresenter()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupShowBarPresenter() {
        sut = ShowBarPresenter()
    }
  
    // MARK: Test doubles
    
    class ShowBarDisplayLogicSpy: ShowBarDisplayLogic {
        var displayMapCalled = false
        var displayDetailsCalled = false
        
        func displayMap(viewModel: ShowBar.ShowMap.ViewModel) {
            displayMapCalled = true
        }
        
        func displayDetails(viewModel: ShowBar.ShowDetails.ViewModel) {
            displayDetailsCalled = true
        }
    }
  
    // MARK: Tests
  
    func testPresentMap() {
        // Given
        let spy = ShowBarDisplayLogicSpy()
        sut.viewController = spy
        let response = ShowBar.ShowMap.Response(bar: Seeds.Bars.excelentBar)
    
        // When
        sut.presentMap(response: response)
    
        // Then
        XCTAssertTrue(spy.displayMapCalled, "presentMap(response:) should ask the view controller to display the result map")
    }
    
    func testPresentDetails() {
        // Given
        let spy = ShowBarDisplayLogicSpy()
        sut.viewController = spy
        let response = ShowBar.ShowDetails.Response(bar: Seeds.Bars.excelentBar)
        
        // When
        sut.presentDetails(response: response)
        
        // Then
        XCTAssertTrue(spy.displayDetailsCalled, "presentDetails(response:) should ask the view controller to display the result map")
    }
}
