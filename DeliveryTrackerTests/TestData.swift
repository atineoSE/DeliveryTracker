//
//  TestData.swift
//  DeliveryTrackerTests
//
//  Created by Adrian Tineo Cabello on 27/4/22.
//

import Foundation
@testable import DeliveryTracker

let recipientOne = PackagesNetworkModel.PackageResult.Package.Recipient(name: "Ginny Weasley", email: "ginny@gryffindor.com")
let recipientTwo = PackagesNetworkModel.PackageResult.Package.Recipient(name: "Ron Weasley", email: "ron@gryffindor.com")
let samplePackages = [
    PackagesNetworkModel.PackageResult.Package(id: "1", type: "Medium", carrier: "Quality Quidditch Supplies", recipient: recipientOne),
    PackagesNetworkModel.PackageResult.Package(id: "3", type: "Small", carrier: "Quality Quidditch Supplies", recipient: recipientTwo),
    PackagesNetworkModel.PackageResult.Package(id: "6", type: "Medium", carrier: "Honeydukes Sweetshop", recipient: recipientTwo)
]

let expectedResidents = [
    Resident(name: "Ginny Weasley", email: "ginny@gryffindor.com", packages: [
        Package(id: "1", type: "Medium", carrier: "Quality Quidditch Supplies")
    ]),
    Resident(name: "Ron Weasley", email: "ron@gryffindor.com", packages: [
        Package(id: "3", type: "Small", carrier: "Quality Quidditch Supplies"),
        Package(id: "6", type: "Medium", carrier: "Honeydukes Sweetshop")
    ]),
]

let samplePackagesNetworkModel = PackagesNetworkModel(result: .init(packages: samplePackages))
