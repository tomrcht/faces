//
//  AlertWindowViewController.swift
//  Faces
//
//  Created by Tom Rochat on 16/02/2022.
//

import UIKit

final class AlertWindowViewController: UIViewController {
    // MARK: - ui
    private let windowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Do something with a window? idk how that works...", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(spawnAlertWindow), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var alertWindow: AlertWindow = {
        // Please don't force downcast here
        let windowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let window = AlertWindow(windowScene: windowScene)
        window.rootViewController = RedViewController(nibName: nil, bundle: nil)
        window.isHidden = true
        window.layer.opacity = 0
        return window
    }()

    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(windowButton)
        NSLayoutConstraint.activate([
            windowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            windowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            windowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            windowButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc
    private func spawnAlertWindow() {
        alertWindow.isHidden = false
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.alertWindow.layer.opacity = 1
        } completion: { _ in }
    }
}

final class RedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed.withAlphaComponent(0.5)
    }
}
