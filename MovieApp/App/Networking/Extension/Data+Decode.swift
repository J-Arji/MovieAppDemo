//
//  Data+Decode.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: AnyDecoder {}


extension Data {
    func decoded<T: Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> T {
        do {
            return try decoder.decode(T.self, from: self)
        } catch {
            throw DataTransferError.decode(error)
        }
    }
    
    func decodedError(using decoder: AnyDecoder = JSONDecoder()) -> Error {
        do {
            let error = try decoder.decode(ErrorModel.self, from: self)
            return DataTransferError.Network.network(code: error.code, message: error.message)
        } catch {
            return DataTransferError.Network.badRequest(self)
        }
    }
    
     func decode<T: Decodable> (responseModel: T.Type) throws -> T {
      return try JSONDecoder().decode(responseModel, from: self)
    }
}


extension Data {
    func handleResponse(response: URLResponse) throws -> Data {
        guard let response = response as? HTTPURLResponse else { throw DataTransferError.noResponse }
        switch response.statusCode {
        case 200...299:
            return self
        default:
            guard let error = try? self.decode(responseModel: ErrorModel.self) else {
                throw DataTransferError.Network.badRequest(self)
            }
            throw DataTransferError.Network.network(code: response.statusCode, message: error.message)
            
        }
    }
}
