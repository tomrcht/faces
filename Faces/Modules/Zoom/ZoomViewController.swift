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

        view.addSubview(zoomableImageView)
        zoomableImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        bindViewModel()
    }

    func bindViewModel() {
        //
    }
}
