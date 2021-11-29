//
//  RootViewController.swift
//  Faces
//
//  Created by Tom Rochat on 30/10/2021.
//

import UIKit

final class RootViewController: UITabBarController {
    private let homeBuilder: HomeBuilder

    // MARK: - Lifecycle
    init(homeBuilder: HomeBuilder) {
        self.homeBuilder = homeBuilder
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        notImplemented()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        tabBar.tintColor = .systemRed

        let homeVC = homeBuilder.viewController
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))

        viewControllers = [
            UINavigationController(rootViewController: homeVC),
        ]
    }
}
