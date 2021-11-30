//
//  GestureRecognizer+Extension.swift
//  Faces
//
//  Created by Tom Rochat on 30/11/2021.
//

import Foundation
import UIKit

extension UIGestureRecognizer.State {
    var stringValue: String {
        switch self {
        case .possible: return "possible"
        case .began: return "began"
        case .ended: return "ended"
        case .changed: return "changed"
        case .cancelled: return "cancelled"
        case .failed: return "failed"
        @unknown default:
            assertionFailure("unkown pan state")
            return "unknown"
        }
    }
}
