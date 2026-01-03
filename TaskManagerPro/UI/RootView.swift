//
//  RootView.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

import SwiftUI
import LocalAuthentication

struct RootView: View {
    @State private var unlocked = false

    var body: some View {
        Group {
            if unlocked {
                TaskListView()
            } else {
                Text("Authenticating…")
                    .onAppear(perform: authenticate)
            }
        }
    }

    func authenticate() {
        let context = LAContext()
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: "Secure your tasks") { success, _ in
            DispatchQueue.main.async {
                unlocked = success
            }
        }
    }
}
