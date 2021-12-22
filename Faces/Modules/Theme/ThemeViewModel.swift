//
//  ThemeViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 14/12/2021.
//

import Foundation
import Combine

final class ThemeViewModel: ConnectedViewModel {
    var bag = Set<AnyCancellable>()

    let themeManager: ThemeManager
    let builder: ThemeBuilder

    init(builder: ThemeBuilder, themeManager: ThemeManager) {
        self.themeManager = themeManager
        self.builder = builder
    }
}
