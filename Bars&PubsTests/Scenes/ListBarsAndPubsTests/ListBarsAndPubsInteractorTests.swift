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
  
//    class ListBarsAndPubsPresentationLogicSpy: ListBarsAndPubsPresentationLogic {
//        var presentSomethingCalled = false
//    
//        func presentSomething(response: ListBarsAndPubs.Something.Response) {
//            presentSomethingCalled = true
//        }
//    }
//  
//    // MARK: Tests
//  
//    func testDoSomething() {
//        // Given
//        let spy = ListBarsAndPubsPresentationLogicSpy()
//        sut.presenter = spy
//        let request = ListBarsAndPubs.Something.Request()
//    
//        // When
//        sut.doSomething(request: request)
//    
//        // Then
//        XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
//    }
}
