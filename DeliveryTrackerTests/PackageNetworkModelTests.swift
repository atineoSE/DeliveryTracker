//
//  PackageNetworkModelTests.swift
//  DeliveryTrackerTests
//
//  Created by Adrian Tineo Cabello on 27/4/22.
//

import XCTest
@testable import DeliveryTracker

class PackageNetworkModelTests: XCTestCase {
    func testResidentListFromNetworkModel() {
        // Arrange
        let recipientOne = PackagesNetworkModel.PackageResult.Package.Recipient(name: "Ginny Weasley", email: "ginny@gryffindor.com")
        let recipientTwo = PackagesNetworkModel.PackageResult.Package.Recipient(name: "Ron Weasley", email: "ron@gryffindor.com")
        let packages = [
            PackagesNetworkModel.PackageResult.Package(id: "1", type: "Medium", carrier: "Quality Quidditch Supplies", recipient: recipientOne),
            PackagesNetworkModel.PackageResult.Package(id: "3", type: "Small", carrier: "Quality Quidditch Supplies", recipient: recipientTwo),
            PackagesNetworkModel.PackageResult.Package(id: "6", type: "Medium", carrier: "Honeydukes Sweetshop", recipient: recipientTwo)
        ]
        let networkModel = PackagesNetworkModel(result: .init(packages: packages))
        
        let expectedResidents = [
            Resident(name: "Ginny Weasley", email: "ginny@gryffindor.com", packages: [
                Package(id: "1", type: "Medium", carrier: "Quality Quidditch Supplies")
            ]),
            Resident(name: "Ron Weasley", email: "ron@gryffindor.com", packages: [
                Package(id: "3", type: "Small", carrier: "Quality Quidditch Supplies"),
                Package(id: "6", type: "Medium", carrier: "Honeydukes Sweetshop")
            ]),
        ]
        
        // Act
        let residents = networkModel.residents
        
        // Assert
        XCTAssertEqual(residents, expectedResidents)
    }
}
