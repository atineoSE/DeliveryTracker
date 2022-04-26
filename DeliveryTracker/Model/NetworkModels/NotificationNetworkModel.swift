//
//  NotificationNetworkModel.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

struct NotificationNetworkModel: Encodable {
    struct Notification: Encodable {
        let email: String
        let content: String
    }
    let notify: [Notification]
}

extension NotificationNetworkModel {
    init(from resident: Resident) {
        let notification = Notification(
            email: resident.email,
            content: resident.packages.map{ "\($0.type), \($0.carrier))" }.joined(separator: ";")
        )
        self = NotificationNetworkModel(notify: [notification])
    }
}
