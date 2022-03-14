//
//  HomeRouter.swift
//  Faces
//
//  Created by Tom Rochat on 07/02/2022.
//

import Foundation
import UIKit

final class HomeRouter: Router {
    private weak var context: UINavigationController?
    private let builder: HomeBuilder

    init(builder: HomeBuilder) {
        self.builder = builder
    }

    func start(in context: UIViewController) {
        assert(context.navigationController != nil)
        self.context = context.navigationController
    }

    func goToZoom() {
        context?.pushViewController(builder.zoomViewController, animated: true)
    }

    func goToAsync() {
        context?.pushViewController(builder.asyncViewController, animated: true)
    }

    func goToKeyframe() {
        context?.pushViewController(builder.keyframeController, animated: true)
    }

    func goTocoreAnimation() {
        context?.pushViewController(builder.coreAnimationController, animated: true)
    }

    func goToCustomSheet() {
        context?.pushViewController(builder.customSheetController, animated: true)
    }

    func goToconnectivity() {
        context?.pushViewController(builder.connectivityViewController, animated: true)
    }

    func goToAlertWindow() {
        context?.pushViewController(builder.alertWindowController, animated: true)
    }

    func goToStacks() {
        context?.pushViewController(builder.stacksController, animated: true)
    }
}
