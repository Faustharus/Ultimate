//
//  IssueView.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 02/09/2024.
//

import SwiftUI

struct IssueView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    TextField("Title", text: $issue.issueTitle, prompt: Text("Enter issue title here."))
                        .font(.title)
                    
                    Text("**Modified:** \(issue.issueModificationDate.formatted(date: .long, time: .shortened))")
                        .foregroundStyle(.secondary)
                    
                    Text("**Status:** \(issue.issueCompleted)")
                        .foregroundStyle(.secondary)
                }
                
                Picker("Priority", selection: $issue.priority) {
                    Text("Low").tag(Int16(0))
                    Text("Medium").tag(Int16(1))
                    Text("High").tag(Int16(2))
                }
                
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
            
            Section {
                VStack(alignment: .leading) {
                    Text("Basic Infomration")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    TextField("Description", text: $issue.issueContent, prompt: Text("Enter the issue description here."), axis: .vertical)
                }
            }
        }
        .disabled(issue.isDeleted)
        .onReceive(issue.objectWillChange) { _ in
            dataController.queueSave()
        }
        .onSubmit(dataController.save)
        .toolbar {
            Menu {
                Button {
                    UIPasteboard.general.string = issue.title
                } label: {
                    Label("Copy Issue Title", systemImage: "doc.on.doc")
                }
                
                Button {
                    issue.completed.toggle()
                    dataController.save()
                } label: {
                    Label(issue.completed ? "Re-open Issue" : "Close Issue", systemImage: "bubble.left.and.exclamationmark.bubble.right")
                }
                
            } label: {
                Label("Actions", systemImage: "ellipsis.circle")
            }
        }
    }
}

#Preview {
    IssueView(issue: Issue.example)
        .environmentObject(DataController.preview)
}
