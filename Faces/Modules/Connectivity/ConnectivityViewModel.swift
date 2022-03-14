//
//  ConnectivityViewModel.swift
//  Faces
//
//  Created by Tom Rochat on 25/12/2021.
//

import Foundation
import Combine

final class ConnectivityViewModel: ConnectedViewModel {
    let isMonitoring = CurrentValueSubject<Bool, Never>(false)
    let connectionStatus = PassthroughSubject<ConnectivityService.Status, Never>()
    var bag = Set<AnyCancellable>()

    private let connectivityService: ConnectivityService

    init(connectivityService: ConnectivityService) {
        self.connectivityService = connectivityService
        bindService()
    }

    private func bindService() {
        connectivityService.isMonitoring.sink { [weak self] isMonitoring in
            self?.isMonitoring.send(isMonitoring)
        }
        .store(in: &bag)

        connectivityService.connectivityStatus.sink { [weak self] status in
            self?.connectionStatus.send(status)
        }
        .store(in: &bag)
    }

    func toggleMonitoring() {
        if isMonitoring.value {
            connectivityService.stopMonitoring()
        } else {
            connectivityService.startMonitoring()
        }
    }
}
