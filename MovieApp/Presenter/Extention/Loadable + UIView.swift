//
//  Loadable.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit


public protocol Loadable {
    func startLoading()
    func stopLoading()
}


// MARK: - UIView
public extension Loadable where Self: UIView {
    
    func startLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        activityIndicator.tag = Constants.loadingViewTag
        
        isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        subviews.forEach { subview in
            if subview.tag == Constants.loadingViewTag {
                subview.removeFromSuperview()
            }
        }
        isUserInteractionEnabled = true
    }
}




private struct Constants {
    fileprivate static let loadingViewTag = 0111
}
