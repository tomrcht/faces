//
//  AsyncViewController.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import UIKit
import Combine

final class AsyncViewController: UIViewController, ConnectedViewController {
    let viewModel: AsyncViewModel
    var bag = Set<AnyCancellable>()

    // MARK: - UI
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .systemRed
        label.numberOfLines = 0
        return label
    }()
    private lazy var queryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kanye", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.addTarget(self, action: #selector(getQuote), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    init(viewModel: AsyncViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(quoteLabel)
        quoteLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets.horizontal(16))
            make.centerY.equalToSuperview()
        }

        view.addSubview(queryButton)
        queryButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets.horizontal(16))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-8)
        }

        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(queryButton.snp.top).offset(-16)
        }

        bindViewModel()
    }

    func bindViewModel() {
        viewModel.isLoading
            .map { !$0 }
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: queryButton)
            .store(in: &bag)

        viewModel.currentQuote
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let value = value else { return }
                self?.quoteLabel.text = value.quote
            }
            .store(in: &bag)

        viewModel.currentError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let error = error else {
                    self?.errorLabel.text = ""
                    return
                }
                self?.errorLabel.text = error.localizedDescription
            }
            .store(in: &bag)
    }

    // MARK: - Actions
    @objc
    private func getQuote() {
        viewModel.getNewQuote()
    }
}
