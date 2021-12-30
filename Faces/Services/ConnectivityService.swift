//
//  ConnectivityService.swift
//  Faces
//
//  Created by Tom Rochat on 25/12/2021.
//

import Foundation
import Network
import Combine

/// Service that checks the current connectivity status
final class ConnectivityService {
    let isMonitoring = CurrentValueSubject<Bool, Never>(false)
    let connectivityStatus = CurrentValueSubject<Status, Never>(.unknown)

    private var monitor: NWPathMonitor?
    private let monitorQueue = DispatchQueue(label: "com.faces.network-monitor", qos: .utility)

    /// Start the network monitoring
    func startMonitoring() {
        monitor = NWPathMonitor()
        monitor!.pathUpdateHandler = { [weak self] path in
            switch path.status {
            case .satisfied:
                let status = Status.ok(constrained: path.isConstrained, cellular: path.isExpensive)
                self?.connectivityStatus.send(status)

            case .unsatisfied:
                self?.connectivityStatus.send(.ko)

            case .requiresConnection:
                self?.connectivityStatus.send(.ko)

            @unknown default:
                self?.connectivityStatus.send(.unknown)
            }
        }

        monitor!.start(queue: monitorQueue)
        isMonitoring.send(true)
    }
    /// Stop the network monitoring
    func stopMonitoring() {
        monitor?.cancel()
        monitor = nil
        isMonitoring.send(false)
    }
}

// MARK: - Nested types
extension ConnectivityService {
    enum Status {
        case ok(constrained: Bool, cellular: Bool)
        case ko
        case unknown
    }
}
