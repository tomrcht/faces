//
//  ActionSheetViewController.swift
//  Faces
//
//  Created by Tom Rochat on 30/12/2021.
//

import UIKit

final class ActionSheetViewController: UIViewController {
    private let animated: Bool
    private let contentSize: Size
    private var bottomOffset: CGFloat {
        25
    }

    // MARK: - UI components
    private var heightConstraint: NSLayoutConstraint!
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

        heightConstraint = contentView.heightAnchor.constraint(equalToConstant: contentSize.constant)
        topConstraint = contentView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightConstraint,
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

// MARK: Nested types
extension ActionSheetViewController {
    /// Defines the initial size for the sheet
    ///
    /// - `small`: 100pt
    /// - `medium`: 300pt
    /// - `full`: screen size
    /// - `custom`: user-defined values
    enum Size: Equatable {
        case small
        case medium
        case full
        case custom(CGFloat)

        var constant: CGFloat {
            switch self {
            case .small: return 100
            case .medium: return 300
            case .full: return UIScreen.main.bounds.height - 40
            case .custom(let height): return height
            }
        }
    }

    /// Configures aspects of our sheet
    struct Configuration {
        let size: Size
        let animated: Bool

        init(size: Size, animated: Bool = true) {
            self.size = size
            self.animated = animated
        }
    }
}

// MARK: - Sheet action
typealias SheetActionHandler = () -> Void
struct SheetAction {
    let title: String
    let image: UIImage?
    let handler: SheetActionHandler
}

private class SheetActionView: UIStackView {
    private let handler: SheetActionHandler

    init(action: SheetAction) {
        self.handler = action.handler
        super.init(frame: .zero)

        setupStackView(with: action)
    }

    required init(coder: NSCoder) {
        notImplemented()
    }

    private func setupStackView(with action: SheetAction) {
        axis = .horizontal
        alignment = .center
        distribution = .fillProportionally
        spacing = 16
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = .init(top: 0, leading: 16, bottom: 0, trailing: 0)

        if let image = action.image {
            let imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .black
            addArrangedSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 24),
                imageView.heightAnchor.constraint(equalToConstant: 24),
            ])
        }

        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        titleLabel.text = action.title
        titleLabel.textColor = .black
        addArrangedSubview(titleLabel)

        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(tapHandler))
        addGestureRecognizer(tapGesture)
    }

    @objc
    private func tapHandler() {
        handler()
    }
}
