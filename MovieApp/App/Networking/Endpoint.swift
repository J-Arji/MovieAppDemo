//
//  Endpoint.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
protocol Endpoint {
    var baseUrl: String              { get }
    var path: String                 { get }
    var method: HTTPMethod           { get }
    var headers: [String: String]?   { get }
    var body: [String: Any]?         { get }
    var queryItems: [URLQueryItem]?  { get }
}

extension Endpoint {
    var baseUrl: String { return API.base.url }
    var headers: [String: String]? { nil }
    var body: [String: Any]? { nil }
}


extension Endpoint {
    // This `asURLRequest()` function is part of the `Endpoint` protocol extension in Swift. It is a
    // method that converts the endpoint information into a `URLRequest` object that can be used to
    // make network requests.
    public func asURLRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseUrl.appending(path)) else {
            throw DataTransferError.Network.invalidURL
        }
        urlComponents.queryItems = queryItems
        /// set the path and create the complete url
        guard let url = urlComponents.url else {
            throw DataTransferError.Network.invalidURL
        }
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        // set the header
        request.allHTTPHeaderFields = headers
        request.httpBody = body?.jsonData

        return request
    }
}
