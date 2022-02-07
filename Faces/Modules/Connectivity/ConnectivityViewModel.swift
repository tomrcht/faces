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

    private let connectivityService: ConnectivityService

    init(connectivityService: ConnectivityService) {
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
