//
//  ListBarsAndPubsWorkerTests.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import Bars_Pubs
import XCTest

class ListBarsAndPubsWorkerTests: XCTestCase {
    // MARK: Subject under test
    var sut: ListBarsAndPubsWorker!
    static var testBarsAndPubs: [BarOrPub]!

    // MARK: Test lifecycle
    
    override func setUp() {
      super.setUp()
      setupListBarsAndPubsWorker()
    }
    
    override func tearDown() {
      super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListBarsAndPubsWorker() {
      sut = ListBarsAndPubsWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething() {
      // Given
      
      // When
      
      // Then
    }
}
