//
//  SeverityLevelRouter.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

import UIKit

protocol SeverityLevelRouterProtocol {
    func navigateToHospitals(with illness: IllnessItem, severityLevel: SeverityLevel)
}

class SeverityLevelRouter: SeverityLevelRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func navigateToHospitals(with illness: IllnessItem, severityLevel: SeverityLevel) {
        if let vc = UIStoryboard(name: StoryboardIdentifier.suggestHospital.rawValue,
                                 bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardIdentifier.suggestHospital.rawValue) as? HospitalsViewController {
            vc.interactor?.illness = illness
            vc.interactor?.severity = severityLevel
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
