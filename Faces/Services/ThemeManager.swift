//
//  ThemeManager.swift
//  Faces
//
//  Created by Tom Rochat on 14/12/2021.
//

import Foundation
import UIKit

final class ThemeManager {
    private(set) var accentColor: UIColor = .red

    func setAccentColor(to newColor: UIColor) {
        accentColor = newColor
    }
}
