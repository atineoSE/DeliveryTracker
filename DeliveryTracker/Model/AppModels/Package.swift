//
//  Package.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

struct Package {
    let id: String
    let type: String
    let carrier: String
}

extension Package {
    init(from package: PackagesNetworkModel.PackageResult.Package) {
        self = Package(id: package.id, type: package.type, carrier: package.carrier)
    }
}

extension Package: CustomStringConvertible {
    var description: String {
        "id: \(id), type: \(type), carrier: \(carrier)"
    }
}
