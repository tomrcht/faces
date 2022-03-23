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
    let circles = PassthroughSubject<InstaCircleView, Never>()
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

    func getNewCircleView(ofSize diameter: CGFloat) {
        let newCircle = InstaCircleView(diameter: diameter, color: colors.randomElement()!)
        circles.send(newCircle)
    }
}
