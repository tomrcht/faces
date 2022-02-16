//
//  ActionSheet+Configuration.swift
//  Faces
//
//  Created by Tom Rochat on 03/01/2022.
//

import Foundation
import UIKit

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
