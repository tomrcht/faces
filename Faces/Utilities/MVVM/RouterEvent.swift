//
//  RouterEvent.swift
//  Faces
//
//  Created by Tom Rochat on 05/11/2021.
//

import Foundation
import UIKit

enum RouterEvent {
    case push(UIViewController)
    case present(UIViewController)
    case pop
    case dismiss
}
