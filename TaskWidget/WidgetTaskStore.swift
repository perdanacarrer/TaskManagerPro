//
//  WidgetTaskStore.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 04/01/26.
//

import CoreData

final class WidgetTaskStore {

    static let shared = WidgetTaskStore()

    private let container: NSPersistentContainer

    private init() {

        container = NSPersistentContainer(name: "TaskManagerPro")

        guard let containerURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.sarimin.TaskManagerPro")
        else {
            fatalError("❌ App Group not configured for Widget target")
        }

        let storeURL = containerURL
            .appendingPathComponent("TaskManagerPro.sqlite")

        let description = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Widget Core Data error: \(error)")
            }
        }
    }

    func taskCount() -> Int {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.resultType = NSFetchRequestResultType.countResultType

        return (try? container.viewContext.count(for: request)) ?? 0
    }
}
