//
//  ToastViewController.swift
//  Faces
//
//  Created by Tom Rochat on 27/02/2022.
//

import UIKit
import Combine

final class ToastViewController: UIViewController, ConnectedViewController {
    var bag = Set<AnyCancellable>()

    let viewModel: ToastViewModel

    // MARK: - lifecycle
    required init?(coder: NSCoder) { notImplemented() }
    init(viewModel: ToastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemCyan
        bindViewModel()
    }

    func bindViewModel() {
        //
    }
}
