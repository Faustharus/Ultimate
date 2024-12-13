//
//  DevelopmentTests.swift
//  UltimatePortfolioTests
//
//  Created by Damien Chailloleau on 09/12/2024.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

final class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() {
        dataController.createSampleCode()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 5, "There should be 5 sample tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "There should be 50 sample issues.")
    }

    func testDeleteAllClearsEverything() {
        dataController.createSampleCode()

        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 0, "All Tags should be deleted.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 0, "All Issues should be deleted.")
    }

    func testTagCreatedWithNoIssues() {
        let tag = Tag.example

        XCTAssertEqual(tag.issues?.count, 0, "All New Tags shouldn't have any Issues linked to them yet.")
    }

    func testIssueCreatedWithHighestPriority() {
        let issue = Issue.example

        XCTAssertEqual(issue.priority, 2, "Tagless New Issue should always be of High Priority.")
    }

}
