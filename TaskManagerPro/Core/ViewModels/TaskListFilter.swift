//
//  TaskListFilter.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import Foundation

enum TaskFilter {
    case all
    case completed
    case pending
    case priority(String)
    case dueDate(DueDateFilter)
}

enum DueDateFilter {
    case today
    case upcoming
    case overdue
}
