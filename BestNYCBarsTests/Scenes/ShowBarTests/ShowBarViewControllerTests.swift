//
//  ShowBarViewControllerTests.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 23/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class ShowBarViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ShowBarViewController!
    var window: UIWindow!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupShowBarViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
    
    func setupShowBarViewController() {
      let bundle = Bundle.main
      let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "ShowBarViewController") as! ShowBarViewController)
    }
    
    func loadView() {
      window.addSubview(sut.view)
      RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class ShowBarBusinessLogicSpy: ShowBarBusinessLogic {
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
      let spy = ShowBarBusinessLogicSpy()
      sut.interactor = spy
      
      // When
      loadView()
      
      // Then
      XCTAssertTrue(spy.showMapCalled, "viewDidLoad() should ask the interactor to show map")
    }
    
    func testDisplayMap() {
        // Given
        let spy = ShowBarBusinessLogicSpy()
        sut.interactor = spy
        let viewModel = ShowBar.ShowMap.ViewModel(displayedBar: ShowBar.ShowMap.ViewModel.DisplayedBar(name: "Bar name", latitude: 40.6976701, longitude: -74.2598694))
      
        // When
        loadView()
        sut.displayMap(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.mapView.annotations.count, 1, "displayMap(viewModel:) should add map annotation")
    }
    
    func testShouldShowDetailsWhenViewIsLoaded() {
        // Given
        let spy = ShowBarBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.showDetailsCalled, "viewDidLoad() should ask the interactor to show details")
    }

    func testDisplayDetails() {
        // Given
        let spy = ShowBarBusinessLogicSpy()
        sut.interactor = spy
        let viewModel = ShowBar.ShowDetails.ViewModel(displayedBar: ShowBar.ShowDetails.ViewModel.DisplayedBar(name: "Bar name", timings: "Timings", cuisines: "Cuisines"))
        
        // When
        loadView()
        sut.displayDetails(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.timings.text, "Timings", "displayDetails(viewModel:) should update the timings label")
        XCTAssertEqual(sut.cuisines.text, "Cuisines", "displayDetails(viewModel:) should update the cuisines label")
        XCTAssertEqual(sut.title, "Bar name", "displayDetails(viewModel:) should update the title label")
    }
}
