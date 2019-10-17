//
//  BestNYCBarsUITests.swift
//  BestNYCBarsUITests
//
//  Created by Andrés Montelpare on 01/10/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import XCTest
@testable import BestNYCBars

class ListBarsSceneUITests: XCTestCase {
    let app = XCUIApplication()
    lazy var tableView = app.tables[UITest.barsTableView.rawValue]


    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testLoadingIsShown() {
        let activityIndicator = app.otherElements.containing(.activityIndicator, identifier: UITest.barsTableViewLoading.rawValue).element
        
        XCTAssertTrue(activityIndicator.exists, "Loading was not shown")
    }
    
    func testTableViewIsShown() {
        let tableViewExistsAndIsHittable: Bool = tableView.exists && tableView.isHittable
        
        XCTAssertTrue(tableViewExistsAndIsHittable, "Table view was not shown")
    }
    
    func testLoadingMoreWhenScrollToBottom() {
        waitWhileFirstCellsAreLoading()
        let tableViewElementsCount = tableView.cells.count
        let lastCellIdentifier = String(format:UITest.barTableViewCell.rawValue, (tableViewElementsCount - 1))
        let lastCell = tableView.cells[lastCellIdentifier]
        tableView.scrollTo(element: lastCell)
        let tableViewElementsNewCount = tableView.cells.count
        
        XCTAssertTrue(tableViewElementsCount < tableViewElementsNewCount, "Table view is not fetching more bars when it scroll to bottom")
    }
    
    func testTableViewIteraction() {
        waitWhileFirstCellsAreLoading()
        let cells = tableView.cells
        
        if cells.count > 0 {
            let count: Int = (cells.count - 1)
            let promise = expectation(description: "Wait for table cells")
         
            for i in stride(from: 0, to: count , by: 1) {
                let tableCell = cells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
                tableCell.tap()
         
                if i == (count - 1) {
                    promise.fulfill()
                }
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }
    
    // Mark: Private
    
    private func waitWhileFirstCellsAreLoading() {
        let predicate = NSPredicate(format: "cells.count > 0")
        let firstLoadExpectation = expectation(for: predicate, evaluatedWith: tableView)
        wait(for: [firstLoadExpectation], timeout: 6)
    }
}

