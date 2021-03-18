//
//  IllnesseseWorker.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

protocol IllnessesWorkerProtocol {
    func getIllnessList(_ completion: @escaping (UserResult<IllnessList>) -> Void)
}

class IllnessesWorker: IllnessesWorkerProtocol {
    var store: IllnessesStore?

    init(store: IllnessesStore) {
        self.store = store
    }
    
    func getIllnessList(_ completion: @escaping (UserResult<IllnessList>) -> Void) {
        store?.getIllnesses{ response in
            switch response {
            case .success(let result):
                completion(.success(result: result))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
