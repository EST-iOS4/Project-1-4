//
//  ProjectGroup4App.swift
//  ProjectGroup4
//
//  Created by 황동혁 on 8/11/25.
//

import SwiftUI
import SwiftData

@main
struct ProjectGroup4App: App {
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(for: ResultSuite.self)
    }
}
