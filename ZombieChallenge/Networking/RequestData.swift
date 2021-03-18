//
//  RequestData.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

struct RequestData {
    let path: String
    let method: HTTPMethod
    let header: [String: String]?
    let params: [String: Any?]?
}
