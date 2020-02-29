//
//  NetworkRequest.swift
//  Wired Reader
//
//  Created by Yura Voevodin on 29.02.2020.
//  Copyright © 2020 Yura Voevodin. All rights reserved.
//

import Foundation

/// Base class for network requests
class NetworkRequest {

    // MARK: - Properties

    static var baseURL = "https://www.wired.com"

    /// HTTP method
    var method: String {
      return "GET"
    }

    /// Path for API endpoint
    open var path: String {
      return ""
    }

    /// Request parameters
    var parameters: [String: Any]? {
      return nil
    }

    // MARK: - Methods

    /// Build URLComponents from `baseURLString`
    ///
    /// - Returns: URLComponents
    func baseURLComponents() -> URLComponents {
        return URLComponents(string: NetworkRequest.baseURL)!
    }

    func buildURLRequest(secretKey: String? = nil) -> URLRequest {
        // Request
        let urlComponents = baseURLComponents()
        let url = urlComponents.url?.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url!)

        // Method
        urlRequest.httpMethod = method

        return urlRequest
    }
}
