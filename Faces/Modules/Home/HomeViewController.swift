//
//  HomeViewController.swift
//  Faces
//
//  Created by Tom Rochat on 31/10/2021.
//

import UIKit
import Combine

final class HomeViewController: UITableViewController, ConnectedViewController, RoutableViewController {
    let viewModel: HomeViewModel
    var bag = Set<AnyCancellable>()

    // MARK: - UI
    private lazy var navigationTable: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(NavigationCell.self, forCellReuseIdentifier: NavigationCell.reuseIdentifier)
        table.dataSource = self
        table.delegate = self
        table.rowHeight = 46
        return table
    }()

    // MARK: - Lifecycle
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = navigationTable
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.router.sink { [unowned self] event in
            self.onRouterEvent(event)
        }.store(in: &bag)
    }

    func onRouterEvent(_ event: RouterEvent) {
        if case let .push(controller) = event {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - Table view data source & delegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NavigationCell.reuseIdentifier, for: indexPath)
                as? NavigationCell
        else {
            let newCell = NavigationCell(style: .default, reuseIdentifier: NavigationCell.reuseIdentifier)
            newCell.update(with: viewModel.dataSource[indexPath.row])
            return newCell
        }

        cell.update(with: viewModel.dataSource[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onRowSelected.send(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
