//
//  DataTransferError.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

enum DataTransferError: Error {
    case decode(Error)
    case noResponse
    case unknown(String)
    case network(Network)
    

}
extension DataTransferError {
    enum Network: Error {
        case noNetworkConnectivity
        case network(code: Int, message: String)
        case badRequest(Data)
        case invalidURL
        
        var description: String {
            switch self {
            case .noNetworkConnectivity: return "no network connectivity"
            case .badRequest: return "Bad Request"
            case .invalidURL: return "Invalid URL"
            case .network(_, let message): return message
            }
        }
    }

}

extension DataTransferError {
    var description: String {
        switch self {
        case let .decode(error): return "Parsing error: \(error.localizedDescription)"
        case .noResponse: return "The server not responding"
        case let .network(error): return error.description
        case let .unknown(text): return text
            
        }
    }
}
