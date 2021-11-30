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

    // MARK: - UI
    private lazy var zoomableImageView: ZoomableImageView = {
        let image = UIImage(named: "test")!
        let imageView = ZoomableImageView(image: image)
        return imageView
    }()

    // MARK: - Lifecycle
    init(viewModel: ZoomViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

//        view.addSubview(zoomableImageView)
//        zoomableImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }

//        bindViewModel()

        guard let window = UIApplication.appWindow else {
            assertionFailure("Could not get app window")
            return
        }

        window.addSubview(zoomableImageView)
        zoomableImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func bindViewModel() {
        //
    }
}
