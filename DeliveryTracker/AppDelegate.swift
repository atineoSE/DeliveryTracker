//
//  AppDelegate.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import UIKit
import os.log

let AppLogger = Logger.init(subsystem: "com.adriantineo.DeliveryTracker", category: "General")

class AppDelegate: NSObject, UIApplicationDelegate {
    private(set) var networkController: NetworkController!
    var isTesting: Bool {
        ProcessInfo.processInfo.arguments.contains { $0 == "isTesting" }
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        guard !isTesting else { return true }
        
        let session = URLSession(configuration: .default)
        networkController = NetworkController(session: session)
        return true
    }
}
