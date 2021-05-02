//
//  BaseViewController.swift
//  Sections
//
//  Created by Anoop M on 2021-05-01.
//

import Combine
import UIKit

class BaseViewController: UIViewController {
    lazy var banner = UIView(frame: .zero)
    var isConnected: Bool = false
    private var connectivitySubscriber: AnyCancellable?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConnectivitySubscribers()
        setUpView()
    }
    
    func setUpConnectivitySubscribers() {
        connectivitySubscriber = ConnectivityMananger.shared().$isConnected.sink(receiveValue: { [weak self] isConnected in
            self?.isConnected = isConnected
            self?.updateBanner()
        })
    }
    
    private func setUpView() {
        banner.translatesAutoresizingMaskIntoConstraints = false
        updateBanner()
        
        view.addSubview(banner)
        
        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            banner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            banner.heightAnchor.constraint(equalToConstant: 5),
            
        ])
    }
    
    func updateBanner() {
        view.bringSubviewToFront(banner)
        banner.backgroundColor = isConnected ? .green : .red
        if !isConnected {
            DispatchQueue.main.async { [unowned self] in
                NotificationBanner.show("You are offline, data you are viewing might be old", in: self.view, style: .offline)
            }
        }
    }
}
