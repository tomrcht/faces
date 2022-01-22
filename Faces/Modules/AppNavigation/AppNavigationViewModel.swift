//
//  AppNavigationViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 20/01/2022.
//

import Foundation
import Combine

final class AppNavigationViewModel: ConnectedViewModel {
    let builder: AppNavigationBuilder
    var bag = Set<AnyCancellable>()

    init(builder: AppNavigationBuilder) {
        self.builder = builder
    }

    func startRouter(in viewController: AppNavigationViewController) {
        builder.router.start(with: viewController)
    }

    func move() {
        builder.router.goToColoredController(.systemPurple)
    }
}
