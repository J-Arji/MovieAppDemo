//
//  String + Localize.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
//MARK: - Constant text
extension String {
    //MARK: - button
    static func buttons(_ button: ButtonText, _ variables: [CVarArg] = []) -> String {
        String(localized: button.rawValue)
    }
    
    //MARK: - label
    static func labels(_ title: LabelText) -> String {
        String(localized: title.rawValue)
    }

}
