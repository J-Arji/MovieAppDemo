//
//  AnyConverter.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

///A protocol for converting DTOs to domain models.
protocol AnyConverter {
    associatedtype Output
    
    func convert() -> Output
}
