//
//  TagsMenuView.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 28/11/2024.
//

import SwiftUI

struct TagsMenuView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue

    var body: some View {
        Menu {
            // MARK: Show selected tags
            ForEach(issue.issueTags) { tag in
                Button {
                    issue.removeFromTags(tag)
                } label: {
                    Label(tag.tagName, systemImage: "checkmark")
                }
            }

            // MARK: Show unselected tags
            let otherTags = dataController.missingTags(from: issue)

            if otherTags.isEmpty == false {
                Divider()

                Section("Add Tags") {
                    ForEach(otherTags) { tag in
                        Button {
                            issue.addToTags(tag)
                        } label: {
                            Text(tag.tagName)
                        }
                    }
                }
            }

        } label: {
            Text(issue.issueTagList)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
                .animation(nil, value: issue.issueTagList)
        }
    }
}

#Preview {
    TagsMenuView(issue: .example)
        .environmentObject(DataController(inMemory: true))
}
