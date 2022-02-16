//
//  ActionSheetViewController.swift
//  Faces
//
//  Created by Tom Rochat on 03/01/2022.
//

import Foundation
import UIKit

final class ActionSheetViewController: UIViewController {
    private let animated: Bool
    private let contentSize: Size
    private var bottomOffset: CGFloat {
        25
    }

    // MARK: - UI components
    private var topConstraint: NSLayoutConstraint!
    /// Container view used to display the "real" sheet's content
    private let contentView: UIView = {
        let content = UIView()
        content.backgroundColor = .white
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handleCloseTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// Stack view containing our actions + a cancel button
    private let actionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()


    // MARK: - Lifecycle
    required init?(coder: NSCoder) { notImplemented() }
    init(configuration: Configuration) {
        self.contentSize = configuration.size
        self.animated = configuration.animated

        super.init(nibName: nil, bundle: nil)
        makeContentView()
        makeSheet()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.roundCorners([.topLeft, .topRight], radius: 8)
        showSheet(animated)
    }

    /// Make the content view container and layout its subview(s)
    private func makeContentView() {
        contentView.addSubview(closeButton)
        contentView.addSubview(actionsStack)
        NSLayoutConstraint.activate([
            closeButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottomOffset),

            actionsStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            actionsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actionsStack.bottomAnchor.constraint(equalTo: closeButton.topAnchor),
            actionsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    /// Make the sheet and layout its content view
    ///
    /// This function initially gives an "offseted" bottom constraint so that we can animated it manually once the
    /// view did appear.
    private func makeSheet() {
        modalPresentationStyle = .overFullScreen
        view.addSubview(contentView)

        topConstraint = contentView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: contentSize.constant),
            topConstraint,
        ])

        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }

    /// Handle the pan gesture used to grow or shrink the sheet
    @objc
    private func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let verticalTranslationMagnitude = translation.y.magnitude
        let velocity = sender.velocity(in: view)

        switch sender.state {
        case .began, .changed:
            guard translation.y > 0 else { return }
            let newTopConstraintValue = contentSize.constant - verticalTranslationMagnitude
            topConstraint.constant = -newTopConstraintValue

        case .cancelled, .ended:
            guard translation.y > 0 else { return }
            if verticalTranslationMagnitude > contentSize.constant / 2 || velocity.y > 1000 {
                hideSheet(animated)
                return
            }
            showSheet(animated)

        default:
            break
        }
    }

    /// Handle a tap on the close button
    @objc
    private func handleCloseTap() {
        hideSheet(animated)
    }
}

// MARK: - Sheet manipulation
extension ActionSheetViewController {
    /// Add an action to the sheet
    ///
    /// The action stack starts empty, you need to add the actions before presenting the sheet to the user
    func addAction(_ sheetAction: SheetAction) {
        let sheetActionView = SheetActionView(action: sheetAction)
        actionsStack.addArrangedSubview(sheetActionView)
    }

    /// Put the sheet content view in the user space
    ///
    /// Initially, the contentview is out of screen so that we can animate it with the backdrop view.
    ///
    /// - parameters:
    ///     - animated: Should the sheet apparition be animated
    private func showSheet(_ animated: Bool) {
        showBackdrop(animated)
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
                self.topConstraint.constant = -self.contentSize.constant
                self.view.layoutIfNeeded()
            } completion: { _ in }
        } else {
            self.topConstraint.constant = -self.contentSize.constant
            self.view.layoutIfNeeded()
        }
    }

    /// Place the black backdrop behind the sheet's content view
    ///
    /// This is the reason we animate the sheet manually. Using the system animation would give an awkward animation
    /// so we animate the opacity instead.
    ///
    /// You should not invoke this method directly as `showSheet` will invoke it for you
    ///
    /// - parameters:
    ///     - animated: Should the backdrop apparition be animated
    private func showBackdrop(_ animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
                self.view.backgroundColor = .black.withAlphaComponent(0.4)
            } completion: { _ in }
        } else {
            self.view.backgroundColor = .black.withAlphaComponent(0.4)
        }
    }

    /// Remove the sheet from the user space
    ///
    /// - parameters:
    ///     - animated: Should the sheet disparition be animated
    private func hideSheet(_ animated: Bool) {
        hideBackdrop(animated)

        self.topConstraint.constant = 0
        if animated {
            UIView.animate(withDuration: 0.24, delay: 0, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.dismiss(animated: animated, completion: nil)
            }
        } else {
            self.view.layoutIfNeeded()
            dismiss(animated: animated, completion: nil)
        }
    }

    /// Remove the black backdrop behind the sheet's content view
    ///
    /// You should not invoke this method directly as `hideSheet` will invoke it for you
    ///
    /// - parameters:
    ///     - animated: Should the backdrop disparition be animated
    private func hideBackdrop(_ animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
                self.view.backgroundColor = .clear
            } completion: { _ in }
        } else {
            self.view.backgroundColor = .clear
        }
    }
}
