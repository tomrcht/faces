//
//  ToastViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 27/02/2022.
//

import Foundation
import Combine

final class ToastViewModel: ConnectedViewModel {
    var bag = Set<AnyCancellable>()
}
