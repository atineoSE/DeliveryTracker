//
//  Endpoint.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

enum Endpoint {
    case packages
    case notifications
}

extension Endpoint {
    var url: URL? {
        switch self {
        case .packages:
            return AppAPI.baseURL.appendingPathComponent("icu4lrltnqy8avbhx1iydcmz8x32roya")
        case .notifications:
            return AppAPI.baseURL.appendingPathComponent("qru1b8pse4hcr12ojiyala2wigym8h4y")
        }
    }
}

extension Endpoint: Hashable {}

extension Endpoint: CustomStringConvertible {
    var description: String {
        switch self {
        case .packages:
            return "packages"
        case .notifications:
            return "notifications"
        }
    }
}
