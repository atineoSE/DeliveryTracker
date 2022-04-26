//
//  DeliveryTrackerApp.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import SwiftUI

@main
struct DeliveryTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ResidentListView(viewModel: ResidentListViewModel(networkController: delegate.networkController))
            }
        }
    }
}
