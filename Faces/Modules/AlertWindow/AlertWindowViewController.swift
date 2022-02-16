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
        button.addTarget(self, action: #selector(showAlertWindow), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let hideWindowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hide the alert window", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.addTarget(self, action: #selector(hideAlertWindow), for: .touchUpInside)
        button.isEnabled = false
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
        view.addSubview(hideWindowButton)
        NSLayoutConstraint.activate([
            windowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            windowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            windowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            windowButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            hideWindowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hideWindowButton.topAnchor.constraint(equalTo: windowButton.bottomAnchor, constant: 24),
        ])
    }

    @objc
    private func showAlertWindow() {
        alertWindow.isHidden = false
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.alertWindow.layer.opacity = 1
        } completion: { _ in
            self.hideWindowButton.isEnabled = true
        }
    }

    @objc
    private func hideAlertWindow() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.alertWindow.layer.opacity = 0
        } completion: { _ in
            self.alertWindow.isHidden = true
            self.hideWindowButton.isEnabled = false
        }
    }
}

final class RedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed.withAlphaComponent(0.5)
    }
}
