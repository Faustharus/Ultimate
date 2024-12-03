//
//  ContentView.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 17/08/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        List(selection: $dataController.selectedIssue) {
            ForEach(dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Issue")
        .searchable(text: $dataController.filterText,
                    tokens: $dataController.filterTokens,
                    suggestedTokens: .constant(dataController.suggestedFilterTokens),
                    prompt: "Filter issues, or type # to add tags") { id in
            Text("\(id.tagName)")
        }
        .toolbar(content: ContentViewToolbar.init)
    }

    func delete(_ offsets: IndexSet) {
        let issues = dataController.issuesForSelectedFilter()

        for offset in offsets {
            let item = issues[offset]
            dataController.delete(item)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataController.preview)
}
