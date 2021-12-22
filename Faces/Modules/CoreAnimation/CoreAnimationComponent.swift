//
//  CoreAnimationComponent.swift
//  Faces
//
//  Created by Tom Rochat on 12/12/2021.
//

import Foundation
import UIKit
import NeedleFoundation

protocol CoreAnimationBuilder {
    var coreAnimationController: UIViewController { get }
}

final class CoreAnimationComponent: Component<EmptyDependency>, CoreAnimationBuilder {
    var coreAnimationController: UIViewController {
        CoreAnimationViewController()
    }
}
