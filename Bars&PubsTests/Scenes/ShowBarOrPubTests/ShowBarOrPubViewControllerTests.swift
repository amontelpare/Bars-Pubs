//
//  ShowBarOrPubViewControllerTests.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 23/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import Bars_Pubs
import XCTest

class ShowBarOrPubViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ShowBarOrPubViewController!
    var window: UIWindow!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupShowBarOrPubViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
    
    func setupShowBarOrPubViewController() {
      let bundle = Bundle.main
      let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "ShowBarOrPubViewController") as! ShowBarOrPubViewController)
    }
    
    func loadView() {
      window.addSubview(sut.view)
      RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class ShowBarOrPubBusinessLogicSpy: ShowBarOrPubBusinessLogic {
        var showMapCalled = false
        var showDetailsCalled = false
        
        func showMap() {
            showMapCalled = true
        }
        
        func showDetails() {
            showDetailsCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldShowMapWhenViewIsLoaded() {
      // Given
      let spy = ShowBarOrPubBusinessLogicSpy()
      sut.interactor = spy
      
      // When
      loadView()
      
      // Then
      XCTAssertTrue(spy.showMapCalled, "viewDidLoad() should ask the interactor to show map")
    }
    
    func testDisplayMap() {
        // Given
        let spy = ShowBarOrPubBusinessLogicSpy()
        sut.interactor = spy
        let viewModel = ShowBarOrPub.ShowMap.ViewModel(displayedBarOrPub: ShowBarOrPub.ShowMap.ViewModel.DisplayedBarOrPub(name: "Bar name", latitude: 40.6976701, longitude: -74.2598694))
      
        // When
        loadView()
        sut.displayMap(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.mapView.annotations.count, 1, "displayMap(viewModel:) should add map annotation")
    }
    
    func testShouldShowDetailsWhenViewIsLoaded() {
        // Given
        let spy = ShowBarOrPubBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.showDetailsCalled, "viewDidLoad() should ask the interactor to show details")
    }

    func testDisplayDetails() {
        // Given
        let spy = ShowBarOrPubBusinessLogicSpy()
        sut.interactor = spy
        let viewModel = ShowBarOrPub.ShowDetails.ViewModel(displayedBarOrPub: ShowBarOrPub.ShowDetails.ViewModel.DisplayedBarOrPub(timings: "Timings", cuisines: "Cuisines"))
        
        // When
        loadView()
        sut.displayDetails(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.timings.text, "Timings", "displayDetails(viewModel:) should update the timings label")
        XCTAssertEqual(sut.cuisines.text, "Cuisines", "displayDetails(viewModel:) should update the cuisines label")
    }
}
