//
//  IllnessesPresenter.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

protocol IllnessesPresenterProtocol {
    func presentIllnesses(response: IllnessesViewModel.GetIllnesses.Response)
}

final class IllnessesPresenter: IllnessesPresenterProtocol {
    weak var viewController: IllnessesViewControllerProtocol?
    
    func presentIllnesses(response: IllnessesViewModel.GetIllnesses.Response) {
        switch response.illnesses {
        case .success(let data):
            viewController?.displayIllnesses(viewModel: IllnessesViewModel.GetIllnesses.ViewModel(illnesses: .success(result: data)))
        case .failure(let error):
            viewController?.displayIllnesses(viewModel: IllnessesViewModel.GetIllnesses.ViewModel(illnesses: .failure(error: error)))
        }
    }
}
