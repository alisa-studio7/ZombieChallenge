//
//  IllnessesViewController.swift
//  ZombieChallenge
//
//  Created by Alisa Sapmun on 16/3/21.
//

import UIKit

protocol IllnessesViewControllerProtocol: class {
    func displayIllnesses(viewModel: IllnessesViewModel.GetIllnesses.ViewModel)
}

class IllnessesViewController: UIViewController {
    
    @IBOutlet weak var illnessesTableView: UITableView!
    var interactor: IllnessesInteractor?
    var router: IllnessesRouter?
    var illnessList: [IllnessItem] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.illnessesTableView.reloadData()
                NativeIndicator.shared.hide()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(viewController: self)
        setupAppearance()
        NativeIndicator.shared.show(view: self.view)
        interactor?.getIllnesses(request: IllnessesViewModel.GetIllnesses.Request())
    }
    
    private func setupAppearance() {
        illnessesTableView.register(
            UINib(nibName: CellIdentifier.illnessCell.rawValue, bundle: nil),
            forCellReuseIdentifier: CellIdentifier.illnessCell.rawValue)
    }
}

extension IllnessesViewController: IllnessesViewControllerProtocol {
    func displayIllnesses(viewModel: IllnessesViewModel.GetIllnesses.ViewModel) {
        switch viewModel.illnesses {
        case .success(let data):
            illnessList = data
        case .failure:
            illnessList = []
        }
    }
}

extension IllnessesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigateToSeverityLevel(illness: illnessList[indexPath.row])
    }
}

extension IllnessesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return illnessList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellIdentifier.illnessCell.rawValue,
                for: indexPath) as? IllnessCell else {
            return UITableViewCell()
        }
        cell.set(illness: illnessList[indexPath.row])
        return cell
    }
}

extension IllnessesViewController {
    func configure(viewController: IllnessesViewController) {
        let presenter = IllnessesPresenter()
        presenter.viewController = viewController
        
        let router = IllnessesRouter()
        router.viewController = viewController
        
        interactor = IllnessesInteractor()
        interactor?.presenter = presenter
        interactor?.worker = IllnessesWorker(store: IllnessesStore())
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
