//
//  AlertWindowComponent.swift
//  Faces
//
//  Created by Tom Rochat on 16/02/2022.
//

import Foundation
import UIKit
import NeedleFoundation

protocol AlertWindowBuilder {
    var alertWindowViewController: UIViewController { get }
}

final class AlertWindowComponent: Component<EmptyDependency>, AlertWindowBuilder {
    var alertWindowViewController: UIViewController {
        AlertWindowViewController(nibName: nil, bundle: nil)
    }
}
