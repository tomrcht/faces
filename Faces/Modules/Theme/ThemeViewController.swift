//
//  ThemeViewController.swift
//  Faces
//
//  Created by Tom Rochat on 14/12/2021.
//

import UIKit
import Combine

final class ThemeViewController: UIViewController, ConnectedViewController {
    // MARK: - UI
    private let fakeButton: UIButton = {
        let button = UIButton()
        button.setTitle("This is a themed button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(updateTheme), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties
    var bag = Set<AnyCancellable>()
    let viewModel: ThemeViewModel

    // MARK: - Lifecycle
    init(viewModel: ThemeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        fakeButton.backgroundColor = viewModel.themeManager.accentColor
        view.addSubview(fakeButton)
        fakeButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        bindViewModel()
    }

    func bindViewModel() {
        //
    }

    // MARK: - Actions
    @objc
    private func updateTheme() {
        viewModel.themeManager.setAccentColor(to: .blue)
    }
}
