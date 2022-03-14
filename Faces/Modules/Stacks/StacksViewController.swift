//
//  StacksViewController.swift
//  Faces
//
//  Created by Tom Rochat on 14/03/2022.
//

import UIKit

final class StacksViewController: UIViewController {
    // MARK: - ui components
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.backgroundColor = .systemYellow.withAlphaComponent(0.4)
        return stackView
    }()

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(view.snp.centerY)
        }
    }
}
