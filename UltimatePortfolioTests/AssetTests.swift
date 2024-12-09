//
//  AssetTests.swift
//  UltimatePortfolioTests
//
//  Created by Damien Chailloleau on 06/12/2024.
//

import XCTest
@testable import UltimatePortfolio

final class AssetTests: XCTestCase {
    func testColorExist() {
        let allColors = ["BlueMarine", "CoinGold", "CrimsonRed", "CuminOrange", "CurtainTeal", "ForestGreen", "GreasePencilGray", "MetalMidnight", "PencilGray", "PrincessPink", "RoyalPurple", "SkyBlue"]

        for color in allColors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color `\(color)` from asset catalog.")
        }
    }

    func testAwardsLoadCorrectly() {
        XCTAssertTrue(Award.allAwards.isEmpty == false, "Failed to load awards from JSON.")
    }

}
