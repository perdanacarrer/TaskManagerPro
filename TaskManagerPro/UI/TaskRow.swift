//
//  TaskRow.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import SwiftUI

struct TaskRow: View {
    let task: TaskEntity

    var body: some View {
        HStack {
            Circle()
                .fill(priorityColor)
                .frame(width: 10)

            VStack(alignment: .leading) {
                Text(task.title ?? "")
                    .font(.headline)

                if let details = task.details {
                    Text(details)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            }
        }
        .padding(.vertical, 4)
    }

    private var priorityColor: Color {
        switch task.priority?.lowercased() {
        case "high":
            return .red
        case "medium":
            return .orange
        case "low":
            return .gray
        default:
            return .gray
        }
    }
}
