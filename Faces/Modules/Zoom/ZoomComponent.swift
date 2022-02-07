//
//  ZoomComponent.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import NeedleFoundation
import UIKit

protocol ZoomBuilder {
    var zoomViewController: UIViewController { get }
}

final class ZoomComponent: Component<EmptyDependency>, ZoomBuilder {
    var zoomViewController: UIViewController {
        ZoomViewController(viewModel: zoomViewModel)
    }

    private var zoomViewModel: ZoomViewModel {
        ZoomViewModel()
    }
}
