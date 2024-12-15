//
//  SidebarView.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 21/08/2024.
//

import SwiftUI

struct SidebarView: View {
    @StateObject private var viewModel: ViewModel

    let smartFilters: [Filter] = [.all, .recent]

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List(selection: $viewModel.dataController.selectedFilter) {
            Section("Smart Filters") {
                ForEach(smartFilters, content: SmartFilterRow.init)
            }

            Section("Tags") {
                ForEach(viewModel.tagFilters) { filter in
                    UserFilterRow(filter: filter, rename: viewModel.rename, delete: viewModel.delete)
                }
                .onDelete(perform: viewModel.delete)
            }
        }
        .navigationTitle("Filters")
        .toolbar {
            SidebarViewToolbar(isShowingAward: $viewModel.isShowingAward)
        }
        .alert("Rename Tag", isPresented: $viewModel.renamingTag) {
            Button("OK", action: viewModel.completeRename)
            Button("Cancer", role: .cancel) { }
            TextField("New name", text: $viewModel.tagName)
        }
        .sheet(isPresented: $viewModel.isShowingAward, content: AwardsView.init)
    }
}

#Preview {
    SidebarView(dataController: .preview)
}
