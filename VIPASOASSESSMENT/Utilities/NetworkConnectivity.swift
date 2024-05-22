//
//  NetworkConnectivity.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Combine
import Foundation
import Network
import RxSwift

class NetworkConnectivity {
    // This is Used in one place (Network - error handling) and it is not effecient to be singelton. however, typically it is used in different places in actual applications.
    static let shared = NetworkConnectivity()

    private let pathMonitor = NWPathMonitor()
    private let pathMonitorQueue = DispatchQueue(label: "network-connectivity-monitor")
    
    let isConnectedSubject: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    var isConnected: Bool {
        pathMonitor.currentPath.status == .satisfied
    }
    
    init() {
        pathMonitor.start(queue: pathMonitorQueue)
        setupPathMonitor()
    }

    private func setupPathMonitor() {
        pathMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnectedSubject.onNext(path.status == .satisfied)
        }
    }
}
