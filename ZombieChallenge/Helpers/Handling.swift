//
//  Handling.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

import Foundation

enum UserResult<T> {
    case success(result: T)
    case failure(error: APIError)
}

enum APIError: Error {
    case invalidRequest
    case jsonParsingFailed
    case unAuthorized
    case forbiddenRequest
    case internalServerError
    case serviceUnavailabel
    case firebaseError(message: String)
    case genericError
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        case .jsonParsingFailed:
            return "Json Parsing Failed"
        case .unAuthorized:
            return "Client failed to authenticate with the server"
        case .forbiddenRequest:
            return "Client authenticated but does not have permission to access the requested resource"
        case .internalServerError:
            return "Internal Server Error"
        case .serviceUnavailabel:
            return "Service Unavailable"
        case .firebaseError(let message):
            return message
        case .genericError:
            return "Something went wrong"
        }
    }
}
