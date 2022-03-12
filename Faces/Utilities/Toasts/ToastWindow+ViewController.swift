//
//  ToastWindow+ViewController.swift
//  Faces
//
//  Created by Tom Rochat on 27/02/2022.
//

import Foundation
import UIKit

// MARK: - window
final class ToastWindow: UIWindow {
    // MARK: - lifecycle
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    private func commonInit() {

    }
}

// MARK: - view controller
private final class ToastStackViewController: UIViewController {
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
}
