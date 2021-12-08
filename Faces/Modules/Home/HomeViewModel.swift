//
//  HomeViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 31/10/2021.
//

import Foundation
import Combine
import NeedleFoundation
import UIKit

final class HomeViewModel: ConnectedViewModel, RoutingViewModel {
    let dataSource: [NavigationCell.Data] = [
        .init(title: "Image zoom", iconName: "plus.magnifyingglass", tag: .zoom),
        .init(title: "Async", iconName: "timelapse", tag: .async),
        .init(title: "Keyframe", iconName: "play.circle", tag: .keyframe)
    ]

    let builder: HomeBuilder

    // MARK: - Actions triggers
    let router = PassthroughSubject<RouterEvent, Never>()
    let onRowSelected = PassthroughSubject<Int, Never>()
    var bag = Set<AnyCancellable>()

    // MARK: - Lifecycle
    init(builder: HomeBuilder) {
        self.builder = builder
        setup()
    }

    private func setup() {
        onRowSelected.sink { [unowned self] in
            self.didSelectRow(at: $0)
        }.store(in: &bag)
    }

    // MARK: - Actions
    private func didSelectRow(at index: Int) {
        guard index < dataSource.count else {
            assertionFailure("index is invalid")
            return
        }

        switch dataSource[index].tag {
        case .zoom:
            router.send(.push(builder.zoomViewController))
        case .async:
            router.send(.push(builder.asyncViewController))
        case .keyframe:
            router.send(.push(builder.keyframeController))
        }
    }
}
