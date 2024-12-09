//
//  TagTests.swift
//  UltimatePortfolioTests
//
//  Created by Damien Chailloleau on 06/12/2024.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

final class TagTests: BaseTestCase {
    func testCreatingTagsAndIssues() {
        let targetCount = 10

        for _ in 0 ..< targetCount {
            let tag = Tag(context: managedObjectContext)

            for _ in 0 ..< targetCount {
                let issue = Issue(context: managedObjectContext)
                tag.addToIssues(issue)
            }
        }

        XCTAssertEqual(
            dataController.count(for: Tag.fetchRequest()),
            targetCount,
            "Expected \(targetCount) tags."
        )
        XCTAssertEqual(
            dataController.count(for: Issue.fetchRequest()),
            targetCount * targetCount,
            "Expected \(targetCount * targetCount) issues"
        )
    }

    func testDeletingTagsDoesNotDeleteIssues() throws {
        dataController.createSampleCode()

        let request = NSFetchRequest<Tag>(entityName: "Tag")
        let tags = try managedObjectContext.fetch(request)

        dataController.delete(tags[0])

        XCTAssertEqual(
            dataController.count(for: Tag.fetchRequest()),
            4,
            "There should be 4 tags after deleting 1 of them from the sample data."
        )
        XCTAssertEqual(
            dataController.count(for: Issue.fetchRequest()),
            50,
            "There should still be 50 issues after deleting 1 tag out of the sample data."
        )
    }
}
