//
//  ListBarsAndPubsViewControllerTests.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

@testable import Bars_Pubs
import XCTest

class ListBarsAndPubsViewControllerTests: XCTestCase {
    // MARK: Subject under test
  
    var sut: ListBarsAndPubsViewController!
    var window: UIWindow!
  
    // MARK: Test lifecycle
  
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupListBarsAndPubsViewController()
    }
  
    override func tearDown() {
        window = nil
        super.tearDown()
    }
  
    // MARK: Test setup
    
    func setupListBarsAndPubsViewController() {
      let bundle = Bundle.main
      let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "ListBarsAndPubsViewController") as! ListBarsAndPubsViewController)
    }
    
    func loadView() {
      window.addSubview(sut.view)
      RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class ListBarsAndPubsBusinessLogicSpy: ListBarsAndPubsBusinessLogic {
        var doSomethingCalled = false
      
        func listBarsAndPubs() {
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
    
    func testShouldListBarsAndPubsWhenViewIsLoaded() {
        // Given
        let spy = ListBarsAndPubsBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.doSomethingCalled, "viewDidLoad() should ask the interactor to list bars and pubs.")
    }
    
    func testDisplayBarsOrPubs() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        let displayedBarsAndPubs = [ListBarsAndPubs.List.ViewModel.DisplayedBarOrPub(name: "The best pub", thumb: "https://image.jpg", rating: 4.0, costForTwo: "Cost:2000")]
        let viewModel = ListBarsAndPubs.List.ViewModel(success: true, errorTitle: nil, errorMessage: nil, displayedBarsOrPubs: displayedBarsAndPubs)
        
        // When
        sut.displayBarsAndPubs(viewModel: viewModel)

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched bars and pubs should reload the table view")
    }
}
