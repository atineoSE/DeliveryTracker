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

protocol NetworkController {
    func get<ReceivedModelType>(endpoint: Endpoint, completion: @escaping (Result<ReceivedModelType, Error>) -> Void)
    where ReceivedModelType: Decodable & Defaultable
    
    func post<SentModelType, ReceivedModelType>(endpoint: Endpoint, sentModel: SentModelType, completion: @escaping (Result<ReceivedModelType, Error>) -> Void)
    where SentModelType: Encodable, ReceivedModelType: Decodable & Defaultable
}

class AppNetworkController: NSObject, ObservableObject {
    private let session: NetworkSession
    private var requests: [String: AnyObject] = [:]

    init(session: NetworkSession) {
        self.session = session
        requests = [:]
    }
    
    deinit {
        session.invalidate()
    }
}

extension AppNetworkController: NetworkController {
    func get<ReceivedModelType>(
        endpoint: Endpoint,
        completion: @escaping (Result<ReceivedModelType, Error>) -> Void
    ) where ReceivedModelType: Decodable & Defaultable {
        guard requests[endpoint.description] == nil else { return }
        let getRequest = JSONDataRequest<EmptyNetworkModel, ReceivedModelType>(session: session, endpoint: endpoint, method: .get)
        AppLogger.debug("NETWORK: \(getRequest.debugDescription)")
        requests[endpoint.description] = getRequest
        getRequest.execute { [weak self] result in
            completion(result)
            self?.requests[endpoint.description] = nil
        }
    }
    
    func post<SentModelType, ReceivedModelType>(
        endpoint: Endpoint,
        sentModel: SentModelType,
        completion: @escaping (Result<ReceivedModelType, Error>) -> Void
    ) where SentModelType: Encodable, ReceivedModelType: Decodable & Defaultable {
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
