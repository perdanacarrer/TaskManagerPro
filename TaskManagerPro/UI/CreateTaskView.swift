//
//  CreateTaskView.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import SwiftUI
import CoreData

struct CreateTaskView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var details = ""
    @State private var dueDate = Date()
    @State private var priority = "Medium"
    @State private var isCompleted = false
    @State private var isDelete = false

    var body: some View {
        TaskFormView(
            title: $title,
            details: $details,
            dueDate: $dueDate,
            priority: $priority,
            isCompleted: $isCompleted,
            isDeletes: $isDelete
        )
        .navigationTitle("New Task")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    createTask()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

private extension CreateTaskView {

    func createTask() {
        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = title
        task.details = details
        task.priority = priority
        task.isCompleted = isCompleted
        task.isDelete = isDelete
        task.createdAt = Date()
        task.updatedAt = dueDate
        task.syncStatus = SyncStatus.pending.rawValue

        do {
            try context.save()
            dismiss()
        } catch {
            print("Failed to save task:", error.localizedDescription)
        }
    }
    
    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !details.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

