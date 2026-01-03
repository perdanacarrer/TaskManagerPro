//
//  TaskDetailView.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import SwiftUI
import CoreData
import WidgetKit

struct TaskDetailView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    let task: TaskEntity

    @State private var title: String
    @State private var details: String
    @State private var dueDate: Date
    @State private var priority: String
    @State private var isCompleted: Bool
    @State private var isDelete: Bool

    init(task: TaskEntity) {
        self.task = task
        _title = State(initialValue: task.title ?? "")
        _details = State(initialValue: task.details ?? "")
        _dueDate = State(initialValue: task.updatedAt ?? Date())
        _priority = State(initialValue: task.priority ?? "Medium")
        _isCompleted = State(initialValue: task.isCompleted)
        _isDelete = State(initialValue: task.isDelete)
    }

    var body: some View {
        TaskFormView(
            title: $title,
            details: $details,
            dueDate: $dueDate,
            priority: $priority,
            isCompleted: $isCompleted,
            isDeletes: $isDelete
        )
        .navigationTitle("Task Detail")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    updateTask()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

private extension TaskDetailView {

    func updateTask() {
        task.title = title
        task.details = details
        task.priority = priority
        task.isCompleted = isCompleted
        task.isDelete = isDelete
        task.updatedAt = dueDate
        task.syncStatus = SyncStatus.pending.rawValue

        do {
            try context.save()
            WidgetCenter.shared.reloadAllTimelines()
            dismiss()
        } catch {
            print("Failed to update task:", error.localizedDescription)
        }
    }
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !details.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
