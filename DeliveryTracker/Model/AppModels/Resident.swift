//
//  Resident.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

struct Resident {
    let name: String
    let email: String
    let packages: [Package]
}

extension Resident: Identifiable {
    var id: String {
        email
    }
}
