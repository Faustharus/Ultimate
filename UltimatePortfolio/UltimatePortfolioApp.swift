//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 17/08/2024.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
