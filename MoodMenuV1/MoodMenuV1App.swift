//
//  MoodMenuV1App.swift
//  MoodMenuV1
//
//  Created by Matt Da Silva on 14/05/2024.
//

import SwiftUI

@main
struct MoodMenuV1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
