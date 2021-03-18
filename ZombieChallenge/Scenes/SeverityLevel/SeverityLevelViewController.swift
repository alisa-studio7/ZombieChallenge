//
//  SeverityLevelViewController.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

import UIKit

protocol SeverityLevelViewControllerProtocol: class {
    func displaySavePatientInfo(viewModel: SeverityLevelViewModel.SavePatientInfo.ViewModel)
}

class SeverityLevelViewController: UIViewController {
    
    var router: SeverityLevelRouter?
    var interactor: SeverityLevelInteractor?
    var severityLevel: SeverityLevel?
    var buttons: [UIButton] = []
    
    @IBOutlet weak var mildButton: UIButton!
    @IBOutlet weak var noPainButton: UIButton!
    @IBOutlet weak var moderateButton: UIButton!
    @IBOutlet weak var severeButton: UIButton!
    @IBOutlet weak var verySevereButton: UIButton!
    @IBOutlet weak var selectedLevelLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func awakeFromNib() {
      super.awakeFromNib()
      configure(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedLevelLabel.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [noPainButton, mildButton, moderateButton, severeButton, verySevereButton]
        setupAppearance()
    }

    func setupAppearance() {
        navigationController?.navigationBar.isHidden = false
        noPainButton.layer.cornerRadius = noPainButton.frame.height/2
        mildButton.layer.cornerRadius = mildButton.frame.height/2
        moderateButton.layer.cornerRadius = moderateButton.frame.height/2
        severeButton.layer.cornerRadius = severeButton.frame.height/2
        verySevereButton.layer.cornerRadius = verySevereButton.frame.height/2
        nextButton.layer.cornerRadius = nextButton.frame.height/2
        validateButton(button: nextButton, isEnable: false)
        
        for button in buttons {
            button.addTarget(self, action: #selector(selectedLevelTapped(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func selectedLevelTapped(sender: UIButton) {
        switch sender {
        case noPainButton:
            selectedLevelLabel.text = SeverityLevel.noPain.rawValue
            severityLevel = SeverityLevel.noPain
        case mildButton:
            selectedLevelLabel.text = SeverityLevel.mild.rawValue
            severityLevel = SeverityLevel.mild
        case moderateButton:
            selectedLevelLabel.text = SeverityLevel.moderate.rawValue
            severityLevel = SeverityLevel.moderate
        case severeButton:
            selectedLevelLabel.text = SeverityLevel.severe.rawValue
            severityLevel = SeverityLevel.severe
        case verySevereButton:
            selectedLevelLabel.text = SeverityLevel.verySevere.rawValue
            severityLevel = SeverityLevel.verySevere
        default:
            break
        }
        validateButton(button: nextButton, isEnable: true)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        NativeIndicator.shared.show(view: view)
        guard let illness = interactor?.illness, let severity = severityLevel else { return }
        let request = SeverityLevelViewModel.SavePatientInfo.Request(illness: illness, levelOfPain: severity.level)
        interactor?.savePatientInfo(request: request)
        validateButton(button: nextButton, isEnable: false)
    }
    
    func validateButton(button: UIButton, isEnable: Bool) {
        button.isEnabled = isEnable
        if isEnable {
            button.layer.opacity = 1.0
        } else {
            button.layer.opacity = 0.4
        }
    }
}

extension SeverityLevelViewController: SeverityLevelViewControllerProtocol {
    func displaySavePatientInfo(viewModel: SeverityLevelViewModel.SavePatientInfo.ViewModel) {
        NativeIndicator.shared.hide()
        guard let illness = interactor?.illness, let severity = severityLevel else { return }
        switch viewModel.isSuccess {
        case .success:
            router?.navigateToHospitals(with: illness, severityLevel: severity)
        case .failure:
            validateButton(button: nextButton, isEnable: true)
            let request = SeverityLevelViewModel.SavePatientInfo.Request(illness: illness, levelOfPain: severity.level)
            interactor?.savePatientInfo(request: request)
        }
    }
}

extension SeverityLevelViewController {
    func configure(viewController: SeverityLevelViewController) {
        router = SeverityLevelRouter()
        router?.viewController = viewController
        
        let presenter = SeverityLevelPresenter()
        presenter.viewController = viewController
        
        interactor = SeverityLevelInteractor()
        interactor?.presenter = presenter
        interactor?.worker = SeverityLevelWorker(store: SeverityLevelStore())
        
        viewController.router = router
        viewController.interactor = interactor
    }
}
