//
//  ListItemsViewController.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//  
//

import UIKit
import PaperClipCore

protocol ListItemsViewControllerInput: BaseViewControllerInput {
    func display(_ viewModel: ListItemsViewModel.Content)
    func displayDetail()
    func retry()
}

final class ListItemsViewController: BaseViewController {

    // MARK: - Properties 
    private var interactor: ListItemsInteractorInput?
    private var router: ListItemsRouterInput?
    private var viewModel: ListItemsViewModel.Content? {
        didSet {
            updatedViewModel()
        }
    }

    // MARK: - UI
    private let tableView: UITableView!

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .darkGray
        return activityIndicator
    }()

    // MARK: - Initialization
    init() {
        tableView = .init(frame: .zero)
        super.init(nibName: nil, bundle: nil)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        let interactor = ListItemsInteractor(presenter: ListItemsPresenter(viewController: self))
        self.interactor = interactor
        router = ListItemsRouter(dataStore: interactor, viewController: self)
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        interactor?.loadContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: false)
        }
    }

    private func initializeUI() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(ListItemCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func updatedViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        title = viewModel.title
        activityIndicator.set(animate: viewModel.isActivityLoading)
        tableView.reloadData()
    }
}

// MARK: - ListItemsViewControllerInput
extension ListItemsViewController: ListItemsViewControllerInput {

    func display(_ viewModel: ListItemsViewModel.Content) {
        self.viewModel = viewModel
    }

    func displayDetail() {
        router?.routeToDetail()
    }

    func retry() {
        interactor?.loadContent()
    }
}

// MARK: - UITableViewDataSource
extension ListItemsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel?.cells.isEmpty ?? true) ? 0 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cells.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            fatalError()
        }
        let cell = tableView.dequeueReusableCell(ListItemCell.self)
        cell.set(viewModel.cells[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListItemsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.userDidSelectItem(at: indexPath.row)
    }
}
