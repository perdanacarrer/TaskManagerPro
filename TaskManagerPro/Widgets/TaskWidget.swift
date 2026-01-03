//
//  TaskWidget.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
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

        // Production: fetch from Core Data (App Group)
        let entry = TaskEntry(date: Date(), taskCount: 10)

        let timeline = Timeline(entries: [entry], policy: .after(.now.addingTimeInterval(3600)))
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
    }
}
