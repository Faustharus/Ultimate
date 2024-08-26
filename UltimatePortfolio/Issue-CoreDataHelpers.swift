//
//  Issue-CoreDataHelpers.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 24/08/2024.
//

import Foundation

extension Issue {
    var issueTitle: String {
        get { title ?? "" }
        set { title = newValue }
    }
    
    var issueContent: String {
        get { content ?? "" }
        set { content = newValue }
    }
    
    var issueCreationDate: Date {
        creationDate ?? .now
    }
    
    var issueModificationDate: Date {
        modificationDate ?? .now
    }
    
    var issueTags: [Tag] {
        let result = tags?.allObjects as? [Tag] ?? []
        return result.sorted()
    }
    
    static var example: Issue {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let issue = Issue(context: viewContext)
        issue.title = "This is a title !"
        issue.content = "That is the content of the issue"
        issue.priority = 2
        issue.creationDate = .now
        return issue
    }
}

extension Issue: Comparable {
    /** Example of `stable` data sorting : It will always organized the same way whatever the object */
    public static func <(lhs: Issue, rhs: Issue) -> Bool {
        let left = lhs.issueTitle.localizedLowercase
        let right = lhs.issueTitle.localizedLowercase
        
        if left == right {
            return lhs.issueCreationDate < rhs.issueCreationDate
        } else {
            return left < right
        }
    }
}