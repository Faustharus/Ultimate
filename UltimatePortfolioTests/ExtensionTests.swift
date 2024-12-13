//
//  ExtensionTests.swift
//  UltimatePortfolioTests
//
//  Created by Damien Chailloleau on 12/12/2024.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

final class ExtensionTests: BaseTestCase {

    func testIssueTitleUnwrap() {
        // Arrange
        let issue = Issue(context: managedObjectContext)

        // Act
        issue.title = "Example Issue"
        // Assert
        XCTAssertEqual(issue.issueTitle, "Example Issue", "Changing title should also changing issueTitle.")

        // Act
        issue.issueTitle = "Updated Issue"
        // Assert
        XCTAssertEqual(issue.title, "Updated Issue", "Changing issueTitle should also changing title.")
    }

    func testIssueContentUnwrap() {
        let issue = Issue(context: managedObjectContext)

        issue.content = "Example Issue"
        XCTAssertEqual(issue.issueContent, "Example Issue", "Changing title should also changing issueTitle.")

        issue.issueContent = "Updated Issue"
        XCTAssertEqual(issue.content, "Updated Issue", "Changing issueTitle should also changing title.")
    }

    func testIssueCreationDateUnwrap() {
        // Arrange
        let issue = Issue(context: managedObjectContext)
        // Act
        let testDate = Date.now
        issue.creationDate = testDate
        // Assert
        XCTAssertEqual(issue.issueCreationDate, testDate, "Changing creationDate should also change issueCreationDate")
    }

    func testIssueTagsUnwrap() {
        // Arrange
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)
        // Act
        XCTAssertEqual(issue.issueTags.count, 0, "A new issue shouldn't have any tags.")
        issue.addToTags(tag)
        // Assert
        XCTAssertEqual(issue.issueTags.count, 1, "It should have 1 tag inside that Issue.")
    }

    func testIssueTagsList() {
        // Arrange
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)
        // Act
        tag.name = "My Tag"
        issue.addToTags(tag)
        // Assert
        XCTAssertEqual(issue.issueTagList, "My Tag", "Adding 1 Tag to an issue should make issueTagList be 'My Tag'. ")
    }

    func testIssueSortingIsStable() {
        let issue1 = Issue(context: managedObjectContext)
        issue1.title = "B Issue"
        issue1.creationDate = .now

        let issue2 = Issue(context: managedObjectContext)
        issue2.title = "B Issue"
        issue2.creationDate = .now.addingTimeInterval(1)

        let issue3 = Issue(context: managedObjectContext)
        issue3.title = "A Issue"
        issue3.creationDate = .now.addingTimeInterval(100)

        let allIssues = [issue1, issue2, issue3]
        let sorted = allIssues.sorted()

        XCTAssertEqual([issue3, issue1, issue2], sorted, "Sorting issue arrays should use name then creation date.")
    }

    func testTagIDUnwrap() {
        let tag = Tag(context: managedObjectContext)

        tag.id = UUID()
        XCTAssertEqual(tag.tagID, tag.id, "Changing id should also change tagID.")
    }

    func testTagNameUnwrap() {
        let tag = Tag(context: managedObjectContext)

        tag.name = "Example Tag"
        XCTAssertEqual(tag.tagName, "Example Tag", "Changing name should also change tagName.")
    }

    func testTagActiveIssuesWrapper() {
        let tag = Tag(context: managedObjectContext)
        let issue = Issue(context: managedObjectContext)

        XCTAssertEqual(tag.tagActiveIssues.count, 0, "A new Tag shouldn't have any issues.")

        tag.addToIssues(issue)
        XCTAssertEqual(tag.tagActiveIssues.count, 1, "A new Issue has correctly put inside that Tag and is Active")

        issue.completed = true
        XCTAssertEqual(tag.tagActiveIssues.count, 0, "No active Issues inside that Tag.")
    }

    func testTagSortingIsStable() {
        let tag1 = Tag(context: managedObjectContext)
        tag1.name = "B Tag"
        tag1.id = UUID()

        let tag2 = Tag(context: managedObjectContext)
        tag2.name = "B Tag"
        tag2.id = UUID(uuidString: "FFFFFFFF-DD7C-46F9-8618-67960CEDD1BE")

        let tag3 = Tag(context: managedObjectContext)
        tag3.name = "A Tag"
        tag3.id = UUID()

        let allTags = [tag1, tag2, tag3]
        let sorted = allTags.sorted()

        XCTAssertEqual([tag3, tag1, tag2], sorted, "Sorting Tags should be on the same order through name then UUID.")
    }

    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode("Awards.json", as: [Award].self)
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode a non-empty array.")
    }

    func testDecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableString.json", as: String.self)
        XCTAssertEqual(data, "Never ask a starfish for direction", "The String should match DecodableString.json")
    }

    func testDecodingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode("DecodableDictionary.json", as: [String: Int].self)

        XCTAssertEqual(data.count, 3, "There should be 3 items inside DecodableDictionary.json")
        XCTAssertEqual(data, ["One": 0, "Two": 2, "Three": 3], "The Dictionary should match DecodableDictionary.json")
    }

}
