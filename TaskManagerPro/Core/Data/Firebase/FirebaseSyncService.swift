//
//  FirebaseSyncService.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import Foundation
import FirebaseFirestore

actor FirebaseSyncService {

    private let db = Firestore.firestore()
    private let localStore: TaskLocalStore

    private let lastSyncKey = "lastSyncTime"

    private var lastSyncTime: Date {
        get {
            let timeInterval = UserDefaults.standard.double(forKey: lastSyncKey)
            return timeInterval == 0
                ? .distantPast
                : Date(timeIntervalSince1970: timeInterval)
        }
        set {
            UserDefaults.standard.set(newValue.timeIntervalSince1970, forKey: lastSyncKey)
        }
    }

    init(localStore: TaskLocalStore) {
        self.localStore = localStore
    }

    func pushPendingChanges() async {
        do {
            let pendingTasks = try localStore.fetchPendingTasks()

            for task in pendingTasks {
                let dto = TaskDTO(from: task)

                try await db
                    .collection("tasks")
                    .document(dto.id) // UUID string
                    .setData(dto.toFirestore(), merge: true)

                task.syncStatus = SyncStatus.synced.rawValue
            }

            try localStore.save()

        } catch {
            print("❌ Push sync failed:", error)
        }
    }

    func pullRemoteChanges() async {
        do {
            let snapshot = try await db
                .collection("tasks")
                .whereField(
                    "updatedAt",
                    isGreaterThan: Timestamp(date: lastSyncTime)
                )
                .getDocuments()

            for document in snapshot.documents {
                guard let remote = TaskDTO(from: document.data()) else { continue }
                guard let remoteUUID = UUID(uuidString: remote.id) else { continue }

                if let local = try localStore.fetchTask(by: remoteUUID) {
                    if remote.updatedAt > (local.updatedAt ?? .distantPast) {
                        local.title = remote.title
                        local.details = remote.details
                        local.createdAt = remote.createdAt
                        local.priority = remote.priority
                        local.isCompleted = remote.isCompleted
                        local.updatedAt = remote.updatedAt
                        local.syncStatus = SyncStatus.synced.rawValue
                    }
                } else {
                    let task = localStore.createTask()
                    task.id = remoteUUID
                    task.title = remote.title
                    task.details = remote.details
                    task.createdAt = remote.createdAt
                    task.priority = remote.priority
                    task.isCompleted = remote.isCompleted
                    task.updatedAt = remote.updatedAt
                    task.syncStatus = SyncStatus.synced.rawValue
                }
            }

            try localStore.save()
            lastSyncTime = Date()

        } catch {
            print("❌ Pull sync failed:", error)
        }
    }
}
