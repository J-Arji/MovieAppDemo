//
//  ImageDownloader.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
import UIKit

actor ImageDownloader {
    static let shared = ImageDownloader()
    private init()  { }
    
    private enum CacheEntry {
        case inProgress([CheckedContinuation<UIImage, any Error>])
        case ready(UIImage)

        mutating func add(_ continuation: CheckedContinuation<UIImage, any Error>) {
            switch self {
            case .inProgress(var continuations):
                continuations.append(continuation)
                self = .inProgress(continuations)
                
            case .ready:
                break
            }
        }
    }

    private var cache: [URL: CacheEntry] = [:]

    func image(fromURL url: String) async throws -> UIImage {
        guard let path = URL(string: url) else { throw DataTransferError.unknown("data is wrong") }
        return try await image(from: path)
    }

    private func addWaitingContinuation(_ continuation: CheckedContinuation<UIImage, any Error>, for url: URL) {
        cache[url, default: .inProgress([])].add(continuation)
    }

    func image(from url: URL) async throws -> UIImage {
        if let cached = cache[url] {
            switch cached {
            case .ready(let image):
                return image
            case .inProgress:
                return try await withCheckedThrowingContinuation { continuation in
                    addWaitingContinuation(continuation, for: url)
                }
            }
        }

        cache[url] = .inProgress([])

        let image: UIImage
        do {
            image = try await remoteReqest(from: url)
        } catch {
            resumeInProgressContinuations(with: .failure(error), for: url)
            throw error
        }

        resumeInProgressContinuations(with: .success(image), for: url)

        cache[url] = .ready(image)

        return image
    }

    private func resumeInProgressContinuations(with result: Result<UIImage, any Error>, for url: URL) {
        guard case .inProgress(let continuations) = cache[url] else { return }
        for con in continuations {
            con.resume(with: result)
        }
    }
    
    private func remoteReqest(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { throw DataTransferError.unknown("data is wrong") }
        return image
    }
}
