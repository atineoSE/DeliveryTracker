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

class NetworkController: NSObject, ObservableObject {
    private let session: URLSession
    private var requests: [String: AnyObject] = [:]

    init(session: URLSession) {
        self.session = session
        requests = [:]
    }
    
    deinit {
        session.finishTasksAndInvalidate()
    }
    
    func get<ReceivedModelType>(
        endpoint: Endpoint,
        completion: @escaping (Result<ReceivedModelType, Error>) -> Void
    ) where ReceivedModelType: Decodable {
        guard requests[endpoint.description] == nil else { return }
        let getRequest = JSONDataRequest<EmptyModel, ReceivedModelType>(session: session, endpoint: endpoint, method: .get)
        AppLogger.debug("NETWORK: \(getRequest.debugDescription)")
        requests[endpoint.description] = getRequest
        getRequest.execute { [weak self] result in
            completion(result)
            self?.requests[endpoint.description] = nil
        }
    }
    
    private func post<SentModelType, ReceivedModelType>(
        endpoint: Endpoint,
        sentModel: SentModelType,
        completion: @escaping (Result<ReceivedModelType, Error>) -> Void
    ) where SentModelType: Encodable, ReceivedModelType: Decodable {
        guard requests[endpoint.description] == nil else { return }
        let postRequest = JSONDataRequest<SentModelType, ReceivedModelType>(
            session: session,
            endpoint: endpoint,
            method: .post,
            sentModel: sentModel
        )
        AppLogger.debug("NETWORK: \(postRequest.debugDescription)")
        requests[endpoint.description] = postRequest
        postRequest.execute { [weak self] result in
            completion(result)
            self?.requests[endpoint.description] = nil
        }
    }
}

