//
//  PostEntityRequest.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

class PostEntityRequest<ModelType:Codable>: NetworkRequest, JSONDataRequest {
    let url: URL
    let value: ModelType
    let session: NetworkSession
    var task: ExtendedDataTask?

    init(url: URL, session: NetworkSession, value: ModelType) {
        self.url = url
        self.session = session
        self.value = value
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        request.httpBody = try? encoder.encode(value)
        return request
    }
}
