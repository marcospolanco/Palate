//
//  PalateApp.swift
//  Palate
//
//  Created by Marco’s Polanco on 6/3/23.
//

import SwiftUI

@main
struct PalateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            AudioPlayerView()
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
