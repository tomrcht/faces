//
//  InstaCircleView.swift
//  Faces
//
//  Created by Tom Rochat on 16/03/2022.
//

import Foundation
import UIKit

final class InstaCircleView: UIView {
    // MARK: - lifecycle
    required init?(coder: NSCoder) { notImplemented() }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(diameter: CGFloat, color: UIColor) {
        self.init(frame: .zero)
        commonInit(diameter: diameter, color: color)
    }

    private func commonInit(diameter: CGFloat, color: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color

        clipsToBounds = true
        layer.cornerRadius = diameter / 2

        // don't do this kids
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: diameter),
            heightAnchor.constraint(equalToConstant: diameter),
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reactToTouch))
        addGestureRecognizer(tapGesture)
    }

    @objc
    private func reactToTouch() {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1, 1.05, 1.1, 1.05, 1]
        animation.duration = 0.25
        animation.calculationMode = .cubic
        layer.add(animation, forKey: "scale")
    }
}
