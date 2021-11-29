//
//  HomeComponent.swift
//  Faces
//
//  Created by Tom Rochat on 31/10/2021.
//

import Foundation
import NeedleFoundation
import UIKit

protocol HomeDependency: Dependency {
    var zoomBuilder: ZoomBuilder { get }
    var asyncBuilder: AsyncBuilder { get }
}

protocol HomeBuilder {
    var viewController: UIViewController { get }
    var zoomViewController: UIViewController { get }
    var asyncViewController: UIViewController { get }
}

final class HomeComponent: Component<HomeDependency>, HomeBuilder {
    var viewController: UIViewController {
        HomeViewController(viewModel: homeViewModel)
    }

    private var homeViewModel: HomeViewModel {
        HomeViewModel(builder: self)
    }

    var zoomViewController: UIViewController {
        dependency.zoomBuilder.zoomViewController
    }

    var asyncViewController: UIViewController {
        dependency.asyncBuilder.asyncViewController
    }
}
