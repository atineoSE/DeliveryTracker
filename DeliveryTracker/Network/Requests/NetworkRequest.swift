//
//  NetworkRequest.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

protocol ExtendedDataTask {
    func resume()
}

protocol NetworkSession {
    func extendedDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> ExtendedDataTask
}

extension URLSessionDataTask: ExtendedDataTask {}

extension URLSession: NetworkSession {
    func extendedDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> ExtendedDataTask {
        return dataTask(with: request, completionHandler: completionHandler) as ExtendedDataTask
    }
}

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    var urlRequest: URLRequest { get }
    var session: NetworkSession { get }
    var task: ExtendedDataTask? { get set }
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> ModelType
}

extension NetworkRequest {
    func execute(withCompletion completion: @escaping (Result<ModelType, Error>) -> Void) {
        task = session.extendedDataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let strongSelf = self else {
                return
            }
            let result = Result { () throws -> ModelType in
                try error?.toNetworkError()
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkError.unrecoverable
                }
                try response.validate()
                return try strongSelf.deserialize(data, response: response)
            }
            completion(result)
        }
        task?.resume()
    }
}
