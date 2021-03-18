//
//  IllnessesRouter.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

import UIKit

protocol IllnessesRouterProtocol {
    func navigateToSeverityLevel(illness: IllnessItem)
}

final class IllnessesRouter: IllnessesRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToSeverityLevel(illness: IllnessItem) {
        if let vc = UIStoryboard(name: StoryboardIdentifier.severityLevel.rawValue,
                                 bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardIdentifier.severityLevel.rawValue) as? SeverityLevelViewController {
            vc.interactor?.illness = illness
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
