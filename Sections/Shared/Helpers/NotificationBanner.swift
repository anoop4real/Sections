//
//  NotificationBanner.swift
//

import Foundation
import UIKit

enum BannerStyle {
    case info
    case warning
    case error
    case offline
    case online
    
    var titleColor: UIColor {
        switch self {

        case .info:
            return .black
        case .warning:
            return .yellow
        case .error:
            return .white
        case .offline:
            return .white
        case .online:
            return .black
        }
    }
    
    var backgroundColor: UIColor {
        
        switch self {
        case .info:
        return .white
        case .warning:
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        case .error:
            return .red
        case .offline:
            return .red
        case .online:
            return .green
        }
    }
    
    var font: UIFont {
        
        switch self {
        case .info, .warning, .error,.offline, .online:
            return .systemFont(ofSize: 15.0)
        }
    }
}
class NotificationBanner {
  static let labelLeftMarging = CGFloat(16)
  static let labelTopMargin = CGFloat(24)
  static let animateDuration = 0.5
  static let bannerAppearanceDuration: TimeInterval = 2
  
    static func show(_ text: String, in view:UIView, style: BannerStyle = .info) {
    let superView = view

    let height = CGFloat(44)
    let width = superView.bounds.size.width

    let bannerView = UIView(frame: CGRect(x: 0, y: 0-height, width: width, height: height))
    bannerView.layer.opacity = 1
    bannerView.backgroundColor = style.backgroundColor
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    
    let label = UILabel(frame: CGRect.zero)
    label.textColor = style.titleColor
    label.font = style.font
    label.numberOfLines = 0
    label.text = text
    label.translatesAutoresizingMaskIntoConstraints = false
    
    bannerView.addSubview(label)
    superView.addSubview(bannerView)
    
    let labelCenterYContstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: bannerView, attribute: .centerY, multiplier: 1, constant: 0)
    let labelCenterXConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: bannerView, attribute: .centerX, multiplier: 1, constant: 0)
    let labelWidthConstraint = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width - labelLeftMarging*2)
    let labelTopConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: bannerView, attribute: .top, multiplier: 1, constant: labelTopMargin)
    
    let bannerWidthConstraint = NSLayoutConstraint(item: bannerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
    let bannerCenterXConstraint = NSLayoutConstraint(item: bannerView, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1, constant: 0)
        let bannerTopConstraint = NSLayoutConstraint(item: bannerView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .topMargin, multiplier: 1, constant: 0-height)
    
    NSLayoutConstraint.activate([labelCenterYContstraint, labelCenterXConstraint, labelWidthConstraint, labelTopConstraint, bannerWidthConstraint, bannerCenterXConstraint, bannerTopConstraint])
    
    UIView.animate(withDuration: animateDuration) {
      bannerTopConstraint.constant = 0
      superView.layoutIfNeeded()
    }
    
    //remove subview after time 2 sec
    UIView.animate(withDuration: animateDuration, delay: bannerAppearanceDuration, options: [], animations: {
      bannerTopConstraint.constant = 0 - bannerView.frame.height
      superView.layoutIfNeeded()
    }, completion: { finished in
      if finished {
        bannerView.removeFromSuperview()
      }
    })
  }
}
