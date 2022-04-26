//
//  NetworkController.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation
import UIKit

protocol EndpointConvertible {
    var endpoint: URL { get }
}

class NetworkController: NSObject {
    private let session: URLSession
    private var requests: [URL: AnyObject] = [:]

    init(session: URLSession) {
        self.session = session
        requests = [:]
    }
    
    deinit {
        session.finishTasksAndInvalidate()
    }
    
    func get<ModelType>(url: URL, completion: @escaping (Result<ModelType, Error>) -> Void) where ModelType: Decodable {
        let getRequest = GetEntityRequest<ModelType>(url: url, session: session)
        requests[url] = getRequest
        getRequest.execute { [weak self] result in
            completion(result)
            self?.requests[url] = nil
        }
    }
    
    func post<ModelType>(url: URL, value: ModelType, completion: @escaping (Result<ModelType, Error>) -> Void) where ModelType: Codable {
        let postRequest = PostEntityRequest<ModelType>(url: url, session: session, value: value)
        requests[url] = postRequest
        postRequest.execute { [weak self] result in
            completion(result)
            self?.requests[url] = nil
        }
    }
}

