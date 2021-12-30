//
//  ConnectivityComponent.swift
//  Faces
//
//  Created by Tom Rochat on 25/12/2021.
//

import Foundation
import NeedleFoundation
import UIKit

protocol ConnectivityBuilder {
    var connectivityViewController: UIViewController { get }
}

protocol ConnectivityDependencies: Dependency {
    var connectivityService: ConnectivityService { get }
}

final class ConnectivityComponent: Component<ConnectivityDependencies>, ConnectivityBuilder {
    var connectivityViewController: UIViewController {
        ConnectivityViewController(viewModel: connectivityViewModel)
    }

    private var connectivityViewModel: ConnectivityViewModel {
        ConnectivityViewModel(builder: self, connectivityService: dependency.connectivityService)
    }
}
