//
//  ThemeComponent.swift
//  Faces
//
//  Created by Tom Rochat on 14/12/2021.
//

import Foundation
import UIKit
import NeedleFoundation

protocol ThemeDependencies: Dependency {
    var themeManager: ThemeManager { get }
}

protocol ThemeBuilder {
    var themeViewController: UIViewController { get }
}

final class ThemeComponent: Component<ThemeDependencies>, ThemeBuilder {
    var themeViewController: UIViewController {
        ThemeViewController(viewModel: themeViewModel)
    }

    private var themeViewModel: ThemeViewModel {
        ThemeViewModel(themeManager: dependency.themeManager)
    }
}
