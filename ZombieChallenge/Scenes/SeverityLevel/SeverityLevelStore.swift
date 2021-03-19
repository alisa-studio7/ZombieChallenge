//
//  SeverityLevelStore.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 18/3/21.
//

import Firebase

protocol SeverityLevelStoreProtocol {
    func savePatientInfo(request: SeverityLevelViewModel.SavePatientInfo.Request, _ completion: @escaping (UserResult<Bool>) -> Void)
}

final class SeverityLevelStore: SeverityLevelStoreProtocol {
    func savePatientInfo(request: SeverityLevelViewModel.SavePatientInfo.Request, _ completion: @escaping (UserResult<Bool>) -> Void) {
        Firestore.firestore().collection(FirestoreDB.PATIENT_INFO.rawValue).addDocument(data: [
            FirestoreDB.PATIENT_ILLNESS.rawValue: [
                FirestoreDB.PATIENT_NAME.rawValue: request.illness.name,
                FirestoreDB.PATIENT_ID.rawValue: request.illness.id
            ],
            FirestoreDB.PATIENT_SEVERITY_LEVEL.rawValue: request.levelOfPain
        ]) { (error) in
            if let err = error {
                completion(.failure(error: .error(message: err.localizedDescription)))
            } else {
                completion(.success(result: true))
            }
        }
    }
}
