//
//  ConnectedViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import Combine

protocol ConnectedViewModel {
    associatedtype AnyBuilder

    /// Needle's component providing available view controllers / services
    var builder: AnyBuilder { get }
    /// Dispose bag that handles this view model's subscriptions
    var bag: Set<AnyCancellable> { get set }
}

protocol RoutingViewModel {
    /// Subject that dispatch router events to the associated view controller
    /// The view controller handles this event how it sees fit
    var router: PassthroughSubject<RouterEvent, Never> { get }
}
