//
//  IllnessesInteractor.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

protocol IllnessesInteractorProtocol {
    func getIllnesses(request: IllnessesViewModel.GetIllnesses.Request)
}

final class IllnessesInteractor: IllnessesInteractorProtocol {
    var presenter: IllnessesPresenterProtocol?
    var worker: IllnessesWorkerProtocol?
    
    func getIllnesses(request: IllnessesViewModel.GetIllnesses.Request) {
        worker?.getIllnessList { [weak self] response in
            switch response {
            case .success(let data):
                let illnessList = data.illnesses.map { $0.illness }
                self?.presenter?.presentIllnesses(response: IllnessesViewModel.GetIllnesses.Response(illnesses: .success(result: illnessList)))
            case .failure(let error):
                self?.presenter?.presentIllnesses(response: IllnessesViewModel.GetIllnesses.Response(illnesses: .failure(error: error)))
            }
        }
    }
}
