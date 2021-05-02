//
//  ConnectivityManager.swift
//  JSONToCoreDataAgain
//
//  Copyright © 2019 anoop. All rights reserved.
//

import Foundation
import Combine

class ConnectivityMananger: NSObject {

    private override init() {
        super.init()
        setupReachability()
    }
    @Published private (set) var isConnected: Bool = true
    private static let _shared = ConnectivityMananger()

    class func shared() -> ConnectivityMananger {

        return _shared
    }

    private let reachability = try! Reachability()

    var isNetworkAvailable: Bool {
        return reachability.connection != .unavailable
    }


    private func setupReachability() {
        self.isConnected = isNetworkAvailable
        reachability.whenReachable = {[weak self] _ in
            self?.isConnected = true
            print("Connected")
        }
        reachability.whenUnreachable = {[weak self] _ in
            self?.isConnected = false
            print("Disconnected")
        }
    }

    func startListening() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    func stopListening() {
        reachability.stopNotifier()
    }
}

