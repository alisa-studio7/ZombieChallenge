//
//  IllnessesStore.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

protocol IllnessesStoreProtocol {
    func getIllnesses(_ completion: @escaping (UserResult<IllnessList>) -> Void)
}

final class IllnessesStore: Requestable, IllnessesStoreProtocol {
    
    func getIllnesses(_ completion: @escaping (UserResult<IllnessList>) -> Void) {
        let path = Zombie.Core().baseURL+EndPoint.illnesses.rawValue
        let requestData = RequestData(path: path, method: .get, header: nil, params: nil)
        performRequest(request: requestData, completion: completion)
    }
}
