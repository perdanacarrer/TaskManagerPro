//
//  TaskManagerProTests.swift
//  TaskManagerProTests
//
//  Created by oscar perdana on 03/01/26.
//

import XCTest
import CoreData
@testable import TaskManagerPro

final class TaskManagerProTests: XCTestCase {
    func testInitialization() {
        XCTAssertTrue(true)
    }
}

struct TestPersistenceController {

    static let shared = TestPersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "TaskManagerPro")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("In-memory Core Data failed \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }
}

final class TaskListViewModelTests: XCTestCase {

    var context: NSManagedObjectContext!
    var viewModel: TaskListViewModel!

    override func setUp() async throws {
        context = TestPersistenceController.shared.context
        viewModel = await TaskListViewModel(context: context)
    }

    @MainActor
    func testCreateTask() throws {
        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = "Test Task"
        task.details = "Details"
        task.isCompleted = false
        task.priority = "high"

        try context.save()

        let results = try context.fetch(viewModel.fetchRequest())
        XCTAssertEqual(results.count, 1)
    }

    @MainActor
    func testFilterCompletedTasks() throws {
        let completed = TaskEntity(context: context)
        completed.id = UUID()
        completed.title = "Done"
        completed.isCompleted = true

        let pending = TaskEntity(context: context)
        pending.id = UUID()
        pending.title = "Todo"
        pending.isCompleted = false

        try context.save()

        viewModel.filter = .completed
        let results = try context.fetch(viewModel.fetchRequest())

        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(results.first!.isCompleted)
    }

    @MainActor
    func testSearchTasks() throws {
        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = "Buy Milk"
        task.details = "Groceries"

        try context.save()

        viewModel.searchText = "Milk"
        let results = try context.fetch(viewModel.fetchRequest())

        XCTAssertEqual(results.count, 1)
    }

    @MainActor
    func testDeleteTask() throws {
        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = "Delete Me"

        try context.save()

        viewModel.delete(task)

        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        let results = try context.fetch(request)

        XCTAssertEqual(results.count, 0)
    }
}

final class TaskEntityTests: XCTestCase {

    func testTaskDefaults() {
        let context = TestPersistenceController.shared.context
        let task = TaskEntity(context: context)

        XCTAssertNotNil(task)
        XCTAssertFalse(task.isCompleted)
    }
}
