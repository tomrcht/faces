//
//  Router.swift
//  Faces
//
//  Created by Tom Rochat on 07/02/2022.
//

import Foundation
import UIKit

protocol Router {
    associatedtype AnyBuilder

    init(builder: AnyBuilder)
    /// Start the router in the given context
    func start(in context: UIViewController)
}
