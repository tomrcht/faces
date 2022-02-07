//
//  AsyncComponent.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import UIKit
import NeedleFoundation

protocol AsyncDependencies: Dependency {
    var kanyeService: KanyeService { get }
}

protocol AsyncBuilder {
    var asyncViewController: UIViewController { get }
}

final class AsyncComponent: Component<AsyncDependencies>, AsyncBuilder {
    var asyncViewController: UIViewController {
        AsyncViewController(viewModel: asyncViewModel)
    }

    var asyncViewModel: AsyncViewModel {
        AsyncViewModel(kanyeService: dependency.kanyeService)
    }
}
