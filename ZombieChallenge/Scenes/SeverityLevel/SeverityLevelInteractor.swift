//
//  SeverityLevelInteractor.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

protocol SeverityLevelInteractorProtocol {
    var illness: IllnessItem? { get set }
    
    func savePatientInfo(request: SeverityLevelViewModel.SavePatientInfo.Request)
}

final class SeverityLevelInteractor: SeverityLevelInteractorProtocol {
    var illness: IllnessItem?
    var worker: SeverityLevelWorkerProtocol?
    var presenter: SeverityLevelPresenterProtocol?
    
    func savePatientInfo(request: SeverityLevelViewModel.SavePatientInfo.Request) {
        worker?.savePatientInfo(request: request, { [weak self] response in
            switch response {
            case .success(let data):
                self?.presenter?.presentSavePatientInfo(response: SeverityLevelViewModel.SavePatientInfo.Response(isSuccess: .success(result: data)))
            case .failure(let error):
                self?.presenter?.presentSavePatientInfo(response: SeverityLevelViewModel.SavePatientInfo.Response(isSuccess: .failure(error: error)))
            }
        })
    }
}
