//
//  HospitalsViewModel.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

struct HospitalsViewModel {
    struct GetHospitals {
        struct Request {
            let levelOfPain: Int
        }
        
        struct Response {
            let hospitals: UserResult<[Hospital]>
        }
        
        struct ViewModel {
            let hospitals: UserResult<[Hospital]>
        }
    }
}
