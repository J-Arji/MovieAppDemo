//
//  API.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
enum API {
    case base
    case search(Subset)
    case detail(Subset, id: String)
    case image(ImageSize)
}

//MARK: - base url
extension API {
    public var url: String {
        switch self {
        case .base:  return API.baseUrl + API.versionURL
        case let .image(imageSize): return imageSize.url
        case let .search(path): return "/search" + path.path
        case let .detail(path, _): return  path.path
        
        }
    }
}

//MARK: - path
extension API {
    var path: String {
        switch self {
            
        case let .search(subset):
            return  subset.path
            
        case let .detail(subset, id):
            return subset.path + "/\(id)"
            
        case .image, .base:
            return ""
        }
    }
}

extension API {
    enum Subset {
        case movie
        case tv
        
        var path: String {
            switch self {
            case .movie:
                return "/movie"
            case .tv:
                return "/tv"

            }
        }
    }
}

//MARK: - Address
extension API{
  
    static var baseUrl: String = {
        guard let baseUrl =  Bundle.main.info(for: "API_BASE_URL")  else { fatalError("Please Set API base url") }
        return baseUrl
    }()
    
    static var versionURL: String = {
        guard let version =  Bundle.main.info(for: "VERSION_API_URL")  else { fatalError("Please Set API version") }
        return version
    }()
    static  let ImageUrl: String = {
        guard let imageBaseUrl =  Bundle.main.info(for: "IMAGE_BASE_URL")  else { fatalError("Please Set image base url") }
        return imageBaseUrl
    }()

}


//MARK: - Image URL
extension API {
    enum ImageSize {
        case original
        case small
        
        var url: String {
            switch self {
            case .original:
                return API.ImageUrl + "original"
            case .small:
                return API.ImageUrl + "w154"
            }
        }
    }
}
