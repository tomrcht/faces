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
    private lazy var showImageViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show!", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(onShowTapped), for: .touchUpInside)
        return button
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

        view.addSubview(showImageViewButton)
        showImageViewButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func bindViewModel() { }

    // MARK: - Selectors
    @objc
    private func onShowTapped() {
        guard let window = UIApplication.appWindow else {
            assertionFailure("Could not get app window")
            return
        }

        zoomableImageView.transform = .identity
        zoomableImageView.layer.opacity = 0
        window.addSubview(zoomableImageView)
        zoomableImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let dragDownGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler))
        dragDownGesture.delegate = self
        zoomableImageView.addGestureRecognizer(dragDownGesture)

        UIView.animate(withDuration: 0.2) { [unowned self] in
            self.zoomableImageView.layer.opacity = 1
        }
    }

    @objc
    private func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: zoomableImageView)
        let velocity = sender.velocity(in: zoomableImageView)

        switch sender.state {
        case .changed:
            latestTranslationValue = translation
            // We COULD animate here but there isn't really a visible difference
            // We could also play with the scale but it gives a rather wonky effect so let's not
            zoomableImageView.layer.opacity = 1 - Float(abs(translation.y) / 1_000)
            zoomableImageView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)

        case .ended:
            if velocity.y > 1500 || latestTranslationValue.y > 250 {
                removeImageView()
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

    private func removeImageView() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: .curveEaseOut
        ) { [unowned self] in
            let imageViewHeight = self.zoomableImageView.frame.height
            self.zoomableImageView.transform = CGAffineTransform(
                translationX: self.latestTranslationValue.x,
                y: imageViewHeight)
        } completion: { [unowned self] _ in
            self.zoomableImageView.removeFromSuperview()
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
            self.zoomableImageView.layer.opacity = 1
            self.zoomableImageView.transform = .identity
        }
    }
}

extension ZoomViewController: UIGestureRecognizerDelegate {
    // If the view is currently zoomed-in more than 1.2x, we ignore the dismiss gesture
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        zoomableImageView.zoomScale > 1.2
    }
}
