//
//  NetworkControllerMock.swift
//  DeliveryTrackerTests
//
//  Created by Adrian Tineo Cabello on 27/4/22.
//

import Foundation
@testable import DeliveryTracker
import XCTest

struct MockError: Error {}

class NetworkControllerMock: NetworkController {
    var stubbedPackagesNetworkModel: PackagesNetworkModel?
    
    func get<ReceivedModelType>(endpoint: Endpoint, completion: @escaping (Result<ReceivedModelType, Error>) -> Void) where ReceivedModelType: Defaultable, ReceivedModelType: Decodable {
        guard let stubbedPackagesNetworkModel = stubbedPackagesNetworkModel else {
            let result = Result { () throws -> ReceivedModelType in
                throw MockError()
            }
            completion(result)
            return
        }
        let data = try! JSONEncoder().encode(stubbedPackagesNetworkModel)
        let result = Result { () throws -> ReceivedModelType in
            return try! JSONDecoder().decode(ReceivedModelType.self, from: data)
        }
        completion(result)
    }
    
    func post<SentModelType, ReceivedModelType>(endpoint: Endpoint, sentModel: SentModelType, completion: @escaping (Result<ReceivedModelType, Error>) -> Void) where SentModelType: Encodable, ReceivedModelType : Defaultable, ReceivedModelType : Decodable {
        
    }
}
