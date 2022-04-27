//
//  ResidentListViewModelTests.swift
//  DeliveryTrackerTests
//
//  Created by Adrian Tineo Cabello on 27/4/22.
//

import XCTest
@testable import DeliveryTracker

class ResidentListViewModelTests: XCTestCase {
    func testSuccessulPackagesRequestPopulatesResidents() {
        // Arrange
        let networkControllerMock = NetworkControllerMock()
        networkControllerMock.stubbedPackagesNetworkModel = samplePackagesNetworkModel
        let expectation = XCTestExpectation()
        let sut = ResidentListViewModel(networkController: networkControllerMock)
        
        // Act
        sut.loadResidents() {
            expectation.fulfill()
        } failedCompletion: {
            XCTFail("Should not have failed to load residents")
        }
        
        // Assert
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(sut.residents, expectedResidents)
        XCTAssertNil(sut.alert)
    }
    
    func testFailedPackagesRequestTriggersAlert() {
        // Arrange
        let networkControllerMock = NetworkControllerMock()
        let expectation = XCTestExpectation()
        let sut = ResidentListViewModel(networkController: networkControllerMock)
        
        // Act
        sut.loadResidents() {
            XCTFail("Should not have loaded residents")
        } failedCompletion: {
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(sut.residents, [])
        if case .connectionError(_) = sut.alert {
        } else {
            XCTFail("Alert type is not as expected")
        }
    }
}
