//
//  Illness.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

struct IllnessItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, id
    }
    
    let name: String
    let id: Int
}

struct Illness: Decodable {
    let illness: IllnessItem
}

struct IllnessList: Decodable {
    let illnesses: [Illness]
}
