//
//  TaskEntity+CoreData.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import Foundation
import CoreData

extension TaskEntity {
    static func create(in context: NSManagedObjectContext,
                       title: String,
                       details: String,
                       priority: String) {
        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = title
        task.details = details
        task.priority = priority
        task.createdAt = Date()
        try? context.save()
    }
}
