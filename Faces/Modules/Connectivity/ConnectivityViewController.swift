//
//  ConnectivityViewController.swift
//  Faces
//
//  Created by Tom Rochat on 25/12/2021.
//

import UIKit
import Combine

final class ConnectivityViewController: UIViewController, ConnectedViewController {
    // MARK: - UI
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start monitoring", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.addTarget(self, action: #selector(startMonitoring), for: .touchUpInside)
        return button
    }()
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stop monitoring", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(stopMonitoring), for: .touchUpInside)
        return button
    }()

    var bag = Set<AnyCancellable>()

    let viewModel: ConnectivityViewModel

    // MARK: - Lifecycle
    init(viewModel: ConnectivityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        view.addSubview(stopButton)
        stopButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(24)
        }

        bindViewModel()
    }

    func bindViewModel() {
        viewModel.isMonitoring
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isMonitoring in
                self?.view.backgroundColor = isMonitoring ? .systemGreen : .systemRed
            }
            .store(in: &bag)
    }

    // MARK: - Actions
    @objc
    private func startMonitoring() {
        viewModel.startMonitoring()
    }

    @objc
    private func stopMonitoring() {
        viewModel.stopMonitoring()
    }
}
