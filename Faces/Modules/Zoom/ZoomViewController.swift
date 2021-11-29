//
//  ZoomViewController.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import UIKit
import Combine

final class ZoomViewController: UIViewController, ConnectedViewController {
    let viewModel: ZoomViewModel
    var bag = Set<AnyCancellable>()

    // MARK: - Lifecycle
    init(viewModel: ZoomViewModel) {
        print("zoom!")
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
