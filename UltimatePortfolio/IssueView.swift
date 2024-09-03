//
//  IssueView.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 02/09/2024.
//

import SwiftUI

struct IssueView: View {
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
    }
}

#Preview {
    IssueView(issue: Issue.example)
}
