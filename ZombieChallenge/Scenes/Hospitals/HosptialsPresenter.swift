//
//  HosptialsPresenter.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

protocol HospitalsPresenterProtocol {
    func presentHospitals(response: HospitalsViewModel.GetHospitals.Response)
}

final class HospitalsPresenter: HospitalsPresenterProtocol {
    weak var viewController: HospitalsViewControllerProtocol?
    
    func presentHospitals(response: HospitalsViewModel.GetHospitals.Response) {
        switch response.hospitals {
        case .success(let data):
            viewController?.displayHospitals(viewModel: HospitalsViewModel.GetHospitals.ViewModel(hospitals: .success(result: data)))
        case .failure(let error):
            viewController?.displayHospitals(viewModel: HospitalsViewModel.GetHospitals.ViewModel(hospitals: .failure(error: error)))
        }
    }
}
