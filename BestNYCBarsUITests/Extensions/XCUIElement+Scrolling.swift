//
//  File.swift
//  BestNYCBarsUITests
//
//  Created by Andrés Montelpare on 17/10/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import XCTest

extension XCUIElement {
    func scrollTo(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}

extension XCTestCase {
    func waitWhileFirstCellsAreLoading(tableView: Any) {
        let predicate = NSPredicate(format: "cells.count > 0")
        let firstLoadExpectation = expectation(for: predicate, evaluatedWith: tableView)
        wait(for: [firstLoadExpectation], timeout: 6)
    }
}
