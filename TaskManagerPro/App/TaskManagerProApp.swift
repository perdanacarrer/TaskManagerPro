//
//  TaskManagerProApp.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import SwiftUI
import FirebaseCore

@main
struct TaskManagerProApp: App {
    let persistence = PersistenceController.shared

    init() {
        if FirebaseApp.app() == nil,
           Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil {
            FirebaseApp.configure()
        }
    }
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}

