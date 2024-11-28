//
//  SidebarViewToolbar.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 28/11/2024.
//

import SwiftUI

struct SidebarViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @Binding var isShowingAward: Bool

    var body: some View {
        Button {
            dataController.newTag()
        } label: {
            Label("Add Tag", systemImage: "plus")
        }

        Button {
            isShowingAward.toggle()
        } label: {
            Label("Show awards", systemImage: "rosette")
        }

        #if DEBUG
        Button {
            dataController.deleteAll()
            dataController.createSampleCode()
        } label: {
            Label("Add Samples", systemImage: "flame")
        }
        #endif
    }
}

#Preview {
    SidebarViewToolbar(isShowingAward: .constant(false))
        .environmentObject(DataController.preview)
}
