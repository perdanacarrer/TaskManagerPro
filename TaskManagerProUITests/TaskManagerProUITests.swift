//
//  TaskManagerProUITests.swift
//  TaskManagerProUITests
//
//  Created by oscar perdana on 03/01/26.
//

import XCTest

final class TaskManagerProUITests: XCTestCase {
    func testCreateTaskFlow() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.navigationBars["My Tasks"].exists)
    }
}
