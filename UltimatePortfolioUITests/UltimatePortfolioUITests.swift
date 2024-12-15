//
//  UltimatePortfolioUITests.swift
//  UltimatePortfolioUITests
//
//  Created by Damien Chailloleau on 13/12/2024.
//

import XCTest

extension XCUIElement {
    func clear() {
        guard let stringValue = self.value as? String else {
            XCTFail("Failed to clear text in XCUIElement")
            return
        }

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
    }
}

@MainActor
final class UltimatePortfolioUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func testAppStartsWithNavigationBar() throws {
        XCTAssertTrue(app.navigationBars.element.exists, "There should be a NavBar when the app launches.")
    }

    func testAppHasBasicButtonOnLaunch() throws {
        XCTAssertTrue(app.navigationBars.buttons["Filters"].exists, "There should be a Filters Button.")
        XCTAssertTrue(app.navigationBars.buttons["Filter"].exists, "There should be a Filter Button.")
        XCTAssertTrue(app.navigationBars.buttons["Add Issue"].exists, "There should be a Add Issue Button.")
    }

    func testNoIssuesAtStart() {
        XCTAssertEqual(app.cells.count, 0, "There shouldn't have any Issues available at first")
    }

    func testCreatingAndDeletingIssues() {
        for tapCount in 1...5 {
            app.buttons["Add Issue"].tap()
            app.buttons["Issue"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list.")
        }

        for tapCount in (0...4).reversed() {
            app.cells.firstMatch.swipeLeft()
            app.buttons["Delete"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list.")
        }
    }

    func testEditingIssueTitleCorrectlyUpdates() {
        XCTAssertEqual(app.cells.count, 0, "There should be no rows initially.")

        app.buttons["Add Issue"].tap()

        app.textFields["New Issue"].tap()
        app.textFields["New Issue"].clear()
        app.typeText("My New Issue")

        app.buttons["Issue"].tap()
        XCTAssertTrue(app.buttons["My New Issue"].exists, "A New Issue cells should exists.")
    }

    func testEditingIssuePriorityShowsIcon() {
        app.buttons["Add Issue"].tap()
        app.buttons["Priority, Medium"].tap()
        app.buttons["High"].tap()
        app.buttons["Issue"].tap()

        let identifier = "New Issue High Priority"
        XCTAssert(app.images[identifier].exists, "A high priority issue needs an icon next to it.")
    }

    func testAllAwardsShowLockedAlert() {
        app.buttons["Filters"].tap()
        app.buttons["Show awards"].tap()

        for award in app.scrollViews.buttons.allElementsBoundByIndex {
//            if app.windows.element.frame.contains(award.frame) == false {
//                app.swipeUp()
//            }

            award.tap()
            XCTAssertTrue(app.alerts["Locked"].exists, "There should Locked alert inside awards' page.")
            app.buttons["OK"].tap()
        }
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
