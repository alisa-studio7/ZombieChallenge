//
//  SeverityLevelPresenter.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 18/3/21.
//

protocol SeverityLevelPresenterProtocol {
    func presentSavePatientInfo(response: SeverityLevelViewModel.SavePatientInfo.Response)
}

final class SeverityLevelPresenter: SeverityLevelPresenterProtocol {
    
    weak var viewController: SeverityLevelViewControllerProtocol?
    
    func presentSavePatientInfo(response: SeverityLevelViewModel.SavePatientInfo.Response) {
        switch response.isSuccess {
        case .success(let data):
            viewController?.displaySavePatientInfo(viewModel: SeverityLevelViewModel.SavePatientInfo.ViewModel(isSuccess: .success(result: data)))
        case .failure(let error):
            viewController?.displaySavePatientInfo(viewModel: SeverityLevelViewModel.SavePatientInfo.ViewModel(isSuccess: .failure(error: error)))
        }
    }
}
