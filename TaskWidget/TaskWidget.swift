//
//  TaskWidget.swift
//  TaskWidget
//
//  Created by oscar perdana on 04/01/26.
//

import WidgetKit
import SwiftUI

struct TaskEntry: TimelineEntry {
    let date: Date
    let taskCount: Int
}

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> TaskEntry {
        TaskEntry(date: Date(), taskCount: 3)
    }

    func getSnapshot(in context: Context,
                     completion: @escaping (TaskEntry) -> Void) {
        completion(TaskEntry(date: Date(), taskCount: 5))
    }

    func getTimeline(in context: Context,
                     completion: @escaping (Timeline<TaskEntry>) -> Void) {

        let count = WidgetTaskStore.shared.taskCount()

        let entry = TaskEntry(
            date: Date(),
            taskCount: count
        )

        let timeline: Timeline<TaskEntry> = Timeline(
            entries: [entry],
            policy: .after(Date().addingTimeInterval(300))
        )

        completion(timeline)
    }
}

struct TaskWidget: Widget {

    let kind = "TaskWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TaskWidgetView(entry: entry)
        }
        .configurationDisplayName("Task Manager")
        .description("Quick overview of your tasks")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct TaskWidgetView: View {

    let entry: TaskEntry

    var body: some View {
        VStack(spacing: 8) {
            Text("Tasks")
                .font(.headline)

            Text("\(entry.taskCount)")
                .font(.system(size: 40, weight: .bold))
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }
}
