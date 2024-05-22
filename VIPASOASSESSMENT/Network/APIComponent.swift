//
//  APIComponent.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - HTTPMethod

public enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

// MARK: - Endpoint Protocole

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var prefix: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

// MARK: - Endpoint Request Helper

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)
        components?.path = prefix + path
        components?.queryItems = queryItems
        return components!
    }

    var urlRequest: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method.rawValue

        return request
    }
}
