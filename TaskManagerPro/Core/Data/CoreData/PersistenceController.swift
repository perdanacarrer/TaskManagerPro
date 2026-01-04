//
//  PersistenceController.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import CoreData

struct PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {

        container = NSPersistentContainer(name: "TaskManagerPro")

        if inMemory {
            container.persistentStoreDescriptions.first?.url =
                URL(fileURLWithPath: "/dev/null")
        } else {
            let storeURL = FileManager.default
                .containerURL(
                    forSecurityApplicationGroupIdentifier: "group.com.sarimin.TaskManagerPro"
                )!
                .appendingPathComponent("TaskManagerPro.sqlite")

            let description = NSPersistentStoreDescription(url: storeURL)
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data error: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        if UITestEnvironment.isUITest {
            seedUITestData()
        }
    }

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private func seedUITestData() {
        let context = container.viewContext

        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        let count = (try? context.count(for: request)) ?? 0

        // Prevent duplicate inserts
        guard count == 0 else { return }

        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = "UI Test Task"
        task.details = "This task is for UI testing"
        task.isCompleted = false
        task.priority = "Medium"
        task.createdAt = Date()
        task.updatedAt = Date()

        do {
            try context.save()
        } catch {
            fatalError("Failed to seed UI test data: \(error)")
        }
    }
}
