//
//  IllnessesViewModel.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

struct IllnessesViewModel {
    
    struct GetIllnesses {
        struct Request {}
        
        struct Response {
            let illnesses: UserResult<[IllnessItem]>
        }
        
        struct ViewModel {
            let illnesses: UserResult<[IllnessItem]>
        }
    }
    
}
