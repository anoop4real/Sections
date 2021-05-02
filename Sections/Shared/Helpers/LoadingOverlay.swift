//
//  LoadingOverlay.swift
//
//  Created by Anoop Mohanan on 2021-02-16.
//

import Foundation

import UIKit
/// A helper class to show loading indicator for long running tasks
final class LoadingOverlay {
    private var overlayView = ViewFactory.createASimpleUIView(with: UIColor.black, cornerRadius: 10.0)
    private var activityIndicator = UIActivityIndicatorView()
    private var bgView = ViewFactory.createASimpleUIView(with: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5))
    private var hintlabel = ViewFactory.createSimpleLabelWith(textColor: UIColor.white, font: UIFont.boldSystemFont(ofSize: 20.0))
    
    private weak var parentView: UIView!
    
    private var isVisible = false
    private init() {}

    private static let _shared = LoadingOverlay()
    class var shared: LoadingOverlay {
        return _shared
    }
    
    public func showOverlay(view: UIView, hint: String = "") {
        if !isVisible {
            parentView = view
            parentView.addSubview(bgView)
            bgView.addSubview(overlayView)
            bgView.addSubview(hintlabel)
            overlayView.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(
                [
                    bgView.topAnchor.constraint(equalTo: parentView.topAnchor),
                    bgView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                    bgView.leftAnchor.constraint(equalTo: parentView.leftAnchor),
                    bgView.rightAnchor.constraint(equalTo: parentView.rightAnchor),
                    
                    overlayView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
                    overlayView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
                    overlayView.widthAnchor.constraint(equalToConstant: 80.0),
                    overlayView.heightAnchor.constraint(equalToConstant: 80.0),
                    
                    hintlabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
                    hintlabel.centerYAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: 40),
                    hintlabel.heightAnchor.constraint(equalToConstant: 40.0),
                    
                    activityIndicator.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
                    activityIndicator.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
                ]
            )
            hintlabel.text = hint
            activityIndicator.style = UIActivityIndicatorView.Style.large
            activityIndicator.color = .white
            activityIndicator.startAnimating()
            isVisible = true
        } else {
            hintlabel.text = hint
        }
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        if parentView != nil {
            if parentView.subviews.contains(bgView) {
                bgView.removeFromSuperview()
                isVisible = false
            }
        }
        hintlabel.text = ""
        isVisible = false
    }
}
