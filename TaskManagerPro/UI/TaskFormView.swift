//
//  TaskFormView.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import SwiftUI

struct TaskFormView: View {
    @Binding var title: String
    @Binding var details: String
    @Binding var dueDate: Date
    @Binding var priority: String
    @Binding var isCompleted: Bool
    @Binding var isDeletes: Bool

    var body: some View {
        Form {
            taskInfoSection
            scheduleSection
            prioritySection
            statusSection
        }
    }
}

private extension TaskFormView {

    var taskInfoSection: some View {
        Section(header: Text("TASK INFO")) {
            TextField("Title", text: $title)
                .accessibilityIdentifier("Title")
            ZStack(alignment: .topLeading) {
                if details.isEmpty {
                    Text("Details")
                        .allowsHitTesting(false)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                        .padding(.horizontal, 5)
                }

                TextEditor(text: $details)
                    .frame(height: 100)
            }
        }
    }

    var scheduleSection: some View {
        Section(header: Text("SCHEDULE")) {
            DatePicker(
                "Due Date",
                selection: $dueDate,
                displayedComponents: .date
            )
        }
    }

    var prioritySection: some View {
        Section(header: Text("PRIORITY")) {
            Picker("Priority", selection: $priority) {
                Text("Low").tag("Low")
                Text("Medium").tag("Medium")
                Text("High").tag("High")
            }
        }
    }

    var statusSection: some View {
        Section(header: Text("STATUS")) {
            Toggle("Completion", isOn: $isCompleted)
                .accessibilityIdentifier("Completion")
        }
    }
}
