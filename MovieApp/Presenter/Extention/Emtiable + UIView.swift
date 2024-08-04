//
//  Emtiable + UIView.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit

public protocol Emptiable {
    
    func showEmptyView(with message: String?)
    
    func hideEmptyView()
}

// MARK: - UIViewController
public extension Emptiable where Self: UIView {
    
    func showEmptyView(with message: String?) {
        let emptyView = UILabel()
        emptyView.textColor = .Design.Primary.text
        emptyView.font = .Design.Body
        emptyView.textAlignment = .center
        emptyView.text = message
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(emptyView)
        
        emptyView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        emptyView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        emptyView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        emptyView.tag = Constans.emptyViewTag
    }
    
    func hideEmptyView() {
        self.subviews.forEach { subView in
            if subView.tag == Constans.emptyViewTag {
                subView.removeFromSuperview()
            }
        }
    }
}

// MARK: - Constans Emptiable
private struct Constans {
    fileprivate static let emptyViewTag = 4321
}
