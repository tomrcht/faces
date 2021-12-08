//
//  KeyframeViewController.swift
//  Faces
//
//  Created by Tom Rochat on 08/12/2021.
//

import UIKit
import SnapKit

final class KeyframeViewController: UIViewController {
    // MARK: - UI
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap the icon to fire animation"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .lightGray
        return label
    }()
    private let icon: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 48)
        let image = UIImage(
            systemName: "heart.fill",
            withConfiguration: configuration
        )?.withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: image)
        view.tintColor = .systemRed
        view.isUserInteractionEnabled = true
        return view
    }()

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
        view.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(UIEdgeInsets.bottom(8))
        }

        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onIconTap))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        icon.addGestureRecognizer(tapGesture)
    }

    @objc
    private func onIconTap() {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [0, 0.4, 1.1, 0.9, 1]
        animation.duration = 0.4
        animation.calculationMode = .cubic
        icon.layer.add(animation, forKey: "scale")
    }
}
