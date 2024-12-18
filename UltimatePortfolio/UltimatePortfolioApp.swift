//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 17/08/2024.
//

import CoreSpotlight
import SwiftUI

@main
struct UltimatePortfolioApp: App {

    @Environment(\.scenePhase) var scenePhase
    @StateObject var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            NavigationSplitView(sidebar: {
                SidebarView(dataController: dataController)
            }, content: {
                ContentView(dataController: dataController)
            }, detail: {
                DetailView()
            })
            .onContinueUserActivity(CSSearchableItemActionType, perform: loadSpotlightItem)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
            .onChange(of: scenePhase) { _, newValue in
                if newValue != .active {
                    dataController.save()
                }
            }
        }
    }

    func loadSpotlightItem(_ userActivity: NSUserActivity) {
        if let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
            dataController.selectedIssue = dataController.issue(with: uniqueIdentifier)
            dataController.selectedFilter = .all
        }
    }

}
