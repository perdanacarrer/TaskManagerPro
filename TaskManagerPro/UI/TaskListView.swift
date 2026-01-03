//
//  TaskListView.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import SwiftUI
import CoreData

struct TaskListView: View {

    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: TaskListViewModel
    @State private var showingCreateTask = false

    init() {
        _viewModel = StateObject(
            wrappedValue: TaskListViewModel(
                context: PersistenceController.shared.container.viewContext
            )
        )
    }

    var body: some View {
        NavigationStack {
            TaskListContent(viewModel: viewModel, context: context)
                .navigationTitle("My Tasks")
                .searchable(text: $viewModel.searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingCreateTask = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button("All") { viewModel.filter = .all }
                            Button("Completed") { viewModel.filter = .completed }
                            Button("Pending") { viewModel.filter = .pending }
                            Divider()
                            Button("High Priority") { viewModel.filter = .priority("High") }
                            Button("Medium Priority") { viewModel.filter = .priority("Medium") }
                            Button("Low Priority") { viewModel.filter = .priority("Low") }
                            Divider()
                            Button("Due Today") { viewModel.filter = .dueDate(.today) }
                            Button("Upcoming") { viewModel.filter = .dueDate(.upcoming) }
                            Button("Overdue") { viewModel.filter = .dueDate(.overdue) }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    }
                }
                .navigationDestination(isPresented: $showingCreateTask) {
                    CreateTaskView()
                        .environment(\.managedObjectContext, context)
                }
        }
    }
}
