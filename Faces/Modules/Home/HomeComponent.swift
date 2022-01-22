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
    var coreAnimationController: UIViewController { get }
    var themeController: UIViewController { get }
    var customSheetController: UIViewController { get }
    var connectivityViewController: UIViewController { get }
    var appNavigationViewController: UIViewController { get }
}

final class HomeComponent: Component<EmptyDependency>, HomeBuilder {
    var viewController: UIViewController {
        HomeViewController(viewModel: homeViewModel)
    }

    private var homeViewModel: HomeViewModel {
        HomeViewModel(builder: self)
    }

    // MARK: - Entry ViewControllers
    var zoomViewController: UIViewController { zoomBuilder.zoomViewController }
    var asyncViewController: UIViewController { asyncBuilder.asyncViewController }
    var keyframeController: UIViewController { keyframeBuilder.keyframeController }
    var coreAnimationController: UIViewController { coreAnimationBuilder.coreAnimationController }
    var themeController: UIViewController { themeBuilder.themeViewController }
    var customSheetController: UIViewController { customSheetBuilder.customSheetViewController }
    var connectivityViewController: UIViewController { connectivityBuilder.connectivityViewController }
    var appNavigationViewController: UIViewController { appNavigationBuilder.appNavigationViewController }

    // MARK: - Builders
    private var zoomBuilder: ZoomBuilder { ZoomComponent(parent: self) }
    private var asyncBuilder: AsyncBuilder { AsyncComponent(parent: self) }
    private var keyframeBuilder: KeyframeBuilder { KeyframeComponent(parent: self) }
    private var coreAnimationBuilder: CoreAnimationBuilder { CoreAnimationComponent(parent: self) }
    private var themeBuilder: ThemeBuilder { ThemeComponent(parent: self) }
    private var customSheetBuilder: CustomSheetBuilder { CustomSheetComponent(parent: self) }
    private var connectivityBuilder: ConnectivityBuilder { ConnectivityComponent(parent: self) }
    private var appNavigationBuilder: AppNavigationBuilder { AppNavigationComponent(parent: self) }
}
