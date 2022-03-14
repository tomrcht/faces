//
//  StacksComponent.swift
//  Faces
//
//  Created by Tom Rochat on 14/03/2022.
//

import Foundation
import NeedleFoundation
import UIKit

protocol StacksBuilder {
    var stacksViewController: UIViewController { get }
}

final class StacksComponent: Component<EmptyDependency>, StacksBuilder {
    var stacksViewController: UIViewController {
        StacksViewController(nibName: nil, bundle: nil)
    }
}
