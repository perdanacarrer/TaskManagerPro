//
//  TaskListViewModel.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import Foundation
import CoreData
import Combine
import WidgetKit

@MainActor
final class TaskListViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var filter: TaskFilter = .all

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchRequest() -> NSFetchRequest<TaskEntity> {
        let request = TaskEntity.fetchRequest()
        var predicates: [NSPredicate] = []

        // 🔍 Search
        if !searchText.isEmpty {
            predicates.append(
                NSPredicate(
                    format: "title CONTAINS[cd] %@ OR details CONTAINS[cd] %@",
                    searchText, searchText
                )
            )
        }

        // 🎛 Filters
        switch filter {
        case .completed:
            predicates.append(NSPredicate(format: "isCompleted == true"))
        case .pending:
            predicates.append(NSPredicate(format: "isCompleted == false"))
        case .priority(let value):
            predicates.append(NSPredicate(format: "priority == %@", value))
        case .dueDate(let dueFilter):
            let calendar = Calendar.current
            let now = Date()

            switch dueFilter {
            case .today:
                let start = calendar.startOfDay(for: now)
                let end = calendar.date(byAdding: .day, value: 1, to: start)!
                predicates.append(
                    NSPredicate(format: "updatedAt >= %@ AND updatedAt < %@", start as NSDate, end as NSDate)
                )
            case .upcoming:
                predicates.append(
                    NSPredicate(format: "updatedAt > %@", now as NSDate)
                )
            case .overdue:
                predicates.append(
                    NSPredicate(format: "updatedAt < %@ AND isCompleted == NO", now as NSDate)
                )
            }
        case .all:
            break
        }

        if !predicates.isEmpty {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }

        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \TaskEntity.updatedAt, ascending: false)
        ]

        return request
    }
    
    func delete(_ task: TaskEntity) {
        context.delete(task)

        do {
            try context.save()
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            print("Failed to delete task: \(error)")
        }
    }
}
