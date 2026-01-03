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
    let updatedAt: Date

    init(from task: TaskEntity) {
        self.id = task.id?.uuidString ?? ""
        self.title = task.title ?? ""
        self.updatedAt = task.updatedAt ?? Date()
    }

    init?(from data: [String: Any]) {
        guard
            let id = data["id"] as? String,
            let title = data["title"] as? String,
            let timestamp = data["updatedAt"] as? Timestamp,
            UUID(uuidString: id) != nil
        else { return nil }

        self.id = id
        self.title = title
        self.updatedAt = timestamp.dateValue()
    }

    func toFirestore() -> [String: Any] {
        [
            "id": id,
            "title": title,
            "updatedAt": Timestamp(date: updatedAt)
        ]
    }
}


