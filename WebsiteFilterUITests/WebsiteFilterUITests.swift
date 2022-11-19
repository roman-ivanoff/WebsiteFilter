//
//  WebsiteFilterUITests.swift
//  WebsiteFilterUITests
//
//  Created by Roman Ivanov on 19.11.2022.
//

import XCTest
@testable import WebsiteFilter

final class WebsiteFilterUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testWebViewWork() {
        let textfield = app.textFields["linkTextField"]
        textfield.tap()
        textfield.typeText("google.com")
        app.keyboards.buttons["go"].tap()

        XCTAssertTrue(app.webViews["webWiew"].exists)
    }

    func testIncorrectLinkAlert() {

        let textfield = app.textFields["linkTextField"]
        textfield.tap()
        textfield.typeText("googl")
        app.keyboards.buttons["go"].tap()

        XCTAssertTrue(app.alerts["Error"].exists)

        app.alerts["Error"].scrollViews.otherElements.buttons["OK"].tap()

        XCTAssertTrue(textfield.exists)

    }

    func testTextFieldAlertAppears() {
        app.toolbars["Toolbar"].children(matching: .other)
            .element.children(matching: .other).element
            .children(matching: .button).element(boundBy: 0).tap()

       XCTAssertTrue(app.alerts["Add Filter Word"].exists)
    }

    func testTableAppers() {
        app.toolbars["Toolbar"].children(matching: .other)
            .element.children(matching: .other).element
            .children(matching: .button).element(boundBy: 1).tap()

        XCTAssertTrue(app.tables["filterWordsTableView"].exists)
    }
}
