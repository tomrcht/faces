//
//  UIView+Extension.swift
//  Faces
//
//  Created by Tom Rochat on 31/12/2021.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let shapeLayer = CAShapeLayer()
        let radii = CGSize(width: radius, height: radius)
        shapeLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: radii).cgPath
        layer.mask = shapeLayer
    }
}
