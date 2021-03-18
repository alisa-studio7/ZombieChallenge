//
//  HospitalsStore.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

import Firebase

protocol HospitalsStoreProtocol {
    func getHospitals(_ completion: @escaping (UserResult<Hospitals>) -> Void)
}

final class HospitalsStore: Requestable, HospitalsStoreProtocol {
    func getHospitals(_ completion: @escaping (UserResult<Hospitals>) -> Void) {
        let path = Zombie.Core().baseURL+EndPoint.hospitals.rawValue
        let requestData = RequestData(path: path, method: .get, header: nil, params: nil)
        performRequest(request: requestData, completion: completion)
    }
}
