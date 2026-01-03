//
//  TaskListContent.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import CoreData
import SwiftUI

struct TaskListContent: View {

    @ObservedObject var viewModel: TaskListViewModel
    let context: NSManagedObjectContext
    @State private var showingDeleteAlert = false
    @State private var taskToDelete: TaskEntity?

    @FetchRequest var tasks: FetchedResults<TaskEntity>

    init(viewModel: TaskListViewModel, context: NSManagedObjectContext) {
        self.viewModel = viewModel
        self.context = context
        _tasks = FetchRequest(fetchRequest: viewModel.fetchRequest())
    }

    var body: some View {
        List {
            ForEach(tasks) { task in
                NavigationLink {
                    TaskDetailView(task: task)
                        .environment(\.managedObjectContext, context)
                } label: {
                    TaskRow(task: task)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        taskToDelete = task
                        showingDeleteAlert = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .alert("Do you sure to delete this?", isPresented: $showingDeleteAlert) {
                Button("No", role: .cancel) { }

                Button("Yes", role: .destructive) {
                    if let task = taskToDelete {
                        viewModel.delete(task)
                    }
                }
            }
        }
    }
}
