//
//  JSONRequest.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

protocol JSONDataRequest: NetworkRequest where ModelType: Decodable {}

extension JSONDataRequest {
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> ModelType {
        guard let data = data else {
            throw NetworkError.unrecoverable
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = try decoder.decode(ModelType.self, from: data)
        return model
    }
}
