//
//  Color.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit

extension UIColor {
    struct Design {
        enum Primary {
            static let background = UIColor.white
            static let placeholder = UIColor.gray
            static let buttonTint = UIColor.systemBlue
            static let success = UIColor.systemGreen
            static let faild = UIColor.systemRed
            static let text = UIColor.white
        }
        
        enum Secondary {
            static let background = UIColor.systemBackground
        }
        
        enum Grayscale {
            static let background = UIColor.black
        }
    }
}
