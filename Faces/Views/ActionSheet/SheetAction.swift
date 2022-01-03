//
//  SheetAction.swift
//  Faces
//
//  Created by Tom Rochat on 03/01/2022.
//

import Foundation
import UIKit

typealias SheetActionHandler = () -> Void

struct SheetAction {
    let title: String
    let image: UIImage?
    let handler: SheetActionHandler
}

final class SheetActionView: UIStackView {
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
