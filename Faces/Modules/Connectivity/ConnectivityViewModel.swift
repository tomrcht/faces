//
//  ConnectivityViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 25/12/2021.
//

import Foundation
import Combine

final class ConnectivityViewModel: ConnectedViewModel {
    let isMonitoring: CurrentValueSubject<Bool, Never>
    var bag = Set<AnyCancellable>()

    let builder: ConnectivityBuilder
    private let connectivityService: ConnectivityService

    init(builder: ConnectivityBuilder, connectivityService: ConnectivityService) {
        self.builder = builder
        self.connectivityService = connectivityService

        self.isMonitoring = self.connectivityService.isMonitoring
    }

    func startMonitoring() {
        connectivityService.startMonitoring()
    }

    func stopMonitoring() {
        connectivityService.stopMonitoring()
    }
}
