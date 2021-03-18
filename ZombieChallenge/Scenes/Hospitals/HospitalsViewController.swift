//
//  HospitalsViewController.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 17/3/21.
//

import UIKit

protocol HospitalsViewControllerProtocol: class {
    func displayHospitals(viewModel: HospitalsViewModel.GetHospitals.ViewModel)
}

class HospitalsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var interactor: HospitalsInteractor?
    var hospitals: [Hospital] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                NativeIndicator.shared.hide()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        NativeIndicator.shared.show(view: self.view)
        interactor?.getHospitals(request: HospitalsViewModel.GetHospitals.Request(levelOfPain: unwrapped(interactor?.severity?.level, with: 0)))
    }
    
    func setupAppearance() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        tableView.register(
            UINib(nibName: CellIdentifier.hospitalCell.rawValue, bundle: nil),
            forCellReuseIdentifier: CellIdentifier.hospitalCell.rawValue)
    }
}

extension HospitalsViewController: HospitalsViewControllerProtocol {
    func displayHospitals(viewModel: HospitalsViewModel.GetHospitals.ViewModel) {
        switch viewModel.hospitals {
        case .success(let data):
            hospitals = data
        case .failure:
            hospitals = []
        }
    }
}

extension HospitalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension HospitalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.hospitalCell.rawValue, for: indexPath) as? HospitalCell else {
            return UITableViewCell()
        }
        cell.set(suggestedHospital: hospitals[indexPath.row])
        return cell
    }
}

extension HospitalsViewController {
    func configure(viewController: HospitalsViewController) {
        let presenter = HospitalsPresenter()
        presenter.viewController = viewController
        
        interactor = HospitalsInteractor()
        interactor?.presenter = presenter
        interactor?.worker = HospitalsWorker(store: HospitalsStore())
        
        viewController.interactor = interactor
    }
}
