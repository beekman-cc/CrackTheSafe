//
//  CrackTheSafeApp.swift
//  CrackTheSafe
//
//  Created by Robin Beekman on 26/05/2023.
//

import SwiftUI

@main
struct CrackTheSafeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
