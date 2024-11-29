//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 17/08/2024.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {

    @Environment(\.scenePhase) var scenePhase
    @StateObject var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            NavigationSplitView(sidebar: {
                SidebarView()
            }, content: {
                ContentView()
            }, detail: {
                DetailView()
            })
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .onChange(of: scenePhase) { _, newValue in
                if newValue != .active {
                    dataController.save()
                }
            }
        }
    }
}
