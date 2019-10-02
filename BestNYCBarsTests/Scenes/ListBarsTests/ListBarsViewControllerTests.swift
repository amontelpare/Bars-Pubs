//
//  ListBarsViewControllerTests.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import BestNYCBars
import XCTest

class ListBarsViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ListBarsViewController!
    var window: UIWindow!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupListBarsViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
    
    func setupListBarsViewController() {
      let bundle = Bundle.main
      let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "ListBarsViewController") as! ListBarsViewController)
    }
    
    func loadView() {
      window.addSubview(sut.view)
      RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class ListBarsBusinessLogicSpy: ListBarsBusinessLogic {
        var doSomethingCalled = false
      
        func listBars() {
            doSomethingCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: Spied methods
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldListBarsWhenViewIsLoaded() {
        // Given
        let spy = ListBarsBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.doSomethingCalled, "viewDidLoad() should ask the interactor to list bars.")
    }
    
    func testDisplayBars() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        let displayedBars = [ListBars.List.ViewModel.DisplayedBar(name: "The best pub", thumb: "https://image.jpg", rating: 4.0, costForTwo: "Cost:2000")]
        let viewModel = ListBars.List.ViewModel(success: true, errorTitle: nil, errorMessage: nil, displayedBars: displayedBars)
        
        // When
        sut.displayBars(viewModel: viewModel)

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched bars should reload the table view")
    }
}
