//
//  ToastComponent.swift
//  Faces
//
//  Created by Tom Rochat on 27/02/2022.
//

import Foundation
import NeedleFoundation
import UIKit

protocol ToastBuilder {
    var toastViewController: UIViewController { get }
}

final class ToastComponent: Component<EmptyDependency>, ToastBuilder {
    var toastViewController: UIViewController {
        ToastViewController(viewModel: toastViewModel)
    }

    private var toastViewModel: ToastViewModel {
        ToastViewModel()
    }
}
