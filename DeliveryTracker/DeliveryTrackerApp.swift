//
//  DeliveryTrackerApp.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import SwiftUI
import os.log

let AppLogger = Logger.init(subsystem: "com.adriantineo.DeliveryTracker", category: "General")

@main
struct DeliveryTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
