//
//  ListBarsAndPubsPresenterTests.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import Bars_Pubs
import XCTest

class ListBarsAndPubsPresenterTests: XCTestCase {
  
    // MARK: Subject under test
  
    var sut: ListBarsAndPubsPresenter!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        setupListBarsAndPubsPresenter()
    }
  
    override func tearDown() {
        super.tearDown()
    }
  
    // MARK: Test setup
  
    func setupListBarsAndPubsPresenter() {
        sut = ListBarsAndPubsPresenter()
    }
  
    // MARK: Test doubles
    
    class ListBarsAndPubsDisplayLogicSpy: ListBarsAndPubsDisplayLogic {
        var displayBarsAndPubsCalled = false

        func displayBarsAndPubs(viewModel: ListBarsAndPubs.List.ViewModel) {
            displayBarsAndPubsCalled = true
        }
    }
  
    // MARK: Tests
  
    func testPresentBarsAndPubs() {
        // Given
        let spy = ListBarsAndPubsDisplayLogicSpy()
        sut.viewController = spy
        let response = ListBarsAndPubs.List.Response(barsAndPubs: [], storeError: nil)
    
        // When
        sut.presentBarsAndPubs(response: response)
    
        // Then
        XCTAssertTrue(spy.displayBarsAndPubsCalled, "presentBarsAndPubs(response:) should ask the view controller to display the result")
    }
}
