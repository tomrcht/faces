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

final class HomeViewModel: ConnectedViewModel, RoutedViewModel {
    let dataSource: [NavigationCell.Data] = [
        .init(title: "Image zoom", iconName: "plus.magnifyingglass", tag: .zoom),
        .init(title: "Async", iconName: "timelapse", tag: .async),
        .init(title: "Keyframe", iconName: "play.circle", tag: .keyframe),
        .init(title: "Core Animation", iconName: "play.circle.fill", tag: .coreAnimation),
        .init(title: "Custom sheet", iconName: "arrow.up.doc", tag: .customSheet),
        .init(title: "Connectivity", iconName: "wifi.circle", tag: .connectivity),
        .init(title: "Alert window", iconName: "macwindow", tag: .alertWindow),
        .init(title: "Instagram stories scrollview", iconName: "circle.dotted", tag: .stories)
    ]

    let router: HomeRouter

    // MARK: - Actions triggers
    let onRowSelected = PassthroughSubject<Int, Never>()
    var bag = Set<AnyCancellable>()

    // MARK: - Lifecycle
    init(builder: HomeBuilder) {
        self.router = HomeRouter(builder: builder)
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
            router.goToZoom()
        case .async:
            router.goToAsync()
        case .keyframe:
            router.goToKeyframe()
        case .coreAnimation:
            router.goTocoreAnimation()
        case .customSheet:
            router.goToCustomSheet()
        case .connectivity:
            router.goToconnectivity()
        case .alertWindow:
            router.goToAlertWindow()
        case .stories:
            router.goToStories()
        }
    }
}
