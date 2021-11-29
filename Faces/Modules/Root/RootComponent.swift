//
//  RootComponent.swift
//  Faces
//
//  Created by Tom Rochat on 31/10/2021.
//

import Foundation
import NeedleFoundation
import UIKit

final class RootComponent: BootstrapComponent {
    var rootViewController: UIViewController {
        RootViewController(homeBuilder: homeBuilder)
    }

    var homeBuilder: HomeBuilder {
        HomeComponent(parent: self)
    }

    var zoomBuilder: ZoomBuilder {
        ZoomComponent(parent: self)
    }

    var asyncBuilder: AsyncBuilder {
        AsyncComponent(parent: self)
    }
}
