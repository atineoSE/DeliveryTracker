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
