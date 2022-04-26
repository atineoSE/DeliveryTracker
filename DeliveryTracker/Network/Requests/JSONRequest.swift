//
//  JSONRequest.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class JSONDataRequest<SentModel: Encodable, ReceivedModelType: Decodable>: NetworkRequest {
    let session: NetworkSession
    let endpoint: Endpoint
    var method: HTTPMethod
    var sentModel: SentModel?
    var task: ExtendedDataTask?
    
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private lazy var decoder: JSONDecoder =  {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    init(
        session: NetworkSession,
        endpoint: Endpoint,
        method: HTTPMethod = .get,
        sentModel: SentModel? = nil
    ) {
        self.session = session
        self.endpoint = endpoint
        self.method = method
        self.sentModel = sentModel
    }
    
    var urlRequest: URLRequest? {
        guard let url = endpoint.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if case .post = method, let sentModel = sentModel {
            request.httpBody = try? encoder.encode(sentModel)
        }
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
        
        return request
    }
}

extension JSONDataRequest {
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> ReceivedModelType {
        guard let data = data else {
            throw NetworkError.unrecoverable
        }
        let model = try decoder.decode(ReceivedModelType.self, from: data)
        return model
    }
}


// MARK: CustomDebugStringConvertible

extension JSONDataRequest: CustomDebugStringConvertible {
    var debugDescription: String {
        let requestString = "JSONDataRequest: \(method.rawValue) - URL: \(String(describing: urlRequest?.url?.absoluteString))"
        var headersString = ""
        if let headerFields = urlRequest?.allHTTPHeaderFields {
            headersString += "\n\tHEADERS:"
            for (key, value) in headerFields {
                headersString += "\n\t\t\(key) : \(value)"
            }
        }
        var bodyString = ""
        if method == .post {
            bodyString += "\n\tBODY: \n\t\t\(String(describing: sentModel))"
        }
        return requestString + headersString + bodyString
    }
}
