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

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let session = URLSession(configuration: .default)
        networkController = AppNetworkController(session: session)
        return true
    }
}
