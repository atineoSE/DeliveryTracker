//
//  NetworkError.swift
//  DeliveryTracker
//
//  Created by Adrian Tineo Cabello on 26/4/22.
//

import Foundation

enum NetworkError: Error {
    case unauthorized
    case unrecoverable
    case temporary
    case unreachable
}

extension HTTPURLResponse {
    func validate() throws {
        switch statusCode {
        case 401:
            AppLogger.debug("HTTP CLIENT ERROR: statusCode 401 (unauthorized): \(self)")
            throw NetworkError.unauthorized
        case 404:
            AppLogger.debug("HTTP CLIENT ERROR: statusCode 404 (not found) - throwing NetworkError.unrecoverable: \(self)")
            throw NetworkError.unrecoverable
        case 400, 402, 403, 405 ..< 500:
            AppLogger.debug("HTTP CLIENT ERROR: statusCode \(self.statusCode) - throwing NetworkError.unrecoverable: \(self)")
            throw NetworkError.unrecoverable
        case 500 ..< 600:
            AppLogger.debug("HTTP SERVER ERROR: statusCode \(self.statusCode) - throwing NetworkError.temporary: \(self)")
            throw NetworkError.temporary
        default: break
        }
    }
}

extension Error {
    func toNetworkError() throws {
        switch self {
        case URLError.cannotConnectToHost,
             URLError.networkConnectionLost,
             URLError.notConnectedToInternet,
             URLError.timedOut:
            throw NetworkError.unreachable
        default:
            throw NetworkError.unrecoverable
        }
    }
}


