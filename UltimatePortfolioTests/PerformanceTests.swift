//
//  PerformanceTests.swift
//  UltimatePortfolioTests
//
//  Created by Damien Chailloleau on 13/12/2024.
//

import XCTest
@testable import UltimatePortfolio

final class PerformanceTests: BaseTestCase {
    func testAwardsCalculationPerformance() {
        for _ in 1...100 {
            dataController.createSampleCode()
        }

        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "Checks the count of awards. Change the value, if other awards are added.")

        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
