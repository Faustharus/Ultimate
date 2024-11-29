//
//  NoIssueView.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 02/09/2024.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        Text("No Issue Selected !")
            .font(.title)
            .foregroundStyle(.secondary)

        Button("New Issue") {
            dataController.newIssue()
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    NoIssueView()
        .environmentObject(DataController.preview)
}
