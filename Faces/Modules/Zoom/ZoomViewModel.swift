//
//  ZoomViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 29/11/2021.
//

import Foundation
import Combine

final class ZoomViewModel: ConnectedViewModel {
    let builder: ZoomBuilder
    var bag = Set<AnyCancellable>()

    init(builder: ZoomBuilder) {
        self.builder = builder
    }
}
