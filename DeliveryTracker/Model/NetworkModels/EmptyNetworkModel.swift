//
//  EmptyModel.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

struct EmptyNetworkModel: Codable {}

extension EmptyNetworkModel: Defaultable {
    static var empty: EmptyNetworkModel {
        Self()
    }
}
