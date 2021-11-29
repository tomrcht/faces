//
//  AsyncViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import Combine

final class AsyncViewModel: ConnectedViewModel {
    let builder: AsyncBuilder
    var bag = Set<AnyCancellable>()

    init(builder: AsyncBuilder) {
        self.builder = builder
    }
}
