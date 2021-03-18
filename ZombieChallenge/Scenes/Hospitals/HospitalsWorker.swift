//
//  HospitalsWorker.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

protocol HospitalsWorkerProtocol {
    func getHospitals(_ completion: @escaping (UserResult<Hospitals>) -> Void)
}

class HospitalsWorker: HospitalsWorkerProtocol {
    var store: HospitalsStore
    
    init(store: HospitalsStore) {
        self.store = store
    }
    
    func getHospitals(_ completion: @escaping (UserResult<Hospitals>) -> Void) {
        store.getHospitals { response in
            switch response {
            case .success(let data):
                completion(.success(result: data))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
