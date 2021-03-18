//
//  SeverityLevelWorker.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 18/3/21.
//

protocol SeverityLevelWorkerProtocol {
    func savePatientInfo(request: SeverityLevelViewModel.SavePatientInfo.Request, _ completion: @escaping (UserResult<Bool>) -> Void)
}

class SeverityLevelWorker: SeverityLevelWorkerProtocol {
    var store: SeverityLevelStore
    
    init(store: SeverityLevelStore) {
        self.store = store
    }
    
    func savePatientInfo(request: SeverityLevelViewModel.SavePatientInfo.Request, _ completion: @escaping (UserResult<Bool>) -> Void) {
        store.savePatientInfo(request: request) { response in
            switch response {
            case .success(let data):
                completion(.success(result: data))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
