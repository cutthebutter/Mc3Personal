//
//  MemoWithWatchApp.swift
//  MemoWithWatch
//
//  Created by semini on 2023/07/17.
//

import SwiftUI

@main
struct MemoWithWatchApp: App {
    @StateObject var store = MemoStore()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
            
        }
    }
}
