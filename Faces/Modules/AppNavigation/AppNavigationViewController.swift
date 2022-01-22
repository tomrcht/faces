//
//  AppNavigationViewController.swift
//  Faces
//
//  Created by Tom Rochat on 20/01/2022.
//

import UIKit
import Combine

final class AppNavigationViewController: UIViewController, ConnectedViewController {
    let viewModel: AppNavigationViewModel
    var bag = Set<AnyCancellable>()

    // MARK: - Lifecycle
    required init?(coder: NSCoder) { notImplemented() }
    init(viewModel: AppNavigationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(onTap))
        view.addGestureRecognizer(tapGesture)

        bindViewModel()
    }

    func bindViewModel() {
        viewModel.startRouter(in: self)
    }

    @objc
    private func onTap() {
        viewModel.move()
    }
}
