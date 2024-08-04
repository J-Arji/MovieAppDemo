//
//  Extention.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation

import UIKit
extension UIImageView {
    // Retrieve the ImageDownloader instance from Factory
 

    func setImage(from url: String?, placeholder: UIImage? = nil) {
        guard let url = url else {
            DispatchQueue.main.async { [weak self] in
                self?.image = placeholder
            }
            return
        }

        Task.detached(priority: .background) {
            do {
                let image = try await ImageDownloader.shared.image(fromURL: url)
                // Ensure we're on the main thread to update UI
             
                await MainActor.run {
                    self.image = image
                }
            } catch {
                print("Failed to load image: \(error)")
                // Handle error or set a placeholder image if needed
                await MainActor.run {
                    self.image = placeholder
                }
            }
        }
    }
}
