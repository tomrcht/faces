//
//  StoriesViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 14/03/2022.
//

import Foundation
import Combine
import UIKit

final class StoriesViewModel: ConnectedViewModel {
    var bag = Set<AnyCancellable>()

    private let colors: [UIColor] = [
        .systemBlue,
        .systemRed,
        .systemPink,
        .systemTeal,
        .systemPurple,
        .systemCyan,
        .systemMint,
        .systemBrown,
    ]

    func getRandomColor() -> UIColor {
        colors.randomElement()!
    }
}
