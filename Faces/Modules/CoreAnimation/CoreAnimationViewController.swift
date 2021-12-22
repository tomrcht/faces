//
//  CoreAnimationViewController.swift
//  Faces
//
//  Created by Tom Rochat on 12/12/2021.
//

import Foundation
import UIKit

final class CoreAnimationViewController: UIViewController {
    // MARK: - UI Components
    private let moveXButton: UIButton = {
        let button = UIButton()
        button.setTitle("move X", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(animateBezierLine), for: .touchUpInside)
        return button
    }()

    private let redSquare: UIView = {
        let square = UIView()
        square.backgroundColor = .red
        return square
    }()

    // MARK: - Properties
    private var shapeLayer: CAShapeLayer?

    // MARK: - Lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(moveXButton)
        moveXButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(UIEdgeInsets.bottom(8))
            make.leading.equalToSuperview().inset(UIEdgeInsets.left(16))
        }

        view.addSubview(redSquare)
        redSquare.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }

    @objc
    private func animateBezierLine() {
        shapeLayer?.removeFromSuperlayer()

        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = view.center.x
        animation.toValue = view.bounds.width
//        animation.duration = 0.5
//        animation.repeatCount = 2
//        animation.autoreverses = true

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0
//        scaleAnimation.duration = 0.5
//        animation.repeatCount = 2
//        animation.autoreverses = true

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation, scaleAnimation]
        animationGroup.duration = 1
        animation.repeatCount = 2
        animationGroup.autoreverses = true

        redSquare.layer.add(animationGroup, forKey: "moveXAnimation")
    }
}
