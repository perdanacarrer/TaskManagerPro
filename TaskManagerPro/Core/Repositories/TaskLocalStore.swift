//
//  TaskLocalStore.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import Foundation

protocol TaskLocalStore {
    func fetchPendingTasks() throws -> [TaskEntity]
    func fetchTask(by id: UUID) throws -> TaskEntity?
    func createTask() -> TaskEntity
    func save() throws
}
