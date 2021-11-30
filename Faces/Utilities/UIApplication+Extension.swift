//
//  UIApplication+Extension.swift
//  Faces
//
//  Created by Tom Rochat on 30/11/2021.
//

import Foundation
import UIKit

extension UIApplication {
    static var appWindow: UIWindow? {
        UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
}
