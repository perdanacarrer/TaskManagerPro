//
//  SyncModel.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import Foundation
import FirebaseFirestore

enum SyncStatus: String {
    case pending
    case synced
    case failed
}

struct TaskDTO {
    let id: String
    let title: String
    let details: String
    let createdAt: Date
    let priority: String
    let isCompleted: Bool
    let updatedAt: Date

    init(from task: TaskEntity) {
        self.id = task.id?.uuidString ?? ""
        self.title = task.title ?? ""
        self.details = task.details ?? ""
        self.createdAt = task.createdAt ?? Date()
        self.priority = task.priority ?? "Medium"
        self.isCompleted = task.isCompleted
        self.updatedAt = task.updatedAt ?? Date()
    }

    init?(from data: [String: Any]) {
        guard
            let id = data["id"] as? String,
            let title = data["title"] as? String,
            let description = data["details"] as? String,
            let priority = data["priority"] as? String,
            let isCompleted = data["isCompleted"] as? Bool,
            let createdAt = data["createdAt"] as? Timestamp,
            let updatedAt = data["updatedAt"] as? Timestamp,
            UUID(uuidString: id) != nil
        else { return nil }

        self.id = id
        self.title = title
        self.details = description
        self.createdAt = createdAt.dateValue()
        self.priority = priority
        self.isCompleted = isCompleted
        self.updatedAt = updatedAt.dateValue()
    }

    func toFirestore() -> [String: Any] {
        var data: [String: Any] = [
            "id": id,
            "title": title,
            "details": details,
            "priority": priority,
            "isCompleted": isCompleted,
            "createdAt": Timestamp(date: createdAt),
            "updatedAt": Timestamp(date: updatedAt)
        ]

        return data
    }

}


