//
//  Award.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 03/11/2024.
//

import Foundation

struct Award: Codable, Identifiable {
    var id: String { name }
    var name: String
    var description: String
    var color: String
    var criterion: String
    var value: Int
    var image: String

    static let allAwards: [Award] = Bundle.main.decode("Awards.json")
    static let example = allAwards[0]
}
