//
//  PresentedAlert.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 27/4/22.
//

import SwiftUI

enum PresentedAlert {
    case connectionError(message: String)
    case notificationsSent(name: String, packageCount: Int)
}

extension PresentedAlert {
    var alert: Alert {
        switch self {
        case .connectionError(let message):
            return Alert(
                title: Text("Connection error"),
                message: Text("There was a problem with the connection: \(message)")
            )
        case .notificationsSent(let name, let packageCount):
            return Alert(
                title: Text("Notification sent"),
                message: Text("\(name) has been notified of \(packageCount) new package" + (packageCount > 1 ? "s." : "."))
            )
        }
    }
}

extension PresentedAlert: Identifiable {
    var id: String {
        switch self {
        case .connectionError:
            return "connectionError"
        case .notificationsSent:
            return "notificationsSent"
        }
    }
}
