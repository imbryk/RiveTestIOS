//
//  RiveTestApp.swift
//  RiveTest
//
//  Created by Leszek.Mzyk on 26/08/2025.
//

import SwiftUI
import SwiftData

@main
struct RiveTestApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PositionData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
