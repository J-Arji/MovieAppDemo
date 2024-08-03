//
//  APIClient.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation


// MARK: - APIClient
/// This is network  layer  that it have to implement when we want  have fetch data from backend
protocol APIClient {
    var storage: StorageServicable { get set }
    
    //  MARK: - request
    ///
    /// - parameter endpoint: recive router and other config
    /// - throws: DataTransferError
    /// - returns: T
    ///
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
    
}

extension APIClient {
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
//        if !NetworkMonitor.shared.isConnected {
//            throw DataTransferError.Network.noNetworkConnectivity
//        }
        do {
            let request = try endpoint.asURLRequest()
            #if DEBUG
            print("👢", request.curlString)
            #endif
            let (dataTempo, responseTempo) = try await URLSession.shared.data(for: request, delegate: nil)
            let data = try dataTempo.handleResponse(response: responseTempo)
            return try data.decoded() as T
        } catch {
            throw error
        }
    }
}
