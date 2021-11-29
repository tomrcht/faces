//
//  ConnectedViewController.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import Combine

protocol ConnectedViewController {
    associatedtype AnyViewModel: ConnectedViewModel

    /// The view model associates to this view controller
    var viewModel: AnyViewModel { get }
    var bag: Set<AnyCancellable> { get set }

    init(viewModel: AnyViewModel)

    /// Bind the view controller and it's view model
    func bindViewModel()
}

/// Protocol that implements any routing capabilities inside a view controller
protocol RoutableViewController {
    /// React to any router event dispatched by the view model
    func onRouterEvent(_ event: RouterEvent)
}
