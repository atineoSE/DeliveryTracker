//
//  PackageNetworkModel.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

struct PackagesNetworkModel: Codable {
    struct PackageResult: Codable {
        struct Package: Codable {
            struct Recipient: Codable {
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


extension PackagesNetworkModel.PackageResult {
    static let emptyModel = Self(packages: [])
}

extension PackagesNetworkModel {
    static let emptyModel = PackagesNetworkModel(result: .emptyModel)
    
    var residents: [Resident] {
        var residents: [String: Resident] = [:]
        result.packages.forEach { package in
            let residentId = package.recipient.email
            let resident = residents[residentId] ?? Resident(name: package.recipient.name, email: package.recipient.email, packages: [])
            residents[residentId] = resident.adding(Package(from: package))
        }
        return residents.values.sorted(by: { $0.name < $1.name })
    }
}

extension PackagesNetworkModel: Defaultable {
    static var empty: PackagesNetworkModel {
        .emptyModel
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
