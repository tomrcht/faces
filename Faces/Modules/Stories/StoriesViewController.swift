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
    private lazy var overflowLabel: UILabel = {
        let label = UILabel()
        label.text = "Content overflows its scrollview"
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 12)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

        view.addSubview(overflowLabel)
        NSLayoutConstraint.activate([
            overflowLabel.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 16),
            overflowLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
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
        viewModel.circles
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] circleView in
                self.stackView.addArrangedSubview(circleView)
                self.udpateOverflowLabelVisibility()
            }
            .store(in: &bag)
    }

    private func udpateOverflowLabelVisibility() {
        overflowLabel.isHidden = !(scrollView.contentSize.width > scrollView.bounds.width - 64)
    }

    // MARK: - actions
    @objc
    private func addViewToStackView() {
        // Useless, should be done in the view controller, but hey ¯\_(ツ)_/¯
        viewModel.getNewCircleView(ofSize: 64)
    }

    @objc
    private func popViewFromStackView() {
        guard let lastView = stackView.arrangedSubviews.last else {
            return
        }
        stackView.removeArrangedSubview(lastView)
        lastView.removeFromSuperview()
        udpateOverflowLabelVisibility()
    }
}
