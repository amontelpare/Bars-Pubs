//
//  ListBarsPresenterTests.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class ListBarsPresenterTests: XCTestCase {
  
    // MARK: Subject under test
  
    var sut: ListBarsPresenter!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupListBarsPresenter()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupListBarsPresenter() {
        sut = ListBarsPresenter()
    }
  
    // MARK: Test doubles
    
    class ListBarsDisplayLogicSpy: ListBarsDisplayLogic {
        var displayBarsCalled = false

        func displayBars(viewModel: ListBars.List.ViewModel) {
            displayBarsCalled = true
        }
    }
  
    // MARK: Tests
  
    func testPresentBars() {
        // Given
        let spy = ListBarsDisplayLogicSpy()
        sut.viewController = spy
        let response = ListBars.List.Response(bars: [], storeError: nil)
    
        // When
        sut.presentBars(response: response)
    
        // Then
        XCTAssertTrue(spy.displayBarsCalled, "presentBars(response:) should ask the view controller to display the result")
    }
}
