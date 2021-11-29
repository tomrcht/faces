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

    // MARK: - Lifecycle
    init(viewModel: AsyncViewModel) {
        print("async!")
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        bindViewModel()
    }

    func bindViewModel() {
        //
    }
}
