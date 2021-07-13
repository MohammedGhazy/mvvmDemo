//
//  UIViewController+Ext.swift
//  MVVMWithRxSwiftExample
//
//  Created by Mohamed Ghazy on 11/07/2021.
//

import Foundation
import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func showProgressIndicator() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor  = .systemBackground
        containerView.alpha            = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.7
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissIndicator() {
        DispatchQueue.main.async {
            containerView?.removeFromSuperview()
            containerView = nil
        }
    }
}
