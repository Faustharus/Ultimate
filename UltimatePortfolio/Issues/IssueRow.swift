//
//  IssueRow.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 27/08/2024.
//

import SwiftUI

struct IssueRow: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue

    var body: some View {
        NavigationLink(value: issue) {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .imageScale(.large)
                    .opacity(issue.priority == 2 ? 1 : 0)
                    .accessibilityIdentifier(issue.priority == 2 ? "\(issue.issueTitle) High Priority" : "")

                VStack(alignment: .leading) {
                    Text(issue.issueTitle)
                        .font(.headline)
                        .lineLimit(1)

                    Text(issue.issueTagList)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(issue.issueFormattedCreationDate)
                        .accessibilityLabel(issue.issueCreationDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.subheadline)

                    if issue.completed {
                        Text("Closed")
                            .textInputAutocapitalization(.words)
                            .font(.body.smallCaps())
                    }
                }
                .foregroundStyle(.secondary)
            }
        }
        .accessibilityHint(issue.priority == 2 ? "High Priority" : "")
        .accessibilityIdentifier(issue.issueTitle)
    }
}

#Preview {
    IssueRow(issue: .example)
        .environmentObject(DataController.preview)
}
