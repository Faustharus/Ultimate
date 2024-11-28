//
//  UserFilterRow.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 28/11/2024.
//

import SwiftUI

struct UserFilterRow: View {
    var filter: Filter

    var rename: (Filter) -> Void
    var delete: (Filter) -> Void

    var body: some View {
        NavigationLink(value: filter) {
            Label(LocalizedStringKey(filter.name), systemImage: filter.icon)
                .badge(filter.activeIssuesCount)
                .contextMenu {
                    Button {
                        rename(filter)
                    } label: {
                        Label("Rename", systemImage: "pencil")
                    }

                    Button(role: .destructive) {
                        delete(filter)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .accessibilityElement()
                .accessibilityLabel(filter.name)
                .accessibilityHint("\(filter.activeIssuesCount) issues")
        }
    }
}

#Preview {
    UserFilterRow(filter: .all) { _ in } delete: { _ in }
}
