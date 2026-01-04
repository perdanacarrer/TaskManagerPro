//
//  UITestEnvironment.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 04/01/26.
//

import Foundation

enum UITestEnvironment {
    static var isUITest: Bool {
        ProcessInfo.processInfo.arguments.contains("UITEST_MODE")
    }
}
