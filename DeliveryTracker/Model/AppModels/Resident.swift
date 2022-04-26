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

extension Resident {
    func adding(_ newPackage: Package) -> Self {
        Resident(name: name, email: email, packages: packages + [newPackage])
    }
}

extension Resident: CustomStringConvertible {
    var description: String {
        "name: \(name), email: \(email), packages: \(packages.map({$0.description}).joined(separator: ";"))"
    }
}
