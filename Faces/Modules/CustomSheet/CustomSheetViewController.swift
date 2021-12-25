//
//  CustomSheetViewController.swift
//  Faces
//
//  Created by Tom Rochat on 22/12/2021.
//

import UIKit

final class CustomSheetViewController: UIViewController {
    // MARK: - UI
    private let openSheetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open sheet", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(openSheet), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(openSheetButton)
        openSheetButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    // MARK: - Actions
    @objc
    private func openSheet() {
        print("!")
    }
}
