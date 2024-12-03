//
//  SidebarView.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 21/08/2024.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var dataController: DataController
    let smartFilters: [Filter] = [.all, .recent]

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag>

    @State private var tagToRename: Tag?
    @State private var renamingTag: Bool = false
    @State private var tagName: String = ""
    @State private var isShowingAward: Bool = false

    var tagFilters: [Filter] {
        tags.map { tag in
            Filter(id: tag.tagID, name: tag.tagName, icon: "tag", tag: tag)
        }
    }

    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart Filters") {
                ForEach(smartFilters, content: SmartFilterRow.init)
            }

            Section("Tags") {
                ForEach(tagFilters) { filter in
                    UserFilterRow(filter: filter, rename: rename, delete: delete)
                }
                .onDelete(perform: delete)
            }
        }
        .navigationTitle("Filters")
        .toolbar {
            SidebarViewToolbar(isShowingAward: $isShowingAward)
        }
        .alert("Rename Tag", isPresented: $renamingTag) {
            Button("OK", action: completeRename)
            Button("Cancer", role: .cancel) { }
            TextField("New name", text: $tagName)
        }
        .sheet(isPresented: $isShowingAward, content: AwardsView.init)
    }

    func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let item = tags[offset]
            dataController.delete(item)
        }
    }

    func delete(_ filter: Filter) {
        guard let tag = filter.tag else { return }
        dataController.delete(tag)
        dataController.save()
    }

    func rename(_ filter: Filter) {
        tagToRename = filter.tag
        tagName = filter.name
        renamingTag = true
    }

    func completeRename() {
        tagToRename?.name = tagName
        dataController.save()
    }
}

#Preview {
    SidebarView()
        .environmentObject(DataController.preview)
}
