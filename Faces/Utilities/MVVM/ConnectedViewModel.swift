//
//  ConnectedViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import Combine

protocol ConnectedViewModel {
    /// Dispose bag that handles this view model's subscriptions
    var bag: Set<AnyCancellable> { get set }
}

protocol RoutedViewModel {
    associatedtype AnyRouter: Router

    /// Needle's component providing available view controllers / services
    var router: AnyRouter { get }
}
