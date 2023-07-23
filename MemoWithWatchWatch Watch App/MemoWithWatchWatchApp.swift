//
//  MemoWithWatchWatchApp.swift
//  MemoWithWatchWatch Watch App
//
//  Created by semini on 2023/07/19.
//

import SwiftUI
import WatchKit

@main
struct MemoWithWatchWatch_Watch_AppApp: App {
    @StateObject var store = MemoStore()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(store)
        }
    }
}


