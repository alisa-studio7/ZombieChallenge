//
//  SeverityLevelViewModel.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 18/3/21.
//

struct SeverityLevelViewModel {
    struct SavePatientInfo {
        struct Request {
            let illness: IllnessItem
            let levelOfPain: Int
        }
        
        struct Response {
            let isSuccess: UserResult<Bool>
        }
        
        struct ViewModel {
            let isSuccess: UserResult<Bool>
        }
    }
}
