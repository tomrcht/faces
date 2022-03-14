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
    private let statusMonitoringButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemGreen, for: .normal)
        button.addTarget(self, action: #selector(toggleMonitoring), for: .touchUpInside)
        return button
    }()
    private let statusInformationsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    private let connectionUpDownStatus: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    private let connectionConstrainedStatus: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    private let connectionExpensiveStatus: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()


    var bag = Set<AnyCancellable>()
    let viewModel: ConnectivityViewModel

    // MARK: - Lifecycle
    required init?(coder: NSCoder) { notImplemented() }
    init(viewModel: ConnectivityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeView()
        bindViewModel()
    }

    func makeView() {
        view.backgroundColor = .white

        // toggle button
        view.addSubview(statusMonitoringButton)
        statusMonitoringButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }

        // informations stack view
        view.addSubview(statusInformationsStack)

        statusInformationsStack.backgroundColor = .systemBlue.withAlphaComponent(0.4)
        statusInformationsStack.addArrangedSubview(connectionUpDownStatus)
        statusInformationsStack.addArrangedSubview(connectionConstrainedStatus)
        statusInformationsStack.addArrangedSubview(connectionExpensiveStatus)

        statusInformationsStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(statusMonitoringButton.snp.top)
        }
    }

    func bindViewModel() {
        viewModel.isMonitoring
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] isMonitoring in
                if isMonitoring {
                    self.didStartMonitoring()
                } else {
                    self.didStopMonitoring()
                }
            }
            .store(in: &bag)

        viewModel.connectionStatus
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] status in
                switch status {
                case .ko:
                    self.connectionUpDownStatus.text = "connection status: ko"
                    self.connectionConstrainedStatus.isHidden = true
                    self.connectionExpensiveStatus.isHidden = true

                case .unknown:
                    self.connectionUpDownStatus.text = "connection status: unknown"
                    self.connectionConstrainedStatus.isHidden = true
                    self.connectionExpensiveStatus.isHidden = true

                case .ok(let constrained, let expensive):
                    self.connectionUpDownStatus.text = "connection status: ok"
                    self.connectionConstrainedStatus.isHidden = false
                    self.connectionExpensiveStatus.isHidden = false
                    self.connectionConstrainedStatus.text = "is constrained: \(constrained ? "yes" : "no")"
                    self.connectionExpensiveStatus.text = "is expensive: \(expensive ? "yes" : "no")"
                }
            }
            .store(in: &bag)
    }

    // MARK: - Actions
    @objc
    private func toggleMonitoring() {
        viewModel.toggleMonitoring()
    }

    // MARK: - UI Updates
    private func didStartMonitoring() {
        statusMonitoringButton.setTitle("Stop monitoring", for: .normal)
        statusMonitoringButton.setTitleColor(.systemRed, for: .normal)
    }

    private func didStopMonitoring() {
        statusMonitoringButton.setTitle("Start monitoring", for: .normal)
        statusMonitoringButton.setTitleColor(.systemGreen, for: .normal)
    }
}
