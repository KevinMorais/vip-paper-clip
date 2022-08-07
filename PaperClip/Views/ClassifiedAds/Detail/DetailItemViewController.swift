//
//  DetailItemViewController.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//  
//

import UIKit
import PaperClipDesignKit

protocol DetailItemViewControllerInput: BaseViewControllerInput {
    func display(_ viewModel: DetailItemViewModel.Content)
}

final class DetailItemViewController: BaseViewController {

    // MARK: - Properties 
    var interactor: DetailItemInteractorInput?
    var router: (DetailItemRouterInput & DetailItemDataPassing)?
    private var viewModel: DetailItemViewModel.Content? {
        didSet {
            updatedViewModel()
        }
    }

    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        let interactor = DetailItemInteractor(presenter: DetailItemPresenter(viewController: self))
        self.interactor = interactor
        self.router = DetailItemRouter(dataStore: interactor, viewController: self)
    }

    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        setUpUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        interactor?.loadContent()
    }

    private func setUpUI() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }

    private func setUpTableView() {
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(DetailItemHeaderTableViewCell.self)
        tableView.register(DetailItemInformationTableViewCell.self)
        tableView.register(DetailItemContentTableViewCell.self)
    }

    private func updatedViewModel() {
        tableView.reloadData()
    }

    private func cell(at index: Int) -> UITableViewCell {
        let cellViewModel = viewModel?.cells[index]
        if let cellViewModel = cellViewModel as? DetailItemViewModel.HeaderCell {
            let cell = tableView.dequeueReusableCell(DetailItemHeaderTableViewCell.self)
            cell.set(cellViewModel)
            return cell
        } else if let cellViewModel = cellViewModel as? DetailItemViewModel.InformationCell {
            let cell = tableView.dequeueReusableCell(DetailItemInformationTableViewCell.self)
            cell.set(cellViewModel)
            return cell
        } else if let cellViewModel = cellViewModel as? DetailItemViewModel.ContentCell {
            let cell = tableView.dequeueReusableCell(DetailItemContentTableViewCell.self)
            cell.set(cellViewModel)
            return cell
        }
        fatalError()
    }
}

// MARK: - DetailItemViewControllerInput
extension DetailItemViewController: DetailItemViewControllerInput {

    func display(_ viewModel: DetailItemViewModel.Content) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDataSource
extension DetailItemViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.cells != nil ? 1 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cells.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(at: indexPath.row)
    }
}
