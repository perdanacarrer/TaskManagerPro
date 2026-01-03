//
//  SyncEngine.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import Foundation
import Network

actor SyncEngine {

//    static let shared = SyncEngine(
//        localStore: CoreDataTaskStore.shared
//    )

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "SyncEngineMonitor")
    private let firebaseService: FirebaseSyncService

    init(localStore: TaskLocalStore) {
        self.firebaseService = FirebaseSyncService(localStore: localStore)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                Task {
                    await self.startSync()
                }
            }
        }

        monitor.start(queue: queue)
    }

    func startSync() async {
        await firebaseService.pushPendingChanges()
        await firebaseService.pullRemoteChanges()
    }
}
