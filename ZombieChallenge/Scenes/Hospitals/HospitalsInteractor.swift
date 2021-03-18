//
//  HospitalsInteractor.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

protocol HospitalsInteractorProtocol {
    var illness: IllnessItem? { get set }
    var severity: SeverityLevel? { get set }
    
    func getHospitals(request: HospitalsViewModel.GetHospitals.Request)
}

final class HospitalsInteractor: HospitalsInteractorProtocol {
    var illness: IllnessItem?
    var severity: SeverityLevel?
    
    var presenter: HospitalsPresenterProtocol?
    var worker: HospitalsWorkerProtocol?
    
    func getHospitals(request: HospitalsViewModel.GetHospitals.Request) {
        worker?.getHospitals{ [weak self] response in
            switch response {
            case .success(let data):
                var hospitals = data.hospitals.map { $0 }
                let suggestedHospitals = self?.fileterSuggestedHospitals(&hospitals)
                self?.presenter?.presentHospitals(response: HospitalsViewModel.GetHospitals.Response(hospitals: .success(result: unwrapped(suggestedHospitals, with: []))))
            case .failure(let error):
                self?.presenter?.presentHospitals(response: HospitalsViewModel.GetHospitals.Response(hospitals: .failure(error: error)))
            }
        }
    }
    
    private func fileterSuggestedHospitals(_ hospitals: inout [Hospital]) -> [Hospital] {
        for (idx, hospital) in hospitals.enumerated() {
            let waitingList = hospital.waitingList.filter { item in item.levelOfPain == severity?.level }
            hospitals[idx].waitingList = waitingList
        }
        
        let sortedHospitals = hospitals.sorted { (lhs, rhs) -> Bool in
            let hospital1 = unwrapped(lhs.waitingList.first?.waitingTime, with: 0)
            let hospital2 = unwrapped(rhs.waitingList.first?.waitingTime, with: 0)
            return hospital2 > hospital1
        }
        
        return sortedHospitals
    }
}
