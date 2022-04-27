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
        let networkModel = samplePackagesNetworkModel
        
        // Act
        let residents = networkModel.residents
        
        // Assert
        XCTAssertEqual(residents, expectedResidents)
    }
}
