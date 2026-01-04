//
//  TaskManagerProUITests.swift
//  TaskManagerProUITests
//
//  Created by oscar perdana on 03/01/26.
//

import XCTest

final class TaskManagerProUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("UITEST_MODE")
        app.launch()
    }

    func testCreateTaskFlow() {
        app.buttons["plus"].tap()

        let titleField = app.textFields["Title"]
        titleField.tap()
        titleField.typeText("UI Test Task")

        let detailsField = app.textViews.firstMatch
        detailsField.tap()
        detailsField.typeText("Details")

        app.buttons["Save"].tap()

        XCTAssertTrue(app.staticTexts["UI Test Task"].exists)
    }

    func testMarkTaskCompleted() {
        let app = XCUIApplication()
        app.launchArguments.append("UITEST_MODE")
        app.launch()

        let task = app.staticTexts["UI Test Task"]
        XCTAssertTrue(task.waitForExistence(timeout: 5))
        task.tap()

        let completionToggle = app.switches["Completion"]
        XCTAssertTrue(completionToggle.waitForExistence(timeout: 5))
        completionToggle.tap()

        app.navigationBars.buttons.element(boundBy: 0).tap()

        XCTAssertTrue(
            app.images["completed_icon"]
                .waitForExistence(timeout: 5)
        )
    }

    func testSearchTask() {
        let app = XCUIApplication()
        app.launchArguments.append("UITEST_MODE")
        app.launch()

        let navBar = app.navigationBars["My Tasks"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))

        let list = app.otherElements["task_list"].firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 5))
        list.swipeDown()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))

        searchField.tap()
        searchField.typeText("Tugas") // Change the text to text in CoreData Title

        XCTAssertTrue(
            app.staticTexts["Tugas 1"]
                .waitForExistence(timeout: 5) // Change the text to text in CoreData Title
        )
    }
}
