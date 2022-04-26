//
//  PackageNetworkModel.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

struct PackagesNetworkModel: Decodable {
    struct PackageResult: Decodable {
        struct Package: Decodable {
            struct Recipient: Decodable {
                let name: String
                let email: String
            }
            let id: String
            let type: String
            let carrier: String
            let recipient: Recipient
        }
        let packages: [Package]
    }
    let result: PackageResult
}

extension PackagesNetworkModel {
    var residents: [Resident] {
        []
    }
}

extension PackagesNetworkModel: CustomStringConvertible {
    var description: String {
        var description = ""
        for package in result.packages {
            description.append("\tid: \(package.id), type: \(package.type), carrier: \(package.carrier), \(package.recipient.description)\n")
        }
        return description
    }
}

extension PackagesNetworkModel.PackageResult.Package.Recipient: CustomStringConvertible {
    var description: String {
        "name: \(name), email: \(email)"
    }
}
