//
//  CoreDataTaskStore.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import Foundation
import CoreData

final class CoreDataTaskStore: TaskLocalStore {

    static let shared = CoreDataTaskStore(
        context: PersistenceController.shared.viewContext
    )

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchPendingTasks() throws -> [TaskEntity] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "syncStatus == %@",
            SyncStatus.pending.rawValue
        )
        return try context.fetch(request)
    }

    func fetchTask(by id: UUID) throws -> TaskEntity? {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    func createTask() -> TaskEntity {
        var task: TaskEntity!

        context.performAndWait {
            task = TaskEntity(context: context)

            task.id = UUID()
            task.title = ""
            task.details = ""
            task.isCompleted = false
            task.priority = "Medium"
            task.createdAt = nil

            let now = Date()
            task.updatedAt = now
            task.syncStatus = SyncStatus.pending.rawValue
        }

        return task
    }


    func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
