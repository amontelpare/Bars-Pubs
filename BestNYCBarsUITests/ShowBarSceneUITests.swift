//
//  ShowBarSceneUITests.swift
//  BestNYCBarsUITests
//
//  Created by Andrés Montelpare on 17/10/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import XCTest

class ShowBarSceneUITests: XCTestCase {
    let app = XCUIApplication()
    lazy var tableView = app.tables[UITestKeys.barsTableView.rawValue]

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
        waitWhileFirstCellsAreLoading(tableView: tableView)

        let cells = tableView.cells
        let tableCell = cells.element(boundBy: 0)
        XCTAssertTrue(tableCell.exists, "The \(0) cell is in place on the table")
        tableCell.tap()
    }

    func testMapViewExists() {
        let mapView = app.maps.element(boundBy: 0)
        XCTAssertTrue(mapView.exists, "Map was not displayed")
    }
}
