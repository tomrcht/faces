//
//  CustomSheetComponent.swift
//  Faces
//
//  Created by Tom Rochat on 22/12/2021.
//

import Foundation
import NeedleFoundation
import UIKit

protocol CustomSheetBuilder {
    var customSheetViewController: UIViewController { get }
}

final class CustomSheetComponent: Component<EmptyDependency>, CustomSheetBuilder {
    var customSheetViewController: UIViewController {
        CustomSheetViewController()
    }
}
