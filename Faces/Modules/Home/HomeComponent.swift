//
//  HomeComponent.swift
//  Faces
//
//  Created by Tom Rochat on 31/10/2021.
//

import Foundation
import NeedleFoundation
import UIKit

protocol HomeBuilder {
    var viewController: UIViewController { get }
    var zoomViewController: UIViewController { get }
    var asyncViewController: UIViewController { get }
    var keyframeController: UIViewController { get }
}

final class HomeComponent: Component<EmptyDependency>, HomeBuilder {
    var viewController: UIViewController {
        HomeViewController(viewModel: homeViewModel)
    }

    private var homeViewModel: HomeViewModel {
        HomeViewModel(builder: self)
    }

    // MARK: - Builders
    private var zoomBuilder: ZoomBuilder {
        ZoomComponent(parent: self)
    }

    private var asyncBuilder: AsyncBuilder {
        AsyncComponent(parent: self)
    }

    private var keyframeBuilder: KeyframeBuilder {
        KeyframeComponent(parent: self)
    }

    // MARK: - Entry ViewControllers
    var zoomViewController: UIViewController {
        zoomBuilder.zoomViewController
    }

    var asyncViewController: UIViewController {
        asyncBuilder.asyncViewController
    }

    var keyframeController: UIViewController {
        keyframeBuilder.keyframeController
    }
}
