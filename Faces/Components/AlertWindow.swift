//
//  AlertWindow.swift
//  Faces
//
//  Created by Tom Rochat on 16/02/2022.
//

import UIKit

final class AlertWindow: UIWindow {
    // MARK: - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        commonInit()
    }
    required init?(coder: NSCoder) {
        notImplemented()
    }

    private func commonInit() {
        windowLevel = .alert
    }

    // override hit testing, always disallowed for now, ideally just disable it if outside the root view controller
    // subviews
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        nil
    }
}
