//
//  AppNavigationComponent.swift
//  Faces
//
//  Created by Tom Rochat on 20/01/2022.
//

import Foundation
import NeedleFoundation
import UIKit

protocol AppNavigationBuilder {
    var router: AppNavigationRouter { get }
    var appNavigationViewController: UIViewController { get }
}

final class AppNavigationComponent: Component<EmptyDependency>, AppNavigationBuilder {
    let router = AppNavigationRouter()
//    lazy var router: AppNavigationRouter = {
//        let router = AppNavigationRouter()
//        router.start(with: appNavigationViewController)
//        return router
//    }()

    var appNavigationViewController: UIViewController {
        AppNavigationViewController(viewModel: appNavigationViewModel)
    }

    private var appNavigationViewModel: AppNavigationViewModel {
        AppNavigationViewModel(builder: self)
    }
}

// Trying things
protocol Router {
    var root: UIViewController? { get set }
}

final class AppNavigationRouter: Router {
    weak var root: UIViewController?

    func start(with viewController: UIViewController) {
        print("did start")
        self.root = viewController
    }

    func presentRedController() {
        assert(root != nil)
        root?.present(RedViewController(nibName: nil, bundle: nil), animated: true, completion: nil)
    }

    func goToRedController() {
        assert(root != nil)
        assert(root?.navigationController != nil)
        root?.navigationController?.pushViewController(RedViewController(nibName: nil, bundle: nil), animated: true)
    }

    func goToColoredController(_ color: UIColor) {
        assert(root != nil)
        assert(root?.navigationController != nil)
        let vc = RedViewController(nibName: nil, bundle: nil)
        vc.view.backgroundColor = color
        root?.navigationController?.pushViewController(vc, animated: true)
    }
}

final class RedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
    }
}
