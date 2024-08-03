//
//  Stored.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
import Combine
import SimpleKeychain

enum StoredLocation {
    case standard
    case keychain
    
    func data(for key: String) -> Data? {
        switch self {
        case .keychain:
            return try? SimpleKeychain().data(forKey: key)
        case .standard:
            return UserDefaults.standard.data(forKey: key)
        }
    }
    
    func set(_ value: Data, for key: String) {
        switch self {
        case .keychain:
            try? SimpleKeychain().set(value, forKey: key)
        case .standard:
            UserDefaults.standard.set(value, forKey: key)
        }
    }
}


@propertyWrapper
struct Stored<Value: Codable> {
    let location: StoredLocation
    let key: String
    var wrappedValue: Value {
        willSet {  // Before modifying wrappedValue
            guard let value = try? JSONEncoder().encode(newValue) else {
                return
            }
            location.set(value, for: key)
        }
    }
    
    init(wrappedValue: Value, key: String, in location: StoredLocation = .standard) {
        self.location = location
        self.key = key
        var value = wrappedValue
        if let data = location.data(for: key) {
            do {
                value = try JSONDecoder().decode(Value.self, from: data)
            } catch {}
        }
        self.wrappedValue = value
    }
}


final class CancelBag {
    fileprivate(set) var subscriptions: Set<AnyCancellable> = []

    func cancel() {
        subscriptions = []
    }
}

extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
