//
//  GetEntityRequest.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

class GetEntityRequest<ModelType: Decodable>: NetworkRequest, JSONDataRequest {
    let url: URL
    let session: NetworkSession
    var task: ExtendedDataTask?

    init(url: URL, session: NetworkSession) {
        self.url = url
        self.session = session
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
