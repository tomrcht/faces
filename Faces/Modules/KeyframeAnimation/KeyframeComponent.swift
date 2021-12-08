//
//  KeyframeComponent.swift
//  Faces
//
//  Created by Tom Rochat on 08/12/2021.
//

import Foundation
import UIKit
import NeedleFoundation

protocol KeyframeBuilder {
    var keyframeController: UIViewController { get }
}

final class KeyframeComponent: Component<EmptyDependency>, KeyframeBuilder {
    override init(parent: Scope) {
        super.init(parent: parent)
    }

    var keyframeController: UIViewController {
        KeyframeViewController()
    }
}
