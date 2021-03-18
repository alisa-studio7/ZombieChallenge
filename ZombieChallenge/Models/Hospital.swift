//
//  Hospital.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

struct Hospitals: Decodable {
    let hospitals: [Hospital]
}

struct Hospital: Decodable {
    let id: Int
    let name: String
    var waitingList: [WaitingList]
}

struct WaitingList: Decodable {
    let patientCount: Int
    let levelOfPain: Int
    let averageProcessTime: Int
    var waitingTime: Int {
        patientCount * averageProcessTime
    }
}
