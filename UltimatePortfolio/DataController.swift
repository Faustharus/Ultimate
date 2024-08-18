//
//  DataController.swift
//  UltimatePortfolio
//
//  Created by Damien Chailloleau on 18/08/2024.
//

import CoreData

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        dataController.createSampleCode()
        return dataController
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Fatal Error detected : Loading store failed - \(error.localizedDescription)")
            }
        }
    }
    
    func createSampleCode() {
        let viewContext = container.viewContext
        
        for i in 1...5 {
            let tag = Tag(context: viewContext)
            tag.id = UUID()
            tag.name = "Tag \(i)"
            
            for j in 1...10 {
                let issue = Issue(context: viewContext)
                issue.title = "Issue \(i)-\(j)"
                issue.content = "Description goes here"
                issue.creationDate = .now
                issue.completed = Bool.random()
                issue.priority = Int16.random(in: 0...2)
                tag.addToIssues(issue)
            }
        }
        
        try? viewContext.save()
    }
}
