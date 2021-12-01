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

    private var latestTranslationValue: CGPoint = .zero

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

    deinit {
        zoomableImageView.removeFromSuperview()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        guard let window = UIApplication.appWindow else {
            assertionFailure("Could not get app window")
            return
        }

        window.addSubview(zoomableImageView)
        zoomableImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let dragDownGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
        dragDownGesture.delegate = self
        zoomableImageView.addGestureRecognizer(dragDownGesture)
    }

    func bindViewModel() { }

    @objc
    func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: zoomableImageView)
        let velocity = sender.velocity(in: zoomableImageView)

        switch sender.state {
        case .changed:
            guard translation.y > 0 else { return }

            latestTranslationValue = translation
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 1,
                options: .curveEaseOut
            ) { [unowned self] in
                self.zoomableImageView.transform = .init(translationX: 0, y: self.latestTranslationValue.y)
            }

        case .ended:
            if velocity.y > 1500 || latestTranslationValue.y > 250 {
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    usingSpringWithDamping: 0.7,
                    initialSpringVelocity: 1,
                    options: .curveEaseOut
                ) { [unowned self] in
                    self.zoomableImageView.transform = .init(translationX: 0, y: zoomableImageView.frame.height)
                } completion: { _ in
                    self.zoomableImageView.removeFromSuperview()
                }
            } else {
                resetImageViewPosition()
            }

        case .cancelled:
            resetImageViewPosition()

        case .began, .possible, .failed:
            break

        @unknown default:
            assertionFailure("unkown pan state")
            break
        }
    }

    private func resetImageViewPosition() {
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 1,
            options: .curveEaseOut
        ) { [unowned self] in
            self.zoomableImageView.transform = .identity
        }
    }
}

extension ZoomViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        zoomableImageView.zoomScale > 1.2
    }
}
