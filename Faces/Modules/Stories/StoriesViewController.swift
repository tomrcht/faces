//
//  StoriesViewController.swift
//  Faces
//
//  Created by Tom Rochat on 14/03/2022.
//

import UIKit
import Combine

final class StoriesViewController: UIViewController, ConnectedViewController {
    // MARK: - ui components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemYellow.withAlphaComponent(0.2)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(addViewToStackView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Remove", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(popViewFromStackView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var bag = Set<AnyCancellable>()
    let viewModel: StoriesViewModel

    // MARK: - lifecycle
    required init?(coder: NSCoder) { notImplemented() }
    init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        makeView()
        bindViewModel()
    }

    private func makeView() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 128),
        ])

        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            // !
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])

        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -32),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            addButton.heightAnchor.constraint(equalToConstant: 24),
        ])

        view.addSubview(removeButton)
        NSLayoutConstraint.activate([
            removeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 32),
            removeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            removeButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }

    func bindViewModel() {
        //
    }

    // MARK: - actions
    @objc
    private func addViewToStackView() {
        let circleView = viewModel.makeCircleView(ofSize: 64)
        stackView.addArrangedSubview(circleView)
    }

    @objc
    private func popViewFromStackView() {
        guard let lastView = stackView.arrangedSubviews.last else {
            return
        }
        stackView.removeArrangedSubview(lastView)
        lastView.removeFromSuperview()
    }
}
