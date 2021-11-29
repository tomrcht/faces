//
//  AsyncComponent.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import UIKit
import NeedleFoundation

protocol AsyncBuilder {
    var asyncViewController: UIViewController { get }
}

final class AsyncComponent: Component<EmptyDependency>, AsyncBuilder {
    var asyncViewController: UIViewController {
        AsyncViewController(viewModel: asyncViewModel)
    }

    var asyncViewModel: AsyncViewModel {
        AsyncViewModel(builder: self)
    }
}
